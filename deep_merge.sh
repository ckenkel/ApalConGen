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

export config=/scratch1/ckenkel/ApalWGS/Haplotype/vcfSanger/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)


####### generate VCF per CHR with min mapQ=40 and minbaseQ=20

#module load gcc/13.3.0 bcftools/1.19


# merge sample vcfs into single vcf by chromosome (done to speed up processing time)
bcftools merge -r $CHR -l vcf_list -m both -i IDV:sum,DP:sum,DP4:sum,AD:sum,MQ:avg -W=tbi -o $CHR'_ApalHap.allLoci.vcf.gz' 


