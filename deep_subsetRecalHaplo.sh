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

export config=/scratch1/ckenkel/ApalWGS/Haplotype/vcfSanger/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)


#generate filtered vcfs restricted to subset of overlapping sites and rename samples of interest for congruency between datasets
#where SamplesList.txt is just a list of sample names to be changed in old name new name format, one per line separated by whitespace

bcftools view -R $CHR'_rawGenotypeCallsSitesList.txt' -S SamplesListOverlap.txt $CHR'_ApalHap.allLoci.renameSamp.vcf.gz' -W=tbi -o $CHR'_ApalHap.RawLoCoGenoCallsAll.overlapSamp.vcf.gz' 


bcftools view -R $CHR'_GenotypeRecalSitesList.txt' -S SamplesListOverlap.txt $CHR'_ApalHap.allLoci.renameSamp.vcf.gz' -W=tbi -o $CHR'_ApalHap.LoCoGenoGPRecalSites.overlapSamp.vcf.gz' 

