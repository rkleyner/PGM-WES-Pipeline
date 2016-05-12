#!/bin/bash



###################################DECLARATION OF PATHS AND VAIRABLES#####################################################3
#working directory location
wdir=

#OTGSNP directory
otgsnp=

#bam file path
rawbamfile=PID1031643-Proband_IonXpress_017_DAAI00349.bam

#target regions path
targetregions=Ion-TargetSeq-Exome-50Mb-hg19_revA-2.bed

#reference sequence path
ref=ucsc.hg19.fasta

#GATK path
gatk=

#omni path
omni=1000G_omni2.5.hg19.vcf

#dbsnp path
dbsnp=dbsnp_138.hg19.vcf

#hapmap path
hapmap=hapmap_3.3.hg19.vcf

#number of cores
cores=

#1000G path
onekG=1000G_phase1.snps.high_confidence.hg19.vcf

#Mills and 1000G gold standard path
goldstad=Mills_and_1000G_gold_standard.indels.hg19.vcf

#picard path
picard=picard-tools-1.137/picard.jar
#################################################CUT_RAW_DATA.sh####################################################

perl $otgsnp/bin/cut_file.pl -i $rawbamfile -o $wdir/TP00005.rawlib.basecaller -base 9999999999999

echo 'CUT_RAW_DATA.sh COMPLETED'

#############################################TMAP.sh########################################################
bedtools bamtofastq -i $wdir/TP00005.rawlib.basecaller.bam -fq $wdir/TP00005.rawlib.basecaller.bam.fastq

tmap mapall \
-f $ref \
-n $cores \
-r $wdir/TP00005.rawlib.basecaller.bam.fastq \
--reads-format fastq \
-o 2 \
-v \
-k \
-Y \
-u stage1 map4 > $wdir/TP00005.bam

echo 'TMAP.sh COMPLETED'

########################################SORTINDEX.sh##############################################################

samtools sort $wdir/TP00005.bam $wdir/TP00005.sorted && samtools index $wdir/TP00005.sorted.bam

echo 'SORTINDEX.sh COMPLETED'

###############################################SPLITBYCHROM.sh#######################################################
samtools view -b $wdir/TP00005.sorted.bam chr1 > $wdir/chr1.bam 
samtools view -b $wdir/TP00005.sorted.bam chr2 > $wdir/chr2.bam 
samtools view -b $wdir/TP00005.sorted.bam chr3 > $wdir/chr3.bam 
samtools view -b $wdir/TP00005.sorted.bam chr4 > $wdir/chr4.bam 
samtools view -b $wdir/TP00005.sorted.bam chr5 > $wdir/chr5.bam 
samtools view -b $wdir/TP00005.sorted.bam chr6 > $wdir/chr6.bam 
samtools view -b $wdir/TP00005.sorted.bam chr7 > $wdir/chr7.bam 
samtools view -b $wdir/TP00005.sorted.bam chr8 > $wdir/chr8.bam 
samtools view -b $wdir/TP00005.sorted.bam chr9 > $wdir/chr9.bam 
samtools view -b $wdir/TP00005.sorted.bam chr10 > $wdir/chr10.bam 
samtools view -b $wdir/TP00005.sorted.bam chr11 > $wdir/chr11.bam 
samtools view -b $wdir/TP00005.sorted.bam chr12 > $wdir/chr12.bam 
samtools view -b $wdir/TP00005.sorted.bam chr13 > $wdir/chr13.bam 
samtools view -b $wdir/TP00005.sorted.bam chr14 > $wdir/chr14.bam 
samtools view -b $wdir/TP00005.sorted.bam chr15 > $wdir/chr15.bam 
samtools view -b $wdir/TP00005.sorted.bam chr16 > $wdir/chr16.bam 
samtools view -b $wdir/TP00005.sorted.bam chr17 > $wdir/chr17.bam 
samtools view -b $wdir/TP00005.sorted.bam chr18 > $wdir/chr18.bam 
samtools view -b $wdir/TP00005.sorted.bam chr19 > $wdir/chr19.bam 
samtools view -b $wdir/TP00005.sorted.bam chr20 > $wdir/chr20.bam 
samtools view -b $wdir/TP00005.sorted.bam chr21 > $wdir/chr21.bam 
samtools view -b $wdir/TP00005.sorted.bam chr22 > $wdir/chr22.bam 
samtools view -b $wdir/TP00005.sorted.bam chrX > $wdir/chrX.bam 
samtools view -b $wdir/TP00005.sorted.bam chrY > $wdir/chrY.bam 
samtools view -b $wdir/TP00005.sorted.bam chrM > $wdir/chrM.bam 

