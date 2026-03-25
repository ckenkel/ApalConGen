#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=32G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-27
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

config=/scratch1/ckenkel/ApalWGS/Haplotype/final_bams/config.txt
export NAME=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)


####### generate VCF per sample with min mapQ=40 and minbaseQ=20

#module load gcc/13.3.0 bcftools/1.19

export REF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/GCA_964030605.1/GCA_964030605.1_jaAcrPala1.1_genomic.fna

bcftools mpileup -f $REF -q 40 -Q 20 -Ou -A $NAME'.host.marked_duplicates.bam' \
-a FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/DP,FORMAT/SP,INFO/AD,INFO/ADF,INFO/ADR \
| bcftools call -m -Oz -f GQ,GP -W=tbi -o ../vcfSanger/$NAME'.vcf.gz' 


