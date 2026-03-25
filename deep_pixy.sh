#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=06:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


####### run pixy with 100kb windows

pixy --stats pi fst dxy --vcf ApalHiCo_merge.allLoci.HetSamps.MinDP.MaxDP.Miss.vcf.gz --populations SamplesHet_Pops.txt --window_size 100000 --n_cores 4 --output_prefix 100kb --output_folder .
