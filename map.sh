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

#### mapping paired

export REF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/GCA_964030605.1
export DIR=/scratch1/ckenkel/ApalWGS/Expt
module load gcc/11.3.0 intel/19.0.4 bwa/0.7.17 samtools/1.17


# enter your job specific code below this line 
#bwa mem -t 32 $REF/ApalmSangerSymABCDBwa $DIR/clean/R1_$NAME'_R1.clean' $DIR/clean/R2_$NAME'_R2.clean' > $NAME'.bwa.sam'

# sym scaffolds start with 'chr' so can use that to separate mapped reads
# first for host
grep -v 'chr2' $NAME'.bwa.sam' > $NAME'.host.sam'
samtools view -b -S $NAME'.host.sam' > $NAME'.host.bam'
samtools sort $NAME'.host.bam' -@ 32 -O BAM -o $NAME'.host.sorted.bam'

# now for sym
#grep 'chr2' $NAME'.bwa.sam' > $NAME'.sym.sam'
#samtools view -b -S $NAME'.sym.sam' > $NAME'.sym.bam'
#samtools sort $NAME'.sym.bam' -@ 32 -O BAM -o $NAME'.sym.sorted.bam'

