#!/usr/bin/perl 
#===============================================================================
#-------------------------------help-info-start--------------------------------#
=head1 Name and Contact 

		FILE: cut_file.pl

        USAGE: ./cut_file.pl  

        DESCRIPTION: cut file by basenum

       AUTHOR: zhupenyuan (NGS), zhupenyuan@genomics.cn
       COMPANY: BGI
       VERSION: 1.0
       CREATED: 04/01/2013 01:07:49 PM

=head1 Usage

    perl  cut_file.pl [options] [input file]

    -help       print this help to screen
    -o          cuted file bam fomat
    -i 		original file sam fomat
    -base	base_num (int)

=head1 Example

    perl  cut_file.pl -h
    perl  cut_file.pl

=cut
#-------------------------------help-info-end--------------------------------#
#============================================================================#

use strict;
use warnings;
use Getopt::Long;

my ($Need_help, $Out_file,$Input_file,$num );
GetOptions(
    "help"      => \$Need_help,
    "o=s"       => \$Out_file,
    "i=s"	=> \$Input_file,
    "base=n"    => \$num,
);

die `pod2text $0` if ($Need_help);

#============================================================================#
#                              Global Variable                               #
#============================================================================#
my $base_num=0;
#============================================================================#
#                               Main process                                 #
#============================================================================#
if ($Out_file && $Input_file && $num)
{
`/home/zhupengyuan/samtools view -H $Input_file > $Out_file`;
open IN,"/home/zhupengyuan/samtools view $Input_file|" ||die "cant open the file";
open OUT," >>$Out_file" ||die "cant open the file";
while (my $line=<IN>)
{
	chomp $line;
if($line=~/^@/)
	{
		print OUT "$line\n";
	}
else
	{
	my @store=split /\s+/,$line;
	$base_num+=length($store[9]);
	if($base_num >= $num)
		{
			next;
		}
	else
		{
		print OUT "$line\n";
		}
	}
}
}
else
{
die `pod2text $0`;
}
`/home/zhupengyuan/samtools view -bS $Out_file >$Out_file.bam`;
`rm $Out_file`;
##============================================================================#
#                               Subroutines                                  #
#============================================================================#

