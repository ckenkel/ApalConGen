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

export HARDCALL=/scratch1/ckenkel/ApalWGS/Haplotype/vcfSanger/

#### And finally, export tables for R summaries

#bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF[\t%SAMPLE=%GT][\t%SAMPLE=%GP]\n' $CHR'_GL_allLoci_realign_IGP099_IMP_IGP099_overlapSamp.vcf.gz' > $CHR'_LoCoImputedSitesIGP099Info.txt'

#bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF[\t%SAMPLE=%GT][\t%SAMPLE=%GP]\n' $CHR'_GL_allLoci_realign_IGP099_IMP_IGP090_overlapSamp.vcf.gz' > $CHR'_LoCoImputedSitesIGP090Info.txt'

#bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF[\t%SAMPLE=%GT][\t%SAMPLE=%GP]\n' $CHR'_GL_allLoci_realign_IGP099_IMP_IGP099_overlapSamp.vcf.gz' > $CHR'_LoCoGBSsitesInfo.txt'



#bcftools query -f '%CHROM\t%POS\t%ID[\t%SAMPLE=%GT][\t%SAMPLE=%DP]\n' ${HARDCALL}${CHR}_ApalHap.imputedLociIGP099.overlapSamp.vcf.gz > $CHR'_HiCoImputedSitesIGP099Info.txt'

#bcftools query -f '%CHROM\t%POS\t%ID[\t%SAMPLE=%GT][\t%SAMPLE=%DP]\n' ${HARDCALL}${CHR}_ApalHap.imputedLociIGP090.overlapSamp.vcf.gz > $CHR'_HiCoImputedSitesIGP090Info.txt'

#bcftools query -f '%CHROM\t%POS\t%ID[\t%SAMPLE=%GT][\t%SAMPLE=%DP]\n' ${HARDCALL}${CHR}_ApalHap.genoBYseqLoci.overlapSamp.vcf.gz > $CHR'_HiCoGBSsitesInfo.txt'

bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF[\t%SAMPLE=%GT][\t%SAMPLE=%GP]\n' $CHR'_GL_allLoci_realign_IGP099_IMP_overlapSamp.vcf.gz' > $CHR'_LoCoImputedSitesInfoAll.txt'

bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF[\t%SAMPLE=%GT][\t%SAMPLE=%GP]\n' $CHR'_GL_allLoci_realign_IGP099_IMP_overlapSamp.vcf.gz' > $CHR'_LoCoGBSsitesInfoAll.txt'

bcftools query -f '%CHROM\t%POS\t%ID[\t%SAMPLE=%GT][\t%SAMPLE=%DP]\n' ${HARDCALL}${CHR}_ApalHap.imputedLociAll.overlapSamp.vcf.gz > $CHR'_HiCoImputedSitesInfoAll.txt'

bcftools query -f '%CHROM\t%POS\t%ID[\t%SAMPLE=%GT][\t%SAMPLE=%DP]\n' ${HARDCALL}${CHR}_ApalHap.genoBYseqLociAll.overlapSamp.vcf.gz > $CHR'_HiCoGBSsitesInfoAll.txt'
