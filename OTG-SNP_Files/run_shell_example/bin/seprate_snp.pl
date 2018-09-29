#!/usr/bin/perl 
my $vcf=shift;
my $snp=shift;
#my $indel=shift;
open IN,"$vcf"||die "cant open the file";
open OUT1,">$snp";
#open OUT2,">$indel";
while (my $line=<IN>)
	{
		chomp $line;
		if($line=~/^#/)
		{
		print OUT1 "$line\n";
		print OUT2 "$line\n";
		}
		else
		{
		my @store=split /\s+/,$line;
		my @aa=split /,/,@store[4];
			if (length($store[3])==length($store[4]) ||(length($store[3])==length($aa[0]) && length($store[3])==length($aa[1])))
				{
					if($store[6] eq "PASS")
						{
						print OUT1 "$line\n";
						}
				}
			else
				{
					if ($store[6] eq ".")
					{
					my $a="";
					#print OUT2 "$line\n";
					}
				}
		}
	}
