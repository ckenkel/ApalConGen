#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


############# first use bcftools to cut down to just focal samples, 1 cpu per task (comment out pixy run below)

bcftools view -S SamplesHet.txt AllCHR_GL_allLoci_realign_IGP099_IMP_DR2099.vcf.gz -W=tbi -o AllCHR_GL_allLoci_realign_IGP099_IMP_DR2099_HetSams.vcf.gz

####### run pixy with 100kb windows, comment out bcf call above and change to 4 cpus per task

#pixy --stats pi fst dxy --vcf ApalHiCo_merge.allLoci.HetSamps.MinDP.MaxDP.Miss.vcf.gz --populations SamplesHet_Pops.txt --window_size 100000 --n_cores 4 --output_prefix 100kb --output_folder .
