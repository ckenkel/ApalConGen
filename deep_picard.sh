#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=18:00:00
#SBATCH --mem=32G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-3
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

config=/scratch1/ckenkel/ApalWGS/Haplotype/config.txt
export NAME=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)


####### merge bams, format, and mark duplicates

module load gcc/13.3.0 openjdk/21.0.0_35 samtools/1.19.2 picard/3.1.1

export DIR=/scratch1/ckenkel/ApalWGS/Haplotype

# merge paired and single end bams
samtools merge -f -o $NAME'.host.merge.bam' $NAME'.host.sorted.bam' Unp_$NAME'.host.sorted.bam'

# reformat files for GATK
java -Xmx4G -jar $PICARD AddOrReplaceReadGroups I=$NAME'.host.merge.bam' O=$NAME'.host.rg.bam' RGID=group1 RGLB=lib1 RGPU=unit1 RGPL=illumina RGSM=$NAME

# mark PCR duplicates
java -Xmx6G -jar $PICARD MarkDuplicates I=$NAME'.host.rg.bam' O=$DIR/final_bams/$NAME'.host.marked_duplicates.bam' M=$NAME'.host.marked_dup_metrics.txt'

# index file
samtools index $DIR/final_bams/$NAME'.host.marked_duplicates.bam'

###### metrics

echo $NAME

grep -A 2 'METRICS CLASS' $NAME'.host.marked_dup_metrics.txt'

samtools depth $NAME'.host.sorted.bam' | awk '{sum+=$3} END {print "Average = ",sum/NR}'

samtools depth $NAME'.host.merge.bam' | awk '{sum+=$3} END {print "Average = ",sum/NR}'

samtools depth $DIR/final_bams/$NAME'.host.marked_duplicates.bam' | awk '{sum+=$3} END {print "Average = ",sum/NR}'
