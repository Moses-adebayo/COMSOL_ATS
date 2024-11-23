#!/bin/bash -l
#SBATCH -A CLI185
#SBATCH -N 1
#SBATCH -J perm_ens
#SBATCH --mail-user=moses_adebayo@mines.edu
#SBATCH --mail-type=ALL
#SBATCH -t 00:01:00
#SBATCH -p batch
for i in {1..100}
do
    mkdir /global/cscratch1/sd/adebayo/March2023/TEMPEST1/Perm_ens_$i
    cd /global/cscratch1/sd/adebayo/March2023/TEMPEST1/Perm_ens_$i
    srun -n 127 ats --xml_file=../Perm_ens_$i.xml &> ../out.log
done