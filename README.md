# High relatedness in sexually produced restoration cohorts of the endangered elkhorn coral, Acropora palmata
Climate change is driving the decline of coral populations around the world such that many are unlikely to recover without human intervention. Assisted sexual reproduction is one intervention proposed to enhance genetic diversity and support population recovery, yet its genetic outcomes remain poorly quantified. We evaluated genome-wide relatedness and genetic diversity in 162 restoration genets of the endangered Caribbean coral Acropora palmata, including 153 sexually produced individuals derived from multi-parent batch and biparental crosses. A subset of samples were sequenced at both high (~33x) and low (~3x) coverage to validate the genotyping imputation pipeline. This repository contains the bioinformatic and statistical scripts necessary to re-create analyses, as well as raw input data used to generate figures. Raw FASTQ reads can be obtained from NCBI’s SRA under BioProject PRJNA1078365. 

Files in this repository 
-----------

1. ApalGenomes_ConGen.txt: Annotated bioinformatic workflow for genotyping and imputation (including read QC, filtering and genotype calls). Custom shell scripts used in this analysis are listed below. Installation instructions are given for other published softwares. Note that this pipeline was written for a cluster which uses a SLURM scheduler. 
	- Shallow Coverage sample Set
	  - ConvertBED.sh
	  - DRfiltFinal.sh
	  - GPfilt.sh
	  - ImputeStats.sh
	  - KINGcat.sh
	  - KINGfilt.sh
	  - KINGmerge.sh
	  - KINGrename.sh
	  - KINest.sh
	  - SummaryTables.sh
	  - SummaryTablesRecal.sh
	  - addINFO.sh
	  - beagle5impute.sh
	  - beagleRealign.sh
	  - concat.sh
	  - concatCHR.sh
	  - countIMP.sh
	  - counts.sh
	  - cov.sh
	  - dummyID.sh
	  - extractAF.sh
	  - filtAll.sh
	  - filtDups.sh
	  - filtMulti.sh
	  - filtRare.sh
	  - filtVCF.sh
	  - freqFile.sh
	  - impute.sh
	  - index.sh
	  - job.sh
	  - jobHet.sh
	  - jobSFS.sh
	  - map.sh
	  - mapUnpair.sh
	  - mapstats.sh
	  - merge.sh
	  - picard.sh
	  - pixy.sh
	  - plotAF_imputeQC.sh
	  - plotFreq.sh
	  - prePhase.sh
	  - realID.sh
	  - sitesList.sh
	  - split.sh
	  - subset.sh
	  - subsetRecal.sh
	  - subsetSites.sh
	  - subsetSitesRecal.sh
	  - trimAll.sh
	  - vcf.sh
	  - vcfGL.sh
	- High Coverage sample set
	  - deep_FiltHet.sh
	  - deep_FiltROH.sh
	  - deep_KINGsub.sh
	  - deep_concatCHR.sh
	  - deep_concatROH.sh
	  - deep_counts.sh
	  - deep_cov.sh
	  - deep_filt.sh
	  - deep_filtAll.sh
	  - deep_job.sh
	  - deep_jobHet.sh
	  - deep_map.sh
	  - deep_mapUnpair.sh
	  - deep_mapstats.sh
	  - deep_merge.sh
	  - deep_picard.sh
	  - deep_pixy.sh
	  - deep_subset.sh
	  - deep_subsetHet.sh
	  - deep_subsetROH.sh
	  - deep_subsetRecalHaplo.sh
	  - deep_trimAll.sh
	  - deep_vcf.sh
	
2. RuthGates_SiteMap.qmd: Annotated R script for generating site map as in Figure 1
   
3. Annotated R scripts for assessing imputation accuracy and genotype concordance. Note that even per chromosome input files are large must be generated following steps in ApalGenomes_ConGen.txt
	- RuthGates_GP_Raw_Accuracy.qmd: Accuracy/genotype concordance of raw genotype calls
	- RuthGates_GP_Recal_Accuracy.qmd: Imputation accuracy/genotype concordance of recalibrated calls following first step of imputation pipeline
	- RuthGates_ImputationAccuracyNovelClean.qmd: Imputation accuracy/genotype concordance of newly imputed sites

4. RuthGates_RelatednessConGen.qmd: Annotated R script for visualization and analyses of relatedness and genomic diversity
	- Input file: pixy_EBonly_pi.txt
	- Input file: AllCHR_GL_allLoci_realign_IGP099_IMP_DR2099_dummyID_binary_fileset_KINGrelate.kin0
	- Input file: AllCHR_ExptIMPfilt_HapParent_Merge_Filt_dummyID_binary_fileset_KINGrelate.kin0
	- Input file: RelatednessKey.csv
	- Input file: AllCHR_ExptIMPfilt_HapParent_Merge_Filt_dummyID_binary_fileset_KINGrelate_matrix.king
	- Input file: AllCHR_ExptIMPfilt_HapParent_Merge_Filt_dummyID_binary_fileset_KINGrelate_matrix.king.id
