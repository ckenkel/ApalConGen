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

# Re-calculate and add INFO field values for each chromosome

    # Create index file
#    bcftools index -t ${DATASET}_imputed_chr${CHR}.vcf.gz
	
    # Re-calculate allele frequency and 
    # compute Impute2-like INFO score
    bcftools +fill-tags ${DATASET}_imputed_chr${CHR}.vcf.gz \
        -Ou -- -t all | \
    bcftools +impute-info \
        -Oz -o ${DATASET}_imputed_info_chr${CHR}.vcf.gz
