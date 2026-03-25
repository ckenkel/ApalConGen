#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

### trimming

#module load gcc/11.3.0 trimgalore/0.6.6
#module load py-cutadapt/3.5
#module load fastqc
#export NAME=21073D-03-01_S46_L003

# enter your job specific code below this line
#trim_galore --nextseq 20 --adapter AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --adapter2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --clip_R1 2 --clip_R2 2 --retain_unpaired --paired $NAME'_R1_001.fastq' $NAME'_R2_001.fastq' 

### qual filtering

#export NAME=21073D-03-01_S46_L003

#cat $NAME'_R1_001_val_1.fq' $NAME'_R1_001_unpaired_1.fq' | fastq_quality_filter -q 20 -p 90 > /scratch1/ckenkel/ApalWGS/Expt/clean/$NAME'_R1.clean'
#cat $NAME'_R2_001_val_2.fq' $NAME'_R2_001_unpaired_2.fq' | fastq_quality_filter -q 20 -p 90 > /scratch1/ckenkel/ApalWGS/Expt/clean/$NAME'_R2.clean'
# this perl script is weird -- needs to be run in the directory with clean reads, full path to input doesn't work so
#cd /scratch1/ckenkel/ApalWGS/Expt/clean
#rePair.pl $NAME'_R1.clean' $NAME'_R2.clean'

### mapping unpaired

#export REF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1
#export DIR=/scratch1/ckenkel/ApalWGS/Expt
#module load gcc/11.3.0 intel/19.0.4 bwa/0.7.17 samtools/1.17

#export NAME=21073D-03-01_S46_L003

# enter your job specific code below this line 
#bwa mem -t 32 $REF/ApalmSymABCDBwa $DIR/clean/Unp_$NAME'_R1.clean_'$NAME'_R2.clean' > Unp_$NAME'.bwa.sam'
# sym scaffolds start with 'chr' so can use that to separate mapped reads
# first for host
#grep -v 'chr2' Unp_$NAME'.bwa.sam' > Unp_$NAME'.host.sam'
#samtools view -b -S Unp_$NAME'.host.sam' > Unp_$NAME'.host.bam'
#samtools sort Unp_$NAME'.host.bam' -@ 32 -O BAM -o Unp_$NAME'.host.sorted.bam'
# now for sym
#grep 'chr2' Unp_$NAME'.bwa.sam' > Unp_$NAME'.sym.sam'
#samtools view -b -S Unp_$NAME'.sym.sam' > Unp_$NAME'.sym.bam'
#samtools sort Unp_$NAME'.sym.bam' -@ 32 -O BAM -o Unp_$NAME'.sym.sorted.bam'

#### mapping paired

#export REF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1
#export DIR=/scratch1/ckenkel/ApalWGS/Expt
#module load gcc/11.3.0 intel/19.0.4 bwa/0.7.17 samtools/1.17

#export NAME=21073D-03-01_S46_L003

# enter your job specific code below this line 
#bwa mem -t 32 $REF/ApalmSymABCDBwa $DIR/clean/R1_$NAME'_R1.clean' $DIR/clean/R2_$NAME'_R2.clean' > $NAME'.bwa.sam'
# sym scaffolds start with 'chr' so can use that to separate mapped reads
# first for host
#grep -v 'chr2' $NAME'.bwa.sam' > $NAME'.host.sam'
#samtools view -b -S $NAME'.host.sam' > $NAME'.host.bam'
#samtools sort $NAME'.host.bam' -@ 32 -O BAM -o $NAME'.host.sorted.bam'
# now for sym
#grep 'chr2' $NAME'.bwa.sam' > $NAME'.sym.sam'
#samtools view -b -S $NAME'.sym.sam' > $NAME'.sym.bam'
#samtools sort $NAME'.sym.bam' -@ 32 -O BAM -o $NAME'.sym.sorted.bam'

####### merge bams, format, and mark duplicates
# make a directory for final bams 
# run the following as a job -- change paths as needed

module load gcc/11.3.0 jdk/17.0.5 samtools/1.17 picard/2.26.2

export DIR=/scratch1/ckenkel/ApalWGS/Expt

export NAME=21073D-03-01_S46_L003

# merge paired and single end bams
#samtools merge -o $NAME'.host.merge.bam' $NAME'.host.sorted.bam' Unp_$NAME'.host.sorted.bam'

# reformat files for GATK
#java -Xmx4G -jar $PICARD AddOrReplaceReadGroups I=$NAME'.host.merge.bam' O=$NAME'.host.rg.bam' RGID=group1 RGLB=lib1 RGPU=unit1 RGPL=illumina RGSM=$NAME

# mark PCR duplicates
#java -Xmx6G -jar $PICARD MarkDuplicates I=$NAME'.host.rg.bam' O=$DIR/final_bams/$NAME'.host.marked_duplicates.bam' M=$NAME'.host.marked_dup_metrics.txt'

# index file
#samtools index $DIR/final_bams/$NAME'.host.marked_duplicates.bam'

###### metrics

grep -A 2 'METRICS CLASS' $NAME'.host.marked_dup_metrics.txt'

samtools depth $NAME'.host.sorted.bam' | awk '{sum+=$3} END {print "Average = ",sum/NR}'

samtools depth $NAME'.host.merge.bam' | awk '{sum+=$3} END {print "Average = ",sum/NR}'

samtools depth $DIR/final_bams/$NAME'.host.marked_duplicates.bam' | awk '{sum+=$3} END {print "Average = ",sum/NR}'