echo 'SPLITBYCHROM.sh COMPLETED'

##################################################RMDUP.sh################################################################

perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr1.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr2.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr3.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr4.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr5.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr6.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr7.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr8.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr9.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr10.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr11.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr12.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr13.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr14.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr15.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr16.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr17.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr18.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr19.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr20.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr21.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chr22.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chrX.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chrY.bam -a 160 -o $wdir/
perl $otgsnp/bin/rmdup_ali_in_pipeline_RDAA.pl -i $wdir/chrM.bam -a 160 -o $wdir/

echo 'RMDUP.sh COMPLETED'

################################merge.TP0005.QC2.sh##############################################

samtools merge $wdir/TP00005.rmdup.bam $wdir/chr1.rmDup_sorted.bam $wdir/chr2.rmDup_sorted.bam $wdir/chr3.rmDup_sorted.bam $wdir/chr4.rmDup_sorted.bam $wdir/chr5.rmDup_sorted.bam $wdir/chr6.rmDup_sorted.bam $wdir/chr7.rmDup_sorted.bam $wdir/chr8.rmDup_sorted.bam $wdir/chr9.rmDup_sorted.bam $wdir/chr10.rmDup_sorted.bam $wdir/chr11.rmDup_sorted.bam $wdir/chr12.rmDup_sorted.bam $wdir/chr13.rmDup_sorted.bam $wdir/chr14.rmDup_sorted.bam $wdir/chr15.rmDup_sorted.bam $wdir/chr16.rmDup_sorted.bam $wdir/chr17.rmDup_sorted.bam $wdir/chr18.rmDup_sorted.bam $wdir/chr19.rmDup_sorted.bam $wdir/chr20.rmDup_sorted.bam $wdir/chr21.rmDup_sorted.bam $wdir/chr22.rmDup_sorted.bam $wdir/chrX.rmDup_sorted.bam $wdir/chrY.rmDup_sorted.bam $wdir/chrM.rmDup_sorted.bam && samtools index $wdir/TP00005.rmdup.bam

echo 'merge.TP0005.QC2.sh COMPLETED'

########################################pre_gatk.sh##############################################################

perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr1.rmDup_sorted.bam -r 0.2 -pre $wdir/chr1
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr2.rmDup_sorted.bam -r 0.2 -pre $wdir/chr2
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr3.rmDup_sorted.bam -r 0.2 -pre $wdir/chr3
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr4.rmDup_sorted.bam -r 0.2 -pre $wdir/chr4
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr5.rmDup_sorted.bam -r 0.2 -pre $wdir/chr5
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr6.rmDup_sorted.bam -r 0.2 -pre $wdir/chr6
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr7.rmDup_sorted.bam -r 0.2 -pre $wdir/chr7
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr8.rmDup_sorted.bam -r 0.2 -pre $wdir/chr8
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr9.rmDup_sorted.bam -r 0.2 -pre $wdir/chr9
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr10.rmDup_sorted.bam -r 0.2 -pre $wdir/chr10
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr11.rmDup_sorted.bam -r 0.2 -pre $wdir/chr11
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr12.rmDup_sorted.bam -r 0.2 -pre $wdir/chr12
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr13.rmDup_sorted.bam -r 0.2 -pre $wdir/chr13
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr14.rmDup_sorted.bam -r 0.2 -pre $wdir/chr14
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr15.rmDup_sorted.bam -r 0.2 -pre $wdir/chr15
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr16.rmDup_sorted.bam -r 0.2 -pre $wdir/chr16
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr17.rmDup_sorted.bam -r 0.2 -pre $wdir/chr17
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr18.rmDup_sorted.bam -r 0.2 -pre $wdir/chr18
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr19.rmDup_sorted.bam -r 0.2 -pre $wdir/chr19
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr20.rmDup_sorted.bam -r 0.2 -pre $wdir/chr20
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr21.rmDup_sorted.bam -r 0.2 -pre $wdir/chr21
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chr22.rmDup_sorted.bam -r 0.2 -pre $wdir/chr22
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chrX.rmDup_sorted.bam -r 0.2 -pre $wdir/chrX
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chrY.rmDup_sorted.bam -r 0.2 -pre $wdir/chrY
perl $otgsnp/bin/proton_pre_snp_v1_AOS.pl -b $wdir/chrM.rmDup_sorted.bam -r 0.2 -pre $wdir/chrM

