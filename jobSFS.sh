#!/bin/bash
##SBATCH --partition=largemem
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --mem=2G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

mamba activate /project/ckenkel_26/condaEnvs/angsd

### commands

# make a separate bam filelist for each individual
# also create a SAMPLES array for use below
BAMS=./*.bam
SAMPLES=()
for b in $BAMS; do
  # parse out the sample name
  base="$(basename -- $b)"
  sample="${base%%.host.marked_duplicates.bam}"
  SAMPLES+=("$sample")
  echo $sample
  echo $b > ${sample}.filelist.ind
done
