#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
#SBATCH --array=1-14
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

export config=/scratch1/ckenkel/ApalWGS/Expt/GLtest/chromOZ.txt
export CHR=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

####### update GL based on hap panel and map

BEAGLE_PATH=/project/ckenkel_26/software
REFERENCE_BREF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/

# Run for each chromosome
    java -Xss5m -Xmx16g \
      -jar ${BEAGLE_PATH}/beagle.27Jan18.7e1.jar \
        gl=${CHR}_ApalShal_merge150sam.allLoci.ann_noMulti.vcf.gz \
	gprobs=true \
        ref=${REFERENCE_BREF}plusAF_prune_SNPID_filt_split_reference_panel_111824.${CHR}.bref \
        map=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_vSanger/Apalmata_SEXAVG.map \
        window=2000 \
	overlap=200 \
	out=${CHR}_GL_allLoci_realign