echo 'PREGATK.sh COMPLETED'

#################################################TOTALGATK########################################

#################################################TOTALGATK##################################################

#CHR1

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr1.bam -R $ref -o $wdir/chr1.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr1.bam -R $ref -targetIntervals $wdir/chr1.intervals -known $onekG -known $goldstad -o $wdir/chr1.sort.fix.bam && samtools index $wdir/chr1.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr1.sort.fix.bam O=$wdir/chr1.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr1.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr1.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr1.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr1.sort2.fix.bam -R $ref -BQSR $wdir/chr1.sort.fix.bam.brecal.grp -o $wdir/chr1.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr1.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr1.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr1.genotyper.vcf -glm BOTH

echo 'TOTALGATK CHR1 COMPLETED'

#CHR2

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr2.bam -R $ref -o $wdir/chr2.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr2.bam -R $ref -targetIntervals $wdir/chr2.intervals -known $onekG -known $goldstad -o $wdir/chr2.sort.fix.bam && samtools index $wdir/chr2.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr2.sort.fix.bam O=$wdir/chr2.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr2.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr2.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr2.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr2.sort2.fix.bam -R $ref -BQSR $wdir/chr2.sort.fix.bam.brecal.grp -o $wdir/chr2.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr2.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr2.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr2.genotyper.vcf -glm BOTH



echo 'CHR2 COMPLETED'

#CHR3

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr3.bam -R $ref -o $wdir/chr3.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr3.bam -R $ref -targetIntervals $wdir/chr3.intervals -known $onekG -known $goldstad -o $wdir/chr3.sort.fix.bam && samtools index $wdir/chr3.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr3.sort.fix.bam O=$wdir/chr3.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr3.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr3.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr3.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr3.sort2.fix.bam -R $ref -BQSR $wdir/chr3.sort.fix.bam.brecal.grp -o $wdir/chr3.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr3.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr3.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr3.genotyper.vcf -glm BOTH


#CHR4
java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr4.bam -R $ref -o $wdir/chr4.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr4.bam -R $ref -targetIntervals $wdir/chr4.intervals -known $onekG -known $goldstad -o $wdir/chr4.sort.fix.bam && samtools index $wdir/chr4.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr4.sort.fix.bam O=$wdir/chr4.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr4.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr4.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr4.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr4.sort2.fix.bam -R $ref -BQSR $wdir/chr4.sort.fix.bam.brecal.grp -o $wdir/chr4.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr4.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr4.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr4.genotyper.vcf -glm BOTH


echo 'CHR4 COMPLETED'

#CHR5

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr5.bam -R $ref -o $wdir/chr5.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr5.bam -R $ref -targetIntervals $wdir/chr5.intervals -known $onekG -known $goldstad -o $wdir/chr5.sort.fix.bam && samtools index $wdir/chr5.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr5.sort.fix.bam O=$wdir/chr5.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr5.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr5.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr5.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr5.sort2.fix.bam -R $ref -BQSR $wdir/chr5.sort.fix.bam.brecal.grp -o $wdir/chr5.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr5.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr5.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr5.genotyper.vcf -glm BOTH



echo 'CHR5 COMPLETED'

#CHR6

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr6.bam -R $ref -o $wdir/chr6.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr6.bam -R $ref -targetIntervals $wdir/chr6.intervals -known $onekG -known $goldstad -o $wdir/chr6.sort.fix.bam && samtools index $wdir/chr6.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr6.sort.fix.bam O=$wdir/chr6.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr6.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr6.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr6.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr6.sort2.fix.bam -R $ref -BQSR $wdir/chr6.sort.fix.bam.brecal.grp -o $wdir/chr6.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr6.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr6.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr6.genotyper.vcf -glm BOTH


echo 'CHR6 COMPLETED'

#CHR7

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr7.bam -R $ref -o $wdir/chr7.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr7.bam -R $ref -targetIntervals $wdir/chr7.intervals -known $onekG -known $goldstad -o $wdir/chr7.sort.fix.bam && samtools index $wdir/chr7.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr7.sort.fix.bam O=$wdir/chr7.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr7.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr7.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr7.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr7.sort2.fix.bam -R $ref -BQSR $wdir/chr7.sort.fix.bam.brecal.grp -o $wdir/chr7.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr7.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr7.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr7.genotyper.vcf -glm BOTH


echo 'CHR7 COMPLETED'

