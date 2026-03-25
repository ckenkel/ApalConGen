#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out

countreads_clean.pl > Nreads_filt.txt
