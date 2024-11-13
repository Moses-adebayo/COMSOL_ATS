#!/bin/bash -l
#SBATCH -A CLI185
#SBATCH -N 1
#SBATCH -J test
#SBATCH --mail-user=moses_adebayo@mines.edu
#SBATCH --mail-type=ALL
#SBATCH -t 00:10:00
#SBATCH -p batch
srun -n 14 ats --xml_file=../BSL_profile_case1.xml &> out.log