#CHR8

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr8.bam -R $ref -o $wdir/chr8.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr8.bam -R $ref -targetIntervals $wdir/chr8.intervals -known $onekG -known $goldstad -o $wdir/chr8.sort.fix.bam && samtools index $wdir/chr8.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr8.sort.fix.bam O=$wdir/chr8.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr8.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr8.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr8.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr8.sort2.fix.bam -R $ref -BQSR $wdir/chr8.sort.fix.bam.brecal.grp -o $wdir/chr8.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr8.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr8.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr8.genotyper.vcf -glm BOTH


echo 'CHR8 COMPLETED'

#CHR9
java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr9.bam -R $ref -o $wdir/chr9.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr9.bam -R $ref -targetIntervals $wdir/chr9.intervals -known $onekG -known $goldstad -o $wdir/chr9.sort.fix.bam && samtools index $wdir/chr9.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr9.sort.fix.bam O=$wdir/chr9.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr9.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr9.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr9.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr9.sort2.fix.bam -R $ref -BQSR $wdir/chr9.sort.fix.bam.brecal.grp -o $wdir/chr9.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr9.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr9.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr9.genotyper.vcf -glm BOTH


echo 'CHR9 COMPLETED'

#CHR10

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr10.bam -R $ref -o $wdir/chr10.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr10.bam -R $ref -targetIntervals $wdir/chr10.intervals -known $onekG -known $goldstad -o $wdir/chr10.sort.fix.bam && samtools index $wdir/chr10.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr10.sort.fix.bam O=$wdir/chr10.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr10.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr10.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr10.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr10.sort2.fix.bam -R $ref -BQSR $wdir/chr10.sort.fix.bam.brecal.grp -o $wdir/chr10.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr10.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr10.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr10.genotyper.vcf -glm BOTH


echo 'CHR10 COMPLETED'

#CHR11

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr11.bam -R $ref -o $wdir/chr11.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr11.bam -R $ref -targetIntervals $wdir/chr11.intervals -known $onekG -known $goldstad -o $wdir/chr11.sort.fix.bam && samtools index $wdir/chr11.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr11.sort.fix.bam O=$wdir/chr11.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr11.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr11.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr11.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr11.sort2.fix.bam -R $ref -BQSR $wdir/chr11.sort.fix.bam.brecal.grp -o $wdir/chr11.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr11.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr11.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr11.genotyper.vcf -glm BOTH


echo 'CHR 11 COMPLETED'

#CHR12

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr12.bam -R $ref -o $wdir/chr12.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr12.bam -R $ref -targetIntervals $wdir/chr12.intervals -known $onekG -known $goldstad -o $wdir/chr12.sort.fix.bam && samtools index $wdir/chr12.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr12.sort.fix.bam O=$wdir/chr12.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr12.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr12.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr12.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr12.sort2.fix.bam -R $ref -BQSR $wdir/chr12.sort.fix.bam.brecal.grp -o $wdir/chr12.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr12.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr12.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr12.genotyper.vcf -glm BOTH


echo 'CHR12 COMPLETED'

#CHR13

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr13.bam -R $ref -o $wdir/chr13.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr13.bam -R $ref -targetIntervals $wdir/chr13.intervals -known $onekG -known $goldstad -o $wdir/chr13.sort.fix.bam && samtools index $wdir/chr13.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr13.sort.fix.bam O=$wdir/chr13.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr13.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr13.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr13.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr13.sort2.fix.bam -R $ref -BQSR $wdir/chr13.sort.fix.bam.brecal.grp -o $wdir/chr13.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr13.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr13.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr13.genotyper.vcf -glm BOTH


echo 'CHR13 COMPLETED'

#CHR14

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr14.bam -R $ref -o $wdir/chr14.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr14.bam -R $ref -targetIntervals $wdir/chr14.intervals -known $onekG -known $goldstad -o $wdir/chr14.sort.fix.bam && samtools index $wdir/chr14.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr14.sort.fix.bam O=$wdir/chr14.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr14.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr14.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr14.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr14.sort2.fix.bam -R $ref -BQSR $wdir/chr14.sort.fix.bam.brecal.grp -o $wdir/chr14.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr14.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr14.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr14.genotyper.vcf -glm BOTH



echo 'CHR14 COMPLETED'

#CHR15

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr15.bam -R $ref -o $wdir/chr15.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr15.bam -R $ref -targetIntervals $wdir/chr15.intervals -known $onekG -known $goldstad -o $wdir/chr15.sort.fix.bam && samtools index $wdir/chr15.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr15.sort.fix.bam O=$wdir/chr15.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr15.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr15.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr15.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr15.sort2.fix.bam -R $ref -BQSR $wdir/chr15.sort.fix.bam.brecal.grp -o $wdir/chr15.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr15.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr15.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr15.genotyper.vcf -glm BOTH


