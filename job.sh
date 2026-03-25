#!/bin/bash
##SBATCH --partition=largemem
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=48:00:00
#SBATCH --mem=64G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

mamba activate /project/ckenkel_26/condaEnvs/angsd

### commands

# Be sure to modify -minInd flag and -nInd flags below for each run - I've selected 80% of total N = 157

#FILTERS="-uniqueOnly 1 -remove_bads 1 -skipTriallelic 1 -minMapQ 30 -minQ 25 -dosnpstat 1 -doHWE 1 -sb_pval 1e-5 -hetbias_pval 1e-5 -hwe_pval 1e-5 -minInd 126 -snp_pval 1e-5 -minMaf 0.05"
#TODO="-doMajorMinor 1 -doMaf 1 -doPost 1 -doGlf 1"

# make a genotype likelihood file (glf) containing all individuals
#angsd -b bams -GL 2 $FILTERS $TODO -P 1 -out glfApal

# run IBS, this will analyse each pair of indiviudals
ibs -glf glfApal.glf.gz -model 0 -maxSites 100000 -nInd 157 -allpairs 1 -outFileName Apal_ibs.model1.results

# look at the results from IBS

module load gcc/8.3.0  
module load openblas/0.3.8 
module load r/3.5.3

Rscript \
  -e "source('/project/ckenkel_26/scripts/read_IBS.R')" \
  -e "res = do_derived_stats(read_ibspair_model0('Apal_ibs.model1.results.ibspair'))" \
  -e "print(res[,c('ind1', 'ind2', 'nSites', 'Kin', 'R0', 'R1') ])" > relatednessApal_100ksites.txt


