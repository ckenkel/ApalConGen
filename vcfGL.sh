#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

config=/scratch1/ckenkel/ApalWGS/Expt/GLtest/config.txt
export NAME=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

####### generate GL VCF per sample with and without  min mapQ=40 and minbaseQ=20


export REF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/GCA_964030605.1/GCA_964030605.1_jaAcrPala1.1_genomic.fna

bcftools mpileup -f $REF -q 40 -Q 20 -Ou -A ../final_bams/$NAME'.host.marked_duplicates.bam' \
-a FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/DP,FORMAT/SP,INFO/AD,INFO/ADF,INFO/ADR \
-Oz -W=tbi -o $NAME'.vcfGL_filt.gz'

#bcftools mpileup -f $REF -Ou -A ../final_bams/$NAME'.host.marked_duplicates.bam' \
#-a FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/DP,FORMAT/SP,INFO/AD,INFO/ADF,INFO/ADR \
#-Oz -W=tbi -o $NAME'.vcfGL_NOfilt.gz'