echo 'CHR15 COMPLETED'

#CHR16

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr16.bam -R $ref -o $wdir/chr16.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr16.bam -R $ref -targetIntervals $wdir/chr16.intervals -known $onekG -known $goldstad -o $wdir/chr16.sort.fix.bam && samtools index $wdir/chr16.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr16.sort.fix.bam O=$wdir/chr16.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr16.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr16.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr16.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr16.sort2.fix.bam -R $ref -BQSR $wdir/chr16.sort.fix.bam.brecal.grp -o $wdir/chr16.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr16.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr16.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr16.genotyper.vcf -glm BOTH


echo 'CHR16 COMPLETED'

#CHR17

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr17.bam -R $ref -o $wdir/chr17.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr17.bam -R $ref -targetIntervals $wdir/chr17.intervals -known $onekG -known $goldstad -o $wdir/chr17.sort.fix.bam && samtools index $wdir/chr17.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr17.sort.fix.bam O=$wdir/chr17.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr17.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr17.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr17.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr17.sort2.fix.bam -R $ref -BQSR $wdir/chr17.sort.fix.bam.brecal.grp -o $wdir/chr17.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr17.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr17.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr17.genotyper.vcf -glm BOTH


echo 'CHR17 COMPLETED'

#CHR18

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr18.bam -R $ref -o $wdir/chr18.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr18.bam -R $ref -targetIntervals $wdir/chr18.intervals -known $onekG -known $goldstad -o $wdir/chr18.sort.fix.bam && samtools index $wdir/chr18.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr18.sort.fix.bam O=$wdir/chr18.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr18.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr18.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr18.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr18.sort2.fix.bam -R $ref -BQSR $wdir/chr18.sort.fix.bam.brecal.grp -o $wdir/chr18.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr18.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr18.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr18.genotyper.vcf -glm BOTH


echo 'CHR 18 COMPLETED'

#CHR19

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr19.bam -R $ref -o $wdir/chr19.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr19.bam -R $ref -targetIntervals $wdir/chr19.intervals -known $onekG -known $goldstad -o $wdir/chr19.sort.fix.bam && samtools index $wdir/chr19.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr19.sort.fix.bam O=$wdir/chr19.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr19.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr19.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr19.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr19.sort2.fix.bam -R $ref -BQSR $wdir/chr19.sort.fix.bam.brecal.grp -o $wdir/chr19.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr19.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr19.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr19.genotyper.vcf -glm BOTH


echo 'CHR19 COMPLETED'

#CHR20

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr20.bam -R $ref -o $wdir/chr20.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr20.bam -R $ref -targetIntervals $wdir/chr20.intervals -known $onekG -known $goldstad -o $wdir/chr20.sort.fix.bam && samtools index $wdir/chr20.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr20.sort.fix.bam O=$wdir/chr20.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr20.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr20.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr20.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr20.sort2.fix.bam -R $ref -BQSR $wdir/chr20.sort.fix.bam.brecal.grp -o $wdir/chr20.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr20.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr20.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr20.genotyper.vcf -glm BOTH


echo 'CHR20 COMPLETED'

#CHR21

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr21.bam -R $ref -o $wdir/chr21.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr21.bam -R $ref -targetIntervals $wdir/chr21.intervals -known $onekG -known $goldstad -o $wdir/chr21.sort.fix.bam && samtools index $wdir/chr21.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr21.sort.fix.bam O=$wdir/chr21.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr21.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr21.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr21.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr21.sort2.fix.bam -R $ref -BQSR $wdir/chr21.sort.fix.bam.brecal.grp -o $wdir/chr21.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr21.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr21.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr21.genotyper.vcf -glm BOTH


echo 'CHR21 COMPLETED'

#CHR22

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chr22.bam -R $ref -o $wdir/chr22.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chr22.bam -R $ref -targetIntervals $wdir/chr22.intervals -known $onekG -known $goldstad -o $wdir/chr22.sort.fix.bam && samtools index $wdir/chr22.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chr22.sort.fix.bam O=$wdir/chr22.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chr22.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chr22.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chr22.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chr22.sort2.fix.bam -R $ref -BQSR $wdir/chr22.sort.fix.bam.brecal.grp -o $wdir/chr22.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chr22.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chr22.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chr22.genotyper.vcf -glm BOTH


echo 'CHR22 COMPLETED'

