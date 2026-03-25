#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=48G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


####### keep only desired chromosomes and remap to correct for ref/alt flips

#NO modules - use conda: mamba activate /project/ckenkel_26/condaEnvs/beagle

DATASET=ApalShal_merge150sam.allLoci.ann
PANEL_FRQ=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/reference_panel_111824_imputation_all.frq

# Copy and save the given 'plot_AF.R' file and run it with:
Rscript --no-save /scratch1/ckenkel/ApalWGS/Expt/vcfSanger/plot_AF.R \
    ${DATASET}_shallowLib.frq \
    ${DATASET} \
    ${PANEL_FRQ} \
    0.1 \
    5
