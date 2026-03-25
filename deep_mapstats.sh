#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=mruggeri@usc.edu

# enter your job environment parameters here
#module load legacy/CentOS7  gcc/11.3.0 bamtools/2.5.2
module load legacy/CentOS7 gcc/9.2.0 samtools/18.0.4

# enter your job specific code below this line
for NAME in `cat ./ID`; do
    echo "Sample Name: $NAME" >> Stats_Host.txt
    samtools flagstat  $NAME'.host.bam' >> Stats_Host.txt; done

#for NAME in `cat ./ID`; do bamtools stats -in $NAME'.sym.bam' ; done > stats_sym.txt


