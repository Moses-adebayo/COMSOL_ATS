#!/bin/bash -l
#SBATCH -A CLI185
#SBATCH -N 1
#SBATCH -J perm_ens
#SBATCH --mail-user=moses_adebayo@mines.edu
#SBATCH --mail-type=ALL
#SBATCH -t 24:00:00
#SBATCH -p batch
for i in {43..100}
do
    mkdir /ccsopen/home/mosesadebayo001/COMSOL_ATS/Perm_ens/Perm_ens_$i
    cd /ccsopen/home/mosesadebayo001/COMSOL_ATS/Perm_ens/Perm_ens_$i
    srun -n 127 ats --xml_file=../Perm_ens_$i.xml &> ../out.log
done
