import numpy as np
import pandas as pd
import subprocess
import re
import h5py
from scipy.optimize import curve_fit
import os
import time
from write_script import write_script
import zipfile
from concurrent.futures import ThreadPoolExecutor
import itertools
file_path = 'ats_vis_data.VisIt.xmf'

# Read the file content
with open(file_path, 'r') as file:
    content = file.read()

# Regular expression to match numbers between 'h5' and 'xmf'
pattern = r"h5\.(\d+)\.xmf"
matches = re.findall(pattern, content)

# Convert matches to integers
numbers = [int(match) for match in matches]
loc=pd.read_csv('../data/mesh_cnt3.csv').iloc[:,[0,2]]
def process_index(i):
    fin=loc.copy()
    temp=loc.copy()
    with h5py.File(folder + "/ats_vis_data.h5", "r") as df:
        fin["porosity"] = df["base_porosity"][str(numbers[i])]
        fin["U"] = df["darcy_velocity.0"][str(numbers[i])]
        fin["W"] = df["darcy_velocity.2"][str(numbers[i])]
        fin["k"] = df["permeability"][str(numbers[i])]
        fin["sat"] = df["saturation_liquid"][str(numbers[i])]
        fin["time"] = i
        temp["h"] = df["pressure"][str(numbers[i])]
    return fin, temp
with ThreadPoolExecutor(max_workers=80) as executor:
    results = list(executor.map(process_index, range(len(numbers))))

out = pd.concat([r[0] for r in results])
pressure = pd.concat([r[1] for r in results])

#Assign homogeneous resistivity from field data
df=out.copy()
df['cond']=0
df['cond'][df["porosity"]>=0.4]=1/40# 40 original used
df['cond'][df["porosity"]<0.4]=1/800
df1=df.iloc[:,[0,1,7,3,4,2,6,8,5]]
df1.columns = ['X', 'Z', 't', 'U','W', 'Por','sat','cond','Perm']
df1['m']=1.5
df1['Qv']=0
pressure.h=pressure.h-101325
n_vg=1.283647
m_vg=(n_vg-1)/n_vg #Soldi et al, 2019
alpha=4.9e-05
pressure['sat']=0
pressure['sat']=-0.1+(1+abs(alpha*pressure['h'])**n_vg)**-m_vg
pressure['sat'][pressure['h']>0]=1
rel_perm=pressure['sat']**0.5*(1-(1-pressure['sat']**(1/m_vg))**m_vg)**2 #Soldi et al, 2019
#Calculating Qv from REV method
e0 = 1.602e-19   # Elementary charge (C)   
C0=200*1.3e-5 # fluid conc. from 0.02 S/m using eqn from Griffin and Jurinak
E=80.1*8.854e-12 # F/m
kB=1.381e-23
T=273.15+20
tau=df1["Por"]**(1-df1['m'])
phi=df1["Por"]
k=df1['Perm']
zeta=-0.00643+0.02085*np.log10(C0)
df1['Qv']=(E*(-zeta-zeta**3*(((e0) / ( kB * T))**2)/54)*(1 / tau**2) * (phi / k))*pressure['sat']/rel_perm #Soldi et al, 2019
times=[-1]+list(itertools.accumulate([len(numbers) // 10] * 10 + [len(numbers) % 10]))
for i in range(len(numbers)+1):
    filt=df[(df['t']>=times[i]+1)&(df['t']<times[i+1]+1)]
    df1.to_csv('data_set_edit_short'+str(times[i+1]+1)+'.txt',index=False)
def save_filtered(i):
    filt = df[(df['t'] >= times[i] + 1) & (df['t'] < times[i+1] + 1)]
    filename = f"data_set_edit_short{times[i+1] + 1}.txt"
    filt.to_csv(filename, index=False)

# Run in parallel
with ThreadPoolExecutor(max_workers=11) as executor:  # adjust workers if needed
    executor.map(save_filtered, range(len(numbers) + 1))
