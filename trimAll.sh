#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-157
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

config=/scratch1/ckenkel/ApalWGS/Expt/config.txt
export NAME=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

### trimming

module load gcc/11.3.0 trimgalore/0.6.6
module load py-cutadapt/3.5
module load fastqc

# enter your job specific code below this line
trim_galore --nextseq 20 --adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --adapter2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --clip_R1 2 --clip_R2 2 --retain_unpaired --paired $NAME'_R1_001.fastq' $NAME'_R2_001.fastq' 

