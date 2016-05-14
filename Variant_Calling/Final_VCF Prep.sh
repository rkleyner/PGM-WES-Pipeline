#!/bin/bash

#working directory path
wdir=

#tool directory path
otgsnp=

#bam file directory path
rawbamfile=

#target region directory path
targetregions=

#reference path
ref= ucsc.hg19.fasta

#gatk path
gatk=

#picard path
picard = 

java -jar $gatk/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $ref \
-V $wdir/TP00005.vqsr.vcf \
-o $wdir/FINALSNP.vcf \
-L $targetregions \
--excludeFiltered \
--selectTypeToInclude SNP

java -jar $picard SortVcf I=$wdir/TP00005.indel.vcf O=$wdir/TP00005.indelSORTED.vcf 

sed '/^##contig/ d' $wdir/TP00005.indelSORTED.vcf > $wdir/TP00005.indelSORTED2.vcf

java -jar $gatk/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $ref \
-V $wdir/TP00005.indelSORTED2.vcf \
-o $wdir/FINALINDEL.vcf \
-L $targetregions

java -jar $gatk/GenomeAnalysisTK.jar \
-T CombineVariants \
-R $ref \
-V $wdir/FINALINDEL.vcf \
-V $wdir/FINALSNP.vcf \
-o $wdir/COMBINED.vcf \
--genotypemergeoption UNSORTED

