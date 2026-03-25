#!/bin/bash
#SBATCH --partition=epyc-64
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --time=02:00:00
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=mruggeri@usc.edu

# enter your job environment parameters here
module load gcc/13.3.0 samtools/1.19.2

# enter your job specific code below this line
for i in `cat ./ID`; do samtools depth -a $i'.host.marked_duplicates.bam' | awk '{sum+=$3} END {print "Average = ",sum/NR}' ; done > HostCovSanger.txt
#for i in `cat ./IDall`; do samtools depth $i'.sym.marked_duplicates.bam2' | awk '{sum+=$3} END {print "Average = ",sum/NR}' ; done > SymCovSanger.txt
