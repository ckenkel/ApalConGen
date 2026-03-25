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

export DATASET=ApalShal_merge150sam.allLoci.ann

bcftools annotate --rename-chrs CHR_list_dummy $DATASET'_noMulti.vcf.gz' -Oz -o $DATASET'_noMulti_dummyID.vcf.gz'