#CHRM

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chrM.bam -R $ref -o $wdir/chrM.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chrM.bam -R $ref -targetIntervals $wdir/chrM.intervals -known $onekG -known $goldstad -o $wdir/chrM.sort.fix.bam && samtools index $wdir/chrM.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chrM.sort.fix.bam O=$wdir/chrM.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chrM.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chrM.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chrM.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chrM.sort2.fix.bam -R $ref -BQSR $wdir/chrM.sort.fix.bam.brecal.grp -o $wdir/chrM.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chrM.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chrM.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chrM.genotyper.vcf -glm BOTH


echo 'CHRM COMPLETED'

#CHRX

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chrX.bam -R $ref -o $wdir/chrX.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chrX.bam -R $ref -targetIntervals $wdir/chrX.intervals -known $onekG -known $goldstad -o $wdir/chrX.sort.fix.bam && samtools index $wdir/chrX.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chrX.sort.fix.bam O=$wdir/chrX.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chrX.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chrX.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chrX.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chrX.sort2.fix.bam -R $ref -BQSR $wdir/chrX.sort.fix.bam.brecal.grp -o $wdir/chrX.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chrX.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chrX.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chrX.genotyper.vcf -glm BOTH


echo 'CHRX COMPLETED'

#CHRY

java -jar $gatk/GenomeAnalysisTK.jar -T RealignerTargetCreator -nt $cores -l INFO -I $wdir/chrY.bam -R $ref -o $wdir/chrY.intervals -known $onekG -known $goldstad

java -jar $gatk/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I $wdir/chrY.bam -R $ref -targetIntervals $wdir/chrY.intervals -known $onekG -known $goldstad -o $wdir/chrY.sort.fix.bam && samtools index $wdir/chrY.sort.fix.bam 

java -jar /sonas-hs/lyon/hpc/home/rkleyner/tools/picard-tools-1.137/picard.jar AddOrReplaceReadGroups I=$wdir/chrY.sort.fix.bam O=$wdir/chrY.sort2.fix.bam RGLB=NA RGPU=N/A PL=IONTORRENT SM=NA 

samtools index $wdir/chrY.sort2.fix.bam

java -jar $gatk/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I $wdir/chrY.sort2.fix.bam -R $ref -knownSites $dbsnp -knownSites $onekG -knownSites $goldstad -o $wdir/chrY.sort.fix.bam.brecal.grp -nct $cores 

java -jar $gatk/GenomeAnalysisTK.jar -T PrintReads -l INFO -I $wdir/chrY.sort2.fix.bam -R $ref -BQSR $wdir/chrY.sort.fix.bam.brecal.grp -o $wdir/chrY.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' && samtools index $wdir/chrY.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}'

java -jar $gatk/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I $wdir/chrY.sort.fix.brecal.bam --dbsnp $dbsnp -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -R $ref -o $wdir/chrY.genotyper.vcf -glm BOTH


echo 'CHRY COMPLETED'


#########################################all.vqsr.sh########################################################
perl $otgsnp/bin/get_order_vcf.pl $ref $targetregions TP00005 $wdir && java -jar $gatk/GenomeAnalysisTK.jar -T VariantRecalibrator -l INFO -R $ref --mode BOTH -input $wdir/TP00005.genotyper.new.vcf -resource:hapmap,known=false,training=true,truth=true,prior=15.0 $hapmap  -resource:omni,known=false,training=true,truth=false,prior=12.0 $omni -resource:dbsnp,known=true,training=false,truth=false,prior=6.0 $dbsnp -an QD -an HaplotypeScore -an MQRankSum -an ReadPosRankSum -an FS -an MQ -recalFile $wdir/TP00005.recal -tranchesFile $wdir/TP00005.tranches -rscriptFile $wdir/TP00005.plot.R --maxGaussians 4 && java -jar $gatk/GenomeAnalysisTK.jar -T ApplyRecalibration -l INFO -R $ref -input $wdir/TP00005.genotyper.new.vcf --ts_filter_level 99.0 -tranchesFile $wdir/TP00005.tranches -recalFile $wdir/TP00005.recal -o $wdir/TP00005.vqsr.vcf


echo 'all.vqsr.sh COMPLETED'

###########################################all_indel_filter.sh############################################

