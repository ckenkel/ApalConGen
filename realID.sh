#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


#NO modules - use conda: mamba activate /project/ckenkel_26/condaEnvs/beagle


##############

export DATASET=ApalShal_merge150sam.allLoci.ann


for CHR in `cat CHR_list.txt`; do
    bcftools annotate --rename-chrs CHR_list_dummy2 ${DATASET}_AF_for_imputation_chr${CHR}.vcf.gz -Oz -o ${DATASET}_for_imputation_chrOG${CHR}.vcf.gz
done

mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG1.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034921.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG2.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034922.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG3.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034923.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG4.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034924.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG5.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034925.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG6.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034926.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG7.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034927.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG8.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034928.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG9.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034929.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG10.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034930.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG11.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034931.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG12.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034932.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG13.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034933.1.vcf.gz
mv ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG14.vcf.gz ApalShal_merge150sam.allLoci.ann_for_imputation_chrOG_OZ034934.1.vcf.gz

