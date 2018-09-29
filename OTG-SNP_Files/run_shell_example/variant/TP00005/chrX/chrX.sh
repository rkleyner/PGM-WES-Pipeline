java -Xmx1g -jar ./bin/GenomeAnalysisTK.jar -T RealignerTargetCreator -l INFO -I ../../../pre_variant/TP00005/chrX.bam -R /ifs1/ST_RNA/USER/zhupengyuan/ref/Homo_genome/genome.fa -o chrX.intervals -known /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/1000G_phase1.indels.hg19.vcf.gz -known /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/Mills_and_1000G_gold_standard.indels.hg19.vcf.gz -L ../../../bed/chrX.intervals 
 java -Xmx4g -jar ./bin/GenomeAnalysisTK.jar -T IndelRealigner -l INFO -I ../../../pre_variant/TP00005/chrX.bam -R /ifs1/ST_RNA/USER/zhupengyuan/ref/Homo_genome/genome.fa -targetIntervals  chrX.intervals  -known /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/1000G_phase1.indels.hg19.vcf.gz -known /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/Mills_and_1000G_gold_standard.indels.hg19.vcf.gz  -o chrX.sort.fix.bam -L  ../../../bed/chrX.intervals && ./bin/samtools index ./chrX.sort.fix.bam 
java -Xmx4g -jar ./bin/GenomeAnalysisTK.jar -T BaseRecalibrator -l INFO -I chrX.sort.fix.bam -R /ifs1/ST_RNA/USER/zhupengyuan/ref/Homo_genome/genome.fa  -knownSites /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/dbsnp_137.hg19.vcf.gz -knownSites /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/1000G_phase1.indels.hg19.vcf.gz -knownSites /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/Mills_and_1000G_gold_standard.indels.hg19.vcf.gz -o chrX.sort.fix.bam.brecal.grp  -plots chrX.sort.fix.bam.brecal.plot.pdf -L  ../../../bed/chrX.intervals -nct 8 
 java -Xmx4g -jar ./bin/GenomeAnalysisTK.jar -T PrintReads -l INFO -I chrX.sort.fix.bam -R /ifs1/ST_RNA/USER/zhupengyuan/ref/Homo_genome/genome.fa -BQSR chrX.sort.fix.bam.brecal.grp -o chrX.sort.fix.brecal.bam -L ../../../bed/chrX.intervals && ./bin/samtools index ./chrX.sort.fix.brecal.bam
 java -Xmx4g -jar ./bin/GenomeAnalysisTK.jar -T UnifiedGenotyper -l INFO -I chrX.sort.fix.brecal.bam --dbsnp /ifs1/ST_RNA/USER/liyaqiao/ZPY/rna/bin/GATK/hg19/dbsnp_137.hg19.vcf.gz -stand_call_conf 30 -stand_emit_conf 10 -dcov 1000 -L ../../../bed/chrX.intervals -R /ifs1/ST_RNA/USER/zhupengyuan/ref/Homo_genome/genome.fa  -o chrX.genotyper.vcf -nt 8 -glm BOTH