#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out

countreads.pl > Nreads_raw.txt
countreads_fq.pl > Nreads_trim.txt
countreads_clean.pl > Nreads_filt.txt
