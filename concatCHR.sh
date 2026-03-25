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


####### generate VCF per sample with min mapQ=40 and minbaseQ=20

#NO modules - use conda: mamba activate /project/ckenkel_26/condaEnvs/beagle


# concatenate chromosomes together
bcftools concat -f cat_list -o ApalShal_merge150sam.allLoci.vcf.gz

# remove INFO/ADF and INFO/ADR so no one gets confused -- these values are just filled in from first sample
# note that other INFO tags not specified in merging are also just reflecting the first sample so be careful when filtering
bcftools annotate -x INFO/ADF,INFO/ADR --set-id +'%CHROM\_%POS\_%REF\_%FIRST_ALT' ApalShal_merge150sam.allLoci.vcf.gz -o ApalShal_merge150sam.allLoci.ann.vcf.gz

# check how many loci -- note this is mono and polymorphic
bcftools query -f '%CHROM\t%POS\n' ApalShal_merge150sam.allLoci.ann.vcf.gz | wc -l

