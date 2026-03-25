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


### align and correct for any ref/alt flips: filt.sh

FASTA=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/GCA_964030605.1/GCA_964030605.1_jaAcrPala1.1_genomic.fna

# Align the alleles to the reference genome,
# and keep only biallelic records
#bcftools norm -f ${FASTA} -c ws \
#    $CHR'_ApalHap.allLoci.vcf.gz' -Ou | \
#bcftools view -m 2 -M 2 \
#    -Oz -o $CHR'_ApalHap.refcorrected.vcf.gz'

# Replace the ID column with a CHR_POS_REF_ALT
bcftools annotate \
    --set-id '%CHROM\_%POS\_%REF\_%ALT' \
    $CHR'_ApalHap.refcorrected.vcf.gz' \
    -Oz -o $CHR'_ApalHap.SNPid.vcf.gz'

