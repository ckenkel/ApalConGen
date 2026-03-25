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
PANEL_ID=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/reference_panel_111824_sample_IDs.txt

# Copy the panel sample ID file with 
# a different name to the working directory
#cp ${PANEL_ID} duplicate_sample_IDs.txt

# Generate a list of chip data sample IDs, 
# keep only duplicates and 
# append to the list of panel sample IDs
#bcftools query -l ${DATASET}_SNPID.vcf.gz | \
#    uniq -d >> duplicate_sample_IDs.txt

# Exclude duplicate samples and MAC=0 variants, 
# and update AF value after sample removals.
# Finally, exclude duplicate variants
bcftools view -c 1 -c 1:nonmajor -S ^duplicate_sample_IDs.txt \
   --force-samples ${DATASET}.vcf.gz -Ou | \
bcftools +fill-tags -Ou -- -t AC,AN,AF | \
bcftools norm -d none \
    -Oz -o ${DATASET}_noduplicate_variants.vcf.gz
