import numpy as np
import pandas as pd
import subprocess
import re
import h5py
from scipy.optimize import curve_fit
import os
import time
#from write_script import write_script
import zipfile
param=np.loadtxt('../param3.txt') 
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
for i in range(len(numbers)):
    fin=loc.copy()
    temp=loc.copy()
    df=h5py.File('ats_vis_data.h5', 'r')
    fin['porosity']=df['base_porosity'][str(numbers[i])]
    fin['U']=df['darcy_velocity.0'][str(numbers[i])]
    fin['W']=df['darcy_velocity.2'][str(numbers[i])]
    fin['k']=df['permeability'][str(numbers[i])]
    fin['sat']=df['saturation_liquid'][str(numbers[i])]
    fin['time']=i
    temp['h']=df['pressure'][str(numbers[i])]
    if i==0:
        out=fin.copy()
        pressure=temp.copy()
        continue
    out=pd.concat([out,fin])
    pressure=pd.concat([pressure,temp])
#Assign homogeneous resistivity from field data
df=out.copy()
df['cond']=0
df['cond'][df["porosity"]>=0.4]=1/40# 40 original used
df['cond'][df["porosity"]<0.4]=1/800
df1=df.iloc[:,[0,1,7,3,4,2,6,8,5]]
df1.columns = ['X', 'Z', 't', 'U','W', 'Por','sat','cond','Perm']
df1['m']=1.5
df1['Qv']=0
df1['Qv']=param[4]*(E*(-zeta-zeta**3*(((e0) / ( kB * T))**2)/54)*(1 / tau**2) * (phi / k))/df1['sat'] #Soldi et al, 2019
df1.to_csv('data_set_edit.txt',index=False)
with zipfile.ZipFile('data_set_edit.zip', 'w',zipfile.ZIP_DEFLATED) as myzip:
    myzip.write('data_set_edit.txt')
