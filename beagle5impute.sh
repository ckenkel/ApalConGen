#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=64G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

export config=/scratch1/ckenkel/ApalWGS/Expt/GLtest/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

####### update GL based on hap panel and map

REFERENCE_BREF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/

# Run imputation for each chromosome
	beagle \
        gt=${CHR}_GL_allLoci_realign_IGP099.vcf.gz \
        ref=${REFERENCE_BREF}plusAF_prune_SNPID_filt_split_reference_panel_111824.${CHR}.bref3 \
        map=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/Apalmata_SEXAVG.map \
        out=${CHR}_GL_allLoci_realign_IGP099_IMP.vcf.gz \
        ne=10000 \
        impute=true \
        gp=true \
        seed=-99999