samtools mpileup -f $ref $wdir/chr1.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr1.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr1.pileup $wdir/chr1.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr1.genotyper.vcf -pileup $wdir/chr1.snp.indel -o $wdir/chr1.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr1.indel1 -g $ref -chr chr1 -o $wdir/chr1.final.indel
samtools mpileup -f $ref $wdir/chr2.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr2.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr2.pileup $wdir/chr2.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr2.genotyper.vcf -pileup $wdir/chr2.snp.indel -o $wdir/chr2.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr2.indel1 -g $ref -chr chr2 -o $wdir/chr2.final.indel
samtools mpileup -f $ref $wdir/chr3.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr3.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr3.pileup $wdir/chr3.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr3.genotyper.vcf -pileup $wdir/chr3.snp.indel -o $wdir/chr3.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr3.indel1 -g $ref -chr chr3 -o $wdir/chr3.final.indel
samtools mpileup -f $ref $wdir/chr4.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr4.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr4.pileup $wdir/chr4.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr4.genotyper.vcf -pileup $wdir/chr4.snp.indel -o $wdir/chr4.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr4.indel1 -g $ref -chr chr4 -o $wdir/chr4.final.indel
samtools mpileup -f $ref $wdir/chr5.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr5.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr5.pileup $wdir/chr5.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr5.genotyper.vcf -pileup $wdir/chr5.snp.indel -o $wdir/chr5.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr5.indel1 -g $ref -chr chr5 -o $wdir/chr5.final.indel
samtools mpileup -f $ref $wdir/chr6.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr6.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr6.pileup $wdir/chr6.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr6.genotyper.vcf -pileup $wdir/chr6.snp.indel -o $wdir/chr6.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr6.indel1 -g $ref -chr chr6 -o $wdir/chr6.final.indel
samtools mpileup -f $ref $wdir/chr7.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr7.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr7.pileup $wdir/chr7.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr7.genotyper.vcf -pileup $wdir/chr7.snp.indel -o $wdir/chr7.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr7.indel1 -g $ref -chr chr7 -o $wdir/chr7.final.indel
samtools mpileup -f $ref $wdir/chr8.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr8.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr8.pileup $wdir/chr8.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr8.genotyper.vcf -pileup $wdir/chr8.snp.indel -o $wdir/chr8.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr8.indel1 -g $ref -chr chr8 -o $wdir/chr8.final.indel
samtools mpileup -f $ref $wdir/chr9.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr9.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr9.pileup $wdir/chr9.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr9.genotyper.vcf -pileup $wdir/chr9.snp.indel -o $wdir/chr9.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr9.indel1 -g $ref -chr chr9 -o $wdir/chr9.final.indel
samtools mpileup -f $ref $wdir/chr10.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr10.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr10.pileup $wdir/chr10.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr10.genotyper.vcf -pileup $wdir/chr10.snp.indel -o $wdir/chr10.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr10.indel1 -g $ref -chr chr10 -o $wdir/chr10.final.indel 
samtools mpileup -f $ref $wdir/chr11.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr11.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr11.pileup $wdir/chr11.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr11.genotyper.vcf -pileup $wdir/chr11.snp.indel -o $wdir/chr11.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr11.indel1 -g $ref -chr chr11 -o $wdir/chr11.final.indel
samtools mpileup -f $ref $wdir/chr12.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr12.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr12.pileup $wdir/chr12.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr12.genotyper.vcf -pileup $wdir/chr12.snp.indel -o $wdir/chr12.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr12.indel1 -g $ref -chr chr12 -o $wdir/chr12.final.indel
samtools mpileup -f $ref $wdir/chr13.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr13.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr13.pileup $wdir/chr13.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr13.genotyper.vcf -pileup $wdir/chr13.snp.indel -o $wdir/chr13.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr13.indel1 -g $ref -chr chr13 -o $wdir/chr13.final.indel
samtools mpileup -f $ref $wdir/chr14.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr14.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr14.pileup $wdir/chr14.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr14.genotyper.vcf -pileup $wdir/chr14.snp.indel -o $wdir/chr14.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr14.indel1 -g $ref -chr chr14 -o $wdir/chr14.final.indel
samtools mpileup -f $ref $wdir/chr15.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr15.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr15.pileup $wdir/chr15.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr15.genotyper.vcf -pileup $wdir/chr15.snp.indel -o $wdir/chr15.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr15.indel1 -g $ref -chr chr15 -o $wdir/chr15.final.indel
samtools mpileup -f $ref $wdir/chr16.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr16.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr16.pileup $wdir/chr16.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr16.genotyper.vcf -pileup $wdir/chr16.snp.indel -o $wdir/chr16.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr16.indel1 -g $ref -chr chr16 -o $wdir/chr16.final.indel
samtools mpileup -f $ref $wdir/chr17.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr17.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr17.pileup $wdir/chr17.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr17.genotyper.vcf -pileup $wdir/chr17.snp.indel -o $wdir/chr17.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr17.indel1 -g $ref -chr chr17 -o $wdir/chr17.final.indel
samtools mpileup -f $ref $wdir/chr18.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr18.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr18.pileup $wdir/chr18.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr18.genotyper.vcf -pileup $wdir/chr18.snp.indel -o $wdir/chr18.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr18.indel1 -g $ref -chr chr18 -o $wdir/chr18.final.indel
samtools mpileup -f $ref $wdir/chr19.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr19.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr19.pileup $wdir/chr19.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr19.genotyper.vcf -pileup $wdir/chr19.snp.indel -o $wdir/chr19.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr19.indel1 -g $ref -chr chr19 -o $wdir/chr19.final.indel
samtools mpileup -f $ref $wdir/chr20.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr20.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr20.pileup $wdir/chr20.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr20.genotyper.vcf -pileup $wdir/chr20.snp.indel -o $wdir/chr20.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr20.indel1 -g $ref -chr chr20 -o $wdir/chr20.final.indel
samtools mpileup -f $ref $wdir/chr21.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr21.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr21.pileup $wdir/chr21.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr21.genotyper.vcf -pileup $wdir/chr21.snp.indel -o $wdir/chr21.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr21.indel1 -g $ref -chr chr21 -o $wdir/chr21.final.indel
samtools mpileup -f $ref $wdir/chr22.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chr22.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chr22.pileup $wdir/chr22.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chr22.genotyper.vcf -pileup $wdir/chr22.snp.indel -o $wdir/chr22.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chr22.indel1 -g $ref -chr chr22 -o $wdir/chr22.final.indel
samtools mpileup -f $ref $wdir/chrX.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chrX.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chrX.pileup $wdir/chrX.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chrX.genotyper.vcf -pileup $wdir/chrX.snp.indel -o $wdir/chrX.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chrX.indel1 -g $ref -chr chrX -o $wdir/chrX.final.indel
samtools mpileup -f $ref $wdir/chrY.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chrY.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chrY.pileup $wdir/chrY.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chrY.genotyper.vcf -pileup $wdir/chrY.snp.indel -o $wdir/chrY.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chrY.indel1 -g $ref -chr chrY -o $wdir/chrY.final.indel
samtools mpileup -f $ref $wdir/chrM.sort.fix.brecal.bam | awk '{if($4 != 0) print $0}' > $wdir/chrM.pileup && perl $otgsnp/bin/pileup_analyse.pl $wdir/chrM.pileup $wdir/chrM.snp.indel && perl $otgsnp/bin/fitter_indel_bias.pl -vcf $wdir/chrM.genotyper.vcf -pileup $wdir/chrM.snp.indel -o $wdir/chrM.indel1 && perl $otgsnp/bin/fitter_indel_homo2.pl -vcf $wdir/chrM.indel1 -g $ref -chr chrM -o $wdir/chrM.final.indel

