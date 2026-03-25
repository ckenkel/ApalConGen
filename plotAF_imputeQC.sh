#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00
#SBATCH --mem=8G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


#NO modules - use conda: mamba activate /project/ckenkel_26/condaEnvs/beagle

config=/scratch1/ckenkel/ApalWGS/Expt/vcfSanger/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

##############

DATASET=ApalShal_merge150sam.allLoci.ann
DATASET_INFO=${DATASET}_INFO_group
OUTPUT=${DATASET}_noFilt_postimputation_summary_plots
REFERENCE_FRQ=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/reference_panel_111824_imputation_all.frq

# Copy and save the given 'plot_INFO_and_AF_for_imputed_chrs.R' file 
# and run it with:

    Rscript --no-save  \
        plot_INFO_and_AF_for_imputed_chrs.R \
        ${DATASET_INFO}_chr${CHR}.txt \
        ${OUTPUT}_chr${CHR} \
        ${REFERENCE_FRQ} \
	${CHR}


# Combine the plots per chromosome into a single pdf file
#convert $(ls ${OUTPUT}_chr*.png | sort -V) \
 #    ${OUTPUT}.pdf

