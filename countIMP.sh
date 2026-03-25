#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


# merge chromosome vcfs into single vcf
bcftools query -f '%CHROM\t%POS\t%ID\t%DR2\t%AF\t%IMP\n' AllCHR_GL_allLoci_realign_IGP099_IMP_DR2099.vcf.gz > AllCHR_GL_allLoci_realign_IGP099_IMP_DR2099_ImputedOrNotList.txt