echo 'ALL INDEL FILTER.sh COMPLETED'

########################################################FINAL STEPS######################################################################

cat $wdir/chr1.final.indel $wdir/chr2.final.indel $wdir/chr3.final.indel $wdir/chr4.final.indel $wdir/chr5.final.indel $wdir/chr6.final.indel $wdir/chr7.final.indel $wdir/chr8.final.indel $wdir/chr9.final.indel $wdir/chr10.final.indel $wdir/chr11.final.indel $wdir/chr12.final.indel $wdir/chr13.final.indel $wdir/chr14.final.indel $wdir/chr15.final.indel $wdir/chr16.final.indel $wdir/chr17.final.indel $wdir/chr18.final.indel $wdir/chr19.final.indel $wdir/chr20.final.indel $wdir/chr21.final.indel $wdir/chr22.final.indel $wdir/chrX.final.indel $wdir/chrY.final.indel $wdir/chrM.final.indel > $wdir/TP00005.indel && cat $wdir/TP00005.head $wdir/TP00005.indel > $wdir/TP00005.indel.vcf 

perl $otgsnp/bin/seprate_snp.pl $wdir/TP00005.vqsr.vcf $wdir/TP00005.snp.vcf

echo 'FINAL STEPS COMPLETED'

echo 'INDEL=TP00005.indel.vcf'

echo 'SNP=TP0005.snp.vcf'

echo 'ALL FILES LOCATED IN WORKING DIRECTORY'









