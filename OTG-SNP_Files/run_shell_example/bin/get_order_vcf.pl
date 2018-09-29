#!/usr/bin/perl 
use strict;
my $genome=shift;
my $bed=shift;
my $sp=shift;
my @chrome;
my %hash;
my @chrome_new;
my @store;
open IN,"$genome";
while (my $line=<IN>)
{
	chomp $line;
	if($line=~/^>/)
	{
		 @store=split />/,$line;
		push (@chrome,$store[1]);
	}
#	push (@chrome,$store[1]);
}
close IN;
open IN1,"$bed";
while (my $line1=<IN1>)
{
	chomp $line1;
	@store=split /\s+/,$line1;
	$hash{$store[0]}=1;
}
close IN1;
foreach my $a (@chrome)
{
	if (exists $hash{$a})
	{
	push (@chrome_new,$a);
	}
}
my $b=shift (@chrome_new);
`cp ../$sp/$b/$b.genotyper.vcf  ../$sp/$sp.genotyper.new.vcf`;
`awk '{if((\$1~/#/)) print \$0}' ../$sp/$b/$b.genotyper.vcf > ../$sp/$sp.head`;
foreach my $c (@chrome_new)
{
`awk '{if(!(\$1~/#/)) print \$0}' ../$sp/$c/$c.genotyper.vcf >> ../$sp/$sp.genotyper.new.vcf`;
}

