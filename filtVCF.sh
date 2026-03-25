#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


####### keep only desired chromosomes and remap to correct for ref/alt flips

#NO modules - use conda: mamba activate /project/ckenkel_26/condaEnvs/beagle

DATASET=ApalShal_merge150sam.allLoci.ann
# A comma-separated string of chrs to keep
chrs=$(echo "OZ034921.1,OZ034922.1,OZ034923.1,OZ034924.1,OZ034925.1,OZ034926.1,OZ034927.1,OZ034928.1,OZ034929.1,OZ034930.1,OZ034931.1,OZ034932.1,OZ034933.1,OZ034934.1")

# Keep only those wanted chromosomes
bcftools view -t $chrs ${DATASET}.vcf.gz \
    -Oz -o ${DATASET}_chrfiltered.vcf.gz

### align and correct for any ref/alt flips
FASTA=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/GCA_964030605.1/GCA_964030605.1_jaAcrPala1.1_genomic.fna

# Align the alleles to the reference genome, 
# and keep only biallelic records
bcftools norm -f ${FASTA} -c ws \
    ${DATASET}_chrfiltered.vcf.gz -Ou | \
bcftools view -m 2 -M 2 \
    -Oz -o ${DATASET}_refcorrected.vcf.gz

# Replace the ID column with a CHR_POS_REF_ALT
bcftools annotate \
    --set-id '%CHROM\_%POS\_%REF\_%ALT' \
    ${DATASET}_refcorrected.vcf.gz \
    -Oz -o ${DATASET}_SNPID.vcf.gz


