#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

export config=/scratch1/ckenkel/ApalWGS/Expt/vcfSanger/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

export DATASET=ApalShal_merge150sam.allLoci.ann

export HARDCALL=/scratch1/ckenkel/ApalWGS/Haplotype/vcfSanger/

#generate filtered vcfs restricted to subset of overlapping sites and rename samples of interest for congruency between datasets
#where SamplesList.txt is just a list of sample names to be changed in old name new name format, one per line separated by whitespace
#and SamplesListOverlap.txt is list of samples to keep, one per line
# subset.sh

bcftools stats --verbose ${DATASET}_imputed_info_rename_overlapSamp_chr${CHR}.vcf.gz ${HARDCALL}${CHR}_ApalHap.imputedLoci.overlapSamp.vcf.gz  > ${CHR}_imp_vs_wgsHiCo.stats.perSample

#bcftools stats -s AP54 ${DATASET}_genoBYseq_info_rename_overlapSamp_chr${CHR}.vcf.gz ${HARDCALL}${CHR}_ApalHap.genoBYseqLoci.overlapSamp.vcf.gz  > ${CHR}_wgsLoCo_vs_wgsHiCo.stats.perSampleAP54





