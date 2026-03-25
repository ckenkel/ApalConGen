#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=12:00:00
#SBATCH --mem=32G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


#NO modules - use conda: mamba activate /project/ckenkel_26/condaEnvs/beagle

config=/scratch1/ckenkel/ApalWGS/Expt/vcfSanger/config.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

##############
export DATASET=ApalShal_merge150sam.allLoci.ann
export REFPATH=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger

# Run phasing for each chromosome separately
# Run phasing for each chromosome separately
    eagle \
           --vcf $DATASET'_noMulti_dummyID.vcf.gz' \
           --chrom $CHR \
           --geneticMapFile $REFPATH/'eagle_chr'$CHR'_jaAcrPala1.1_SEXAVG.map' \
           --numThreads=8 \
           --Kpbwt=20000 \
           --outPrefix $DATASET'_AF_for_imputation_chr'$CHR
