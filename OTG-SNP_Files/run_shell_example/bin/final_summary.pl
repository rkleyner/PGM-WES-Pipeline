#!/usr/bin/perl 
use strict;
my $sample=shift;
my @storeqc1;
my @storeqc2;
my @storesummary;
my @storedup;
`mv ./rmdup/$sample.rmdup.bam ./result/$sample/result_alignment/`;
`mv ./rmdup/$sample.rmdup.bam.bai ./result/$sample/result_alignment/`;
`cp ./rmdup/$sample/exon_cumu.png ./result/$sample/result_alignment/$sample.Cumulative.png`;
`cp ./rmdup/$sample/exon_depth_frequency.png ./result/$sample/result_alignment/$sample.Depth.png`;
`cp ./anno/$sample/$sample.snp.anno.exome_summary.csv ./result/$sample/result_variation/snp/$sample.snp.exome_summary.annot.csv`;
`cp ./anno/$sample/$sample.snp.anno.genome_summary.csv ./result/$sample/result_variation/snp/$sample.snp.genome_summary.annot.csv`;
`cp ./anno/$sample/$sample.snp.stat.all_stat ./result/$sample/result_variation/snp/$sample.snp.AnnotationTable.xls`;
`cp ./anno/$sample/*.png ./result/$sample/result_variation/indel/ `;
`cp ./anno/$sample/$sample.indel.anno.exome_summary.csv ./result/$sample/result_variation/indel/$sample.indel.exome_summary.annot.csv`;
`cp ./anno/$sample/$sample.indel.anno.genome_summary.csv ./result/$sample/result_variation/indel/$sample.indel.genome_summary.annot.csv`;
`cp ./anno/$sample/$sample.indel.stat.all_stat ./result/$sample/result_variation/indel/$sample.indel.AnnotationTable.xls`;

#`cp ./rmdup/$sdfasdjfmple/summary.txt ./result/$sample/result_alignment/$sample.SummaryTable.xls`;
#`sed -n '6,6p' ./QC/$sample/rawdata_QC2/$sample.mapped.map.stat.xls >> ./result/$sample/result_alignment/$sample.SummaryTable.xls`; `sed -n '3,3p' ./rmdup/$sample/rmDup.stat >> ./result/$sample/result_alignment/$sample.SummaryTable.xls`;
#`cp ./QC/$sample/rawdata_QC1/$sample.unmap.stat.xls ./result/$sample/clean_data/$sample.xls`;
open IN1," ./QC/$sample/rawdata_QC1/$sample.unmap.stat.xls"||die "cant open the file";
while (my $line1=<IN1>)
	{
		chomp $line1;
		my @store=split /\s+/,$line1;
		push(@storeqc1,$store[1]);
	}
open IN2,"./QC/$sample/rawdata_QC2/$sample.mapped.map.stat.xls" ||die "cant open the file";
while (my $line2=<IN2>)
	{
		chomp $line2;
		my @store=split /\s+/,$line2;
		push(@storeqc2,$store[1])
	}
open IN3, "./rmdup/$sample/summary.txt" ||die "cant open the file";
while (my $line3=<IN3>)
	{
		chomp $line3;
		my @store=split /\s+/,$line3;
		push(@storesummary,$store[1]);
	}
open IN4, "./rmdup/$sample/rmDup.stat"||die "cant open the file";
while (my $line4=<IN4>)
	{
		chomp $line4;
		my @store=split /\s+/,$line4;
		push(@storedup,$store[3]);
	}
open OUT,">./result/$sample/result_alignment/$sample.SummaryTable.xls" ||die "cant open the file";
print OUT "Sample\t$sample\n";
print OUT "Total effective reads\t$storeqc1[1]\n";
print OUT "Total effective yield(bp)\t$storeqc1[2]\n";
print OUT "Average read length(bp)\t$storeqc1[13]\n";
print OUT "Effective sequences on target(Mb)\t$storesummary[9]\n";
print OUT "Effective sequences near target(Mb)\t$storesummary[19]\n";
print OUT "Effective sequences on or near target(Mb)\t$storesummary[28]\n";
print OUT "Number of reads uniquely mapped to target\t$storesummary[10]\n";
print OUT "Number of reads uniquely mapped to genome\t$storesummary[2]\n";
print OUT "Capture_Specificity_Reads\t$storesummary[47]\n";
print OUT "Capture_Specificity_Bases\t$storesummary[48]\n";
print OUT "Average sequencing depth on target\t$storesummary[12]\n";
print OUT "Average sequencing depth near target\t$storesummary[22]\n";
print OUT "Mismatch rate in target region\t$storesummary[15]\n";
print OUT "Mismatch rate in all effective sequence\t$storesummary[5]\n";
print OUT "Base covered on target\t$storesummary[13]\n";
print OUT "Coverage of target region\t$storesummary[14]\n";
print OUT "Base covered near target\t$storesummary[23]\n";
print OUT "Coverage of flanking region\t$storesummary[24]\n";
print OUT "Fraction of target covered with at least 20X\t$storesummary[36]\n";
print OUT "Fraction of target covered with at least 10X\t$storesummary[35]\n";
print OUT "Fraction of target covered with at least 4X\t$storesummary[34]\n";
print OUT "Fraction of flanking region covered with at least 20x\t$storesummary[42]\n";
print OUT "Fraction of flanking region covered with at least 10x\t$storesummary[41]\n";
print OUT "Fraction of flanking region covered with at least 4x\t$storesummary[40]\n";
print OUT "Mapping rate\t$storeqc2[5]\n";
print OUT "Duplicate rate\t$storedup[2]\n";
#print "\t\n";
#print "\t\n";
#print "\t\n";
#print "\t\n";
#print "\t\n";	
