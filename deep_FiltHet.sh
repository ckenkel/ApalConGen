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

export config=/scratch1/ckenkel/ApalWGS/Haplotype/vcfSanger/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)


####### subset all Loci vcf to focal samples for heterozygosity

bcftools filter -e 'FMT/DP<=10' $CHR'_ApalHap.allLoci.HetSamps.vcf.gz' -Ou | \

bcftools filter -e 'FMT/DP>83'  -Ou | \

bcftools filter -Oz -e 'F_MISSING>0.1' -W=tbi -Oz -o $CHR'_ApalHap.allLoci.HetSamps.MinDP.MaxDP.Miss.vcf.gz'
