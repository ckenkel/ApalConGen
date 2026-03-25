#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=32G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-16
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

config=/scratch1/ckenkel/ApalWGS/Haplotype/config.txt
export NAME=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)


### qual filtering

cat $NAME'_R1_001_val_1.fq' $NAME'_R1_001_unpaired_1.fq' | fastq_quality_filter -q 20 -p 90 > /scratch1/ckenkel/ApalWGS/Haplotype/clean/$NAME'_R1.clean'
cat $NAME'_R2_001_val_2.fq' $NAME'_R2_001_unpaired_2.fq' | fastq_quality_filter -q 20 -p 90 > /scratch1/ckenkel/ApalWGS/Haplotype/clean/$NAME'_R2.clean'
# this perl script is weird -- needs to be run in the directory with clean reads, full path to input doesn't work so
cd /scratch1/ckenkel/ApalWGS/Haplotype/clean
rePair.pl $NAME'_R1.clean' $NAME'_R2.clean'

