#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

export config=/scratch1/ckenkel/ApalWGS/Expt/GLtest/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

### now restrict expt set to the overlapping samples list

#bcftools reheader -s SamplesList.txt -o ${CHR}_ApalShal_merge150sam.allLoci.ann_noMulti_rename.vcf.gz ${CHR}_ApalShal_merge150sam.allLoci.ann_noMulti.vcf.gz

#bcftools index -t ${CHR}_ApalShal_merge150sam.allLoci.ann_noMulti_rename.vcf.gz

#bcftools view -S SamplesListOverlap.txt ${CHR}_ApalShal_merge150sam.allLoci.ann_noMulti_rename.vcf.gz -W=tbi -o ${CHR}_ApalShal_merge150sam.allLoci.ann_noMulti_rename_OverlapSamp.vcf.gz

bcftools reheader -s SamplesList.txt -o ${CHR}_GL_allLoci_realign_IGP099_rename.vcf.gz ${CHR}_GL_allLoci_realign_IGP099.vcf.gz

bcftools index -t ${CHR}_GL_allLoci_realign_IGP099_rename.vcf.gz

bcftools view -S SamplesListOverlap.txt ${CHR}_GL_allLoci_realign_IGP099_rename.vcf.gz -W=tbi -o ${CHR}_GL_allLoci_realign_IGP099_rename_OverlapSamp.vcf.gz

