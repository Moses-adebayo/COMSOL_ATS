#!/bin/bash -l
#SBATCH -A CLI185
#SBATCH -N 1
#SBATCH -J test
#SBATCH --mail-user=moses_adebayo@mines.edu
#SBATCH --mail-type=ALL
#SBATCH -t 01:00:00
#SBATCH -p batch
srun -n 128 ats --xml_file=../BSL_profile.xml &> out.log

