#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=18:00:00
#SBATCH --mem=32G
#SBATCH --error=%x_%j.err
#SBATCH --output=%x_%j.out
##SBATCH --mail-type=END
##SBATCH --mail-user=<yourname>@usc.edu

# enter your job environment parameters here

mamba activate /project/ckenkel_26/condaEnvs/angsd

### commands

# Be sure to modify -minInd flag and -nInd flags below for each run - I've selected 80% of total N = 157

# must have file called goodbams, listing all the bams you want to analyze

export GENOME_REF=/project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta

# common name prefix for all files to be generated
export NAM=het

# collecting filter-passing sites to work on (all sites, not just variable ones)
# most important filters here are -minInd:  the site must be genotyped in at least that many individuals (guards against DNA contaminations) and -setMinDepthInd as this restricts analysis to sites that have a min coverage of X in all individuals. I go with ALL individuals when possible (so all .bam files) for -minInd and minDepth of 5 (this threshold can be adjusted I think) 
#NOTE: if you have some poor coverage samples (e.g. if the qranks value is VERY low relative to the others) you can reduce minInd to exclude those few samples (e.g. pick 113 instead of 116 to exclude the 3 crappiest) and this will then reduce the N sites in the Ho calculation for those crappy samples, but they will still be a subset of the SAME sites used in the other samples, as opposed to completely different subsets of sites 

#FILTERS='-minInd 150 -setMinDepthInd 1 -setMaxDepthInd 15 -uniqueOnly 1 -skipTriallelic 1 -minMapQ 30 -minQ 25 -doHWE 1 -hetbias_pval 1e-5'
#TODO="-doSaf 1 -anc $GENOME_REF -ref $GENOME_REF -doMajorMinor 1 -doMaf 1 -dosnpstat 1 -doPost 1 -doGlf 2 -doCounts 1 -dumpCounts 1"
# list of all sites passing minInd and hetbias filters
#angsd -b bams -GL 1 -P 4 $FILTERS $TODO -out $NAM 

# writing down list of sites and indexing
#zcat ${NAM}.mafs.gz | cut -f 1,2 | tail -n +2 >${NAM}.sites
#angsd sites index ${NAM}.sites

# writing down chromosomes
#zcat ${NAM}.mafs.gz | cut -f 1 | uniq | grep -v 'chromo' | sed 's/$/:/' > ${NAM}.regions


angsd -i 21073D-02-01_S97_L002.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-01_S97_L002.host.marked_duplicates && realSFS 21073D-02-01_S97_L002.host.marked_duplicates.saf.idx >21073D-02-01_S97_L002.host.marked_duplicates.ml && awk -v file=21073D-02-01_S97_L002.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-01_S97_L002.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-02_S99_L002.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-02_S99_L002.host.marked_duplicates && realSFS 21073D-02-02_S99_L002.host.marked_duplicates.saf.idx >21073D-02-02_S99_L002.host.marked_duplicates.ml && awk -v file=21073D-02-02_S99_L002.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-02_S99_L002.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-03_S86_L002.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-03_S86_L002.host.marked_duplicates && realSFS 21073D-02-03_S86_L002.host.marked_duplicates.saf.idx >21073D-02-03_S86_L002.host.marked_duplicates.ml && awk -v file=21073D-02-03_S86_L002.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-03_S86_L002.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-04_S0_L001.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-04_S0_L001.host.marked_duplicates && realSFS 21073D-02-04_S0_L001.host.marked_duplicates.saf.idx >21073D-02-04_S0_L001.host.marked_duplicates.ml && awk -v file=21073D-02-04_S0_L001.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-04_S0_L001.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-05_S0_L001.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-05_S0_L001.host.marked_duplicates && realSFS 21073D-02-05_S0_L001.host.marked_duplicates.saf.idx >21073D-02-05_S0_L001.host.marked_duplicates.ml && awk -v file=21073D-02-05_S0_L001.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-05_S0_L001.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-06_S0_L001.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-06_S0_L001.host.marked_duplicates && realSFS 21073D-02-06_S0_L001.host.marked_duplicates.saf.idx >21073D-02-06_S0_L001.host.marked_duplicates.ml && awk -v file=21073D-02-06_S0_L001.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-06_S0_L001.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-07_S0_L001.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-07_S0_L001.host.marked_duplicates && realSFS 21073D-02-07_S0_L001.host.marked_duplicates.saf.idx >21073D-02-07_S0_L001.host.marked_duplicates.ml && awk -v file=21073D-02-07_S0_L001.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-07_S0_L001.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-08_S94_L002.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-08_S94_L002.host.marked_duplicates && realSFS 21073D-02-08_S94_L002.host.marked_duplicates.saf.idx >21073D-02-08_S94_L002.host.marked_duplicates.ml && awk -v file=21073D-02-08_S94_L002.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-08_S94_L002.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-09_S163_L003.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-09_S163_L003.host.marked_duplicates && realSFS 21073D-02-09_S163_L003.host.marked_duplicates.saf.idx >21073D-02-09_S163_L003.host.marked_duplicates.ml && awk -v file=21073D-02-09_S163_L003.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-09_S163_L003.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-10_S0_L001.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-10_S0_L001.host.marked_duplicates && realSFS 21073D-02-10_S0_L001.host.marked_duplicates.saf.idx >21073D-02-10_S0_L001.host.marked_duplicates.ml && awk -v file=21073D-02-10_S0_L001.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-10_S0_L001.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
angsd -i 21073D-02-11_S102_L002.host.marked_duplicates.bam -anc /project/ckenkel_26/RefSeqs/ApalGenome/ApalmGenome_v3.1/Apalm_assembly_v3.1_200911.masked.fasta -sites het.sites -rf het.regions -uniqueOnly 1 -minMapQ 30 -minQ 25 -GL 1 -doSaf 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -out 21073D-02-11_S102_L002.host.marked_duplicates && realSFS 21073D-02-11_S102_L002.host.marked_duplicates.saf.idx >21073D-02-11_S102_L002.host.marked_duplicates.ml && awk -v file=21073D-02-11_S102_L002.host.marked_duplicates.bam '{print file"\t"($1+$2+$3)"\t"$2/($1+$2+$3)}' 21073D-02-11_S102_L002.host.marked_duplicates.ml >>bamsApalWildFL.goodsites.het
