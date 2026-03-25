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

#generate list of sites to keep per chromosome in format CHR POS, tab-separated
#bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF\t%IMP\n' ${CHR}_GL_allLoci_realign_IGP099_IMP_IGP099.vcf.gz | awk '($6 != ".")' | cut -f 1,2 > $CHR'_IGP099_IMP_IGP099_ImputedSitesList.txt'

#bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF\t%IMP\n' ${CHR}_GL_allLoci_realign_IGP099_IMP_IGP099.vcf.gz | awk '($6 != "1")' | cut -f 1,2 > $CHR'_GenotypeBySeqSitesList.txt'

#bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF\t%IMP\n' ${CHR}_GL_allLoci_realign_IGP099_IMP_IGP090.vcf.gz | awk '($6 != ".")' | cut -f 1,2 > $CHR'_IGP099_IMP_IGP090_ImputedSitesList.txt'

bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF\t%IMP\n' ${CHR}_GL_allLoci_realign_IGP099_IMP.vcf.gz.vcf.gz | awk '($6 != ".")' | cut -f 1,2 > $CHR'_IGP099_IMP_ImputedSitesList.txt'

bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF\t%IMP\n' ${CHR}_GL_allLoci_realign_IGP099_IMP.vcf.gz.vcf.gz | awk '($6 != "1")' | cut -f 1,2 > $CHR'_GenotypeBySeqAllSitesList.txt'
