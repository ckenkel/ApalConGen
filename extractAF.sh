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

 
DATASET=ApalShal_merge150sam.allLoci.ann

# Generate an allele frequency file for plotting for each chrs

    # Generate a header for the output file
    echo -e 'CHR\tSNP\tREF\tALT\tAF\tINFO\tAF_GROUP' \
        > ${DATASET}_INFO_group_chr${CHR}.txt

    # Query the required fields and 
    # add frequency group (1, 2 or 3) as the last column
    bcftools query -f \
        '%CHROM\t%CHROM\_%POS\_%REF\_%ALT\t%REF\t%ALT\t%INFO/AF\t%INFO/INFO\t-\n' \
        ${DATASET}_imputed_info_chr${CHR}.vcf.gz | \
    # Here $5 refers to AF values, $7 refers to AF group
    awk -v OFS="\t" \
        '{if ($5>=0.05 && $5<=0.95) $7=1; \
            else if(($5>=0.005 && $5<0.05) || \
            ($5<=0.995 && $5>0.95)) $7=2; else $7=3} \
            { print $1, $2, $3, $4, $5, $6, $7 }' \
        >> ${DATASET}_INFO_group_chr${CHR}.txt


