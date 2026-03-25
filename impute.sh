#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00
#SBATCH --mem=32G
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
BEAGLE_PATH=/project/ckenkel_26/software
REFERENCE_BREF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/

# Run imputation for each chromosome
    java -Xss5m -Xmx16g \
      -jar ${BEAGLE_PATH}/beagle.27Jan18.7e1.jar \
        gt=${DATASET}_for_imputation_chrOG_${CHR}.vcf.gz \
        ref=${REFERENCE_BREF}plusAF_prune_SNPID_filt_split_reference_panel_111824.${CHR}.bref \
        map=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/Apalmata_SEXAVG.map \
        out=${DATASET}_imputed_chr${CHR} \
        nthreads=16 \
        niterations=10 \
        ne=10000 \
        impute=true \
        gprobs=true \
        seed=-99999
