#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=2G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

export config=/scratch1/ckenkel/ApalWGS/Expt/vcfSanger/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

DATASET=ApalShal_merge150sam.allLoci.ann

#generate list of sites to keep per chromosome in format CHR POS, tab-separated 

awk '($6 != ".")' $CHR'_AllSitesInfoList.txt' | cut -f 1,2 > $CHR'_ImputedSitesList.txt'
awk '($6 != "1")' $CHR'_AllSitesInfoList.txt' | cut -f 1,2 > $CHR'_GenotypeBySeqDataSitesList.txt'


