#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=06:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here


####### concatenate chr specific vcfs and count sites

# concatenate chromosomes together
bcftools concat -f cat_list -o ApalHiCo_merge.allLoci.IDrisk.AC3.MinDP.MaxDP.Miss.vcf.gz

tabix ApalHiCo_merge.allLoci.IDrisk.AC3.MinDP.MaxDP.Miss.vcf.gz

# check how many loci -- note this is HQ mono and polymorphic

bcftools query -f '%CHROM\t%POS\n' ApalHiCo_merge.allLoci.IDrisk.AC3.MinDP.MaxDP.Miss.vcf.gz | wc -l
