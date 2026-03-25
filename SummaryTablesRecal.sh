#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

export config=/scratch1/ckenkel/ApalWGS/Expt/GLtest/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

export HARDCALL=/scratch1/ckenkel/ApalWGS/Haplotype/vcfSanger/

#### And finally, export tables for R summaries

bcftools query -f '%CHROM\t%POS\t%ID\t%AF[\t%SAMPLE=%GT][\t%SAMPLE=%GP]\n' $CHR'_ApalShal_merge150sam.allLoci.ann_noMulti_rename_OverlapSamp.vcf.gz' > $CHR'_LoCoRawGTcallsInfoAll.txt'

bcftools query -f '%CHROM\t%POS\t%ID\t%AF[\t%SAMPLE=%GT][\t%SAMPLE=%GP]\n' $CHR'_GL_allLoci_realign_IGP099_rename_OverlapSamp.vcf.gz' > $CHR'_LoCoGPrecalSitesInfoAll.txt'



bcftools query -f '%CHROM\t%POS\t%ID[\t%SAMPLE=%GT][\t%SAMPLE=%DP]\n' ${HARDCALL}${CHR}_ApalHap.RawLoCoGenoCallsAll.overlapSamp.vcf.gz > $CHR'_HiCoRawGTcallsInfoAll.txt'

bcftools query -f '%CHROM\t%POS\t%ID[\t%SAMPLE=%GT][\t%SAMPLE=%DP]\n' ${HARDCALL}${CHR}_ApalHap.LoCoGenoGPRecalSites.overlapSamp.vcf.gz > $CHR'_HiCoGPrecalSitesInfoAll.txt'

