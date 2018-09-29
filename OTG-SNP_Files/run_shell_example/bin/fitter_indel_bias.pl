#!/usr/bin/perl 
#===============================================================================
#-------------------------------help-info-start--------------------------------#
=head1 Name and Contact 

		FILE: filter_indel.pl

        USAGE: ./filter_indel.pl  

        DESCRIPTION: this project is used to filter the indel result

       AUTHOR: zhupenyuan (NGS), zhupenyuan@genomics.cn
       COMPANY: BGI
       VERSION: 1.0
       CREATED: 06/19/2013 12:00:42 AM

=head1 Usage

    perl  filter_indel.pl [options] [input file]

    -help       print this help to screen
    -o          write result to a file, default print to STDOUT .
    -i 		input file

=head1 Example

    perl  filter_indel.pl -h
    perl  filter_indel.pl

=cut
#-------------------------------help-info-end--------------------------------#
#============================================================================#

use strict;
use warnings;
use Getopt::Long;

my ($Need_help, $Out_file,$Input_file, $pileup );
GetOptions(
    "help"      => \$Need_help,
    "o=s"       => \$Out_file,
    "vcf=s"	=> \$Input_file,
    "pileup=s"  => \$pileup,
);

die `pod2text $0` if ($Need_help);

#============================================================================#
#                              Global Variable                               #
#============================================================================#
my %hash;
my @strand;
my $rate;
my $num=0;
					
#============================================================================#
#                               Main process                                 #
#============================================================================#
open IN,"$Input_file" ||die "cant open the file";
while (my $line=<IN>)
{
        chomp $line;
        unless ($line=~/^#/)
                {
                        my @store=split /\s+/,$line;
			my @aa=split /,/,$store[4];
                        if(length($store[3])!=length($store[4]) && $store[6]=~/./ )
                                {
					if($store[4]=~/,/)
						{
						if(length($store[3])==1)
						{
							if  (length($aa[0])!=1 || length($aa[1])!=1)
								{
								$hash{$store[1]}=$line;
                                        			$num++;
								}
						#	else {
						#		$hash{$store[1]}=$line;
                                                 #      		 $num++;
						#	     }
						}
						}
					else
						{
						$hash{$store[1]}=$line;
						$num++;
						}
				}
		}
}
print "$num\n";
close IN;
open IN1,"$pileup"  || die "cant open the file";
open OUT,">$Out_file" || die "cant open the file";
while (my $line1=<IN1>)
{
	chomp $line1;
	my @store1=split /\s+/,$line1;
	if (exists $hash{$store1[1]}) 
		{
			 @strand=split /;/,$store1[8];
			if ($strand[0]!=0  && $strand[1]!=0)
				{
					$rate=$strand[0]/$strand[1];
					if ($rate>0.1 && $rate<10) 
						{
							print OUT "$hash{$store1[1]}\n";
						}
				}
		}                       
}


##============================================================================#
#                               Subroutines                                  #
#============================================================================#

