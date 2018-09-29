#!/usr/bin/perl 
#===============================================================================
#-------------------------------help-info-start--------------------------------#
=head1 Name and Contact 

		FILE: remove_homo.pl

        USAGE: ./remove_homo.pl  

        DESCRIPTION: this project is used to remove indel homopolymer

       AUTHOR: zhupenyuan (NGS), zhupenyuan@genomics.cn
       COMPANY: BGI
       VERSION: 1.0
       CREATED: 06/19/2013 10:35:39 AM

=head1 Usage

    perl  remove_homo.pl [options] [input file]

    -help       print this help to screen
    -o          write result to a file, default print to STDOUT .
    -i 		input file

=head1 Example

    perl  remove_homo.pl -h
    perl  remove_homo.pl

=cut
#-------------------------------help-info-end--------------------------------#
#============================================================================#

use strict;
use warnings;
use Getopt::Long;

my ($Need_help, $Out_file,$Input_file,$genome,$chr );
GetOptions(
    "help"      => \$Need_help,
    "o=s"       => \$Out_file,
    "vcf=s"	=> \$Input_file,
    "g=s"	=> \$genome,
    "chr=s"	=> \$chr,
);

die `pod2text $0` if ($Need_help);

#============================================================================#
#                              Global Variable                               #
#============================================================================#
my %hashvcf;
my %hashbase;
my @base;
my $genome_len;
my $homo;
my $HOMO;
my $vcfbase;
my $flag=0;
#============================================================================#
#                               Main process                                 #
#============================================================================#
open IN,"$Input_file" || die "cant open the file";
open OUT,">$Out_file" || die "cant open the file";
while(my $line=<IN>)
{
	chomp $line;
	unless ($line=~/^#/)
	{
	my @store=split /\s+/,$line;
	if(length($store[3])==2 && length($store[4])==1)
		{
			@base=split //,$store[3];
			$hashbase{$store[1]}=$base[1];
			$hashvcf{$store[1]}=$line;
		}
	if(length($store[3])==1 && length($store[4])==2)
		{
					
			@base=split //,$store[4];
                        $hashbase{$store[1]}=$base[1];
                        $hashvcf{$store[1]}=$line; 
		}
	if (length($store[3])>2 || length($store[4])>2)
		{
			print OUT "$line\n";
		}
	}
}
close IN;
open IN1,"$genome"|| die "cant open the file";
while (my $line1=<IN1>)
	{
	chomp $line1;
	if ($line1=~/^>/)
	{
		$flag=0;
		my @aa=split />/,$line1;
		if ($aa[1] eq "$chr")
			{
				$flag=1;
			}
	}
	else
	{
	if ($flag==1)
		{
		$genome_len.=$line1;
		}
	}
	}
print "$genome_len\n";
close IN1;
#open OUT,">$Out_file" || die "cant open the file";
foreach my  $pos  (sort {$a<=>$b} keys %hashbase)
	{
		$homo=substr($genome_len,$pos,3);
		$HOMO=uc($homo);
		$vcfbase="$hashbase{$pos}$hashbase{$pos}$hashbase{$pos}";
		unless ($vcfbase eq $HOMO)
			{
			print  OUT "$hashvcf{$pos}\n" ;
			}
	}

##============================================================================#
#                               Subroutines                                  #
#============================================================================#
