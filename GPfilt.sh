#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

export config=/scratch1/ckenkel/ApalWGS/Expt/GLtest/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

####### filter based on GL >=0.99 to retain only high confidence sites for subsequent imputation


##Pre-imputation filter: GP >= 0.99

#tabix -h ${CHR}_GL_allLoci_realign.vcf.gz

bcftools +setGT ${CHR}_GL_allLoci_realign.vcf.gz -W=tbi -Oz -o ${CHR}_GL_allLoci_realign_IGP099.vcf.gz -- -t q -n . -e'FORMAT/GP>=0.99' 
