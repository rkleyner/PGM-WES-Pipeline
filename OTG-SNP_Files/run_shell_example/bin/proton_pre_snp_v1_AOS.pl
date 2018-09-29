#!/usr/bin/perl 
#===============================================================================
#-------------------------------help-info-start--------------------------------#
=head1 Name and Contact 

		FILE: proton_pre_snp_v1.pl

        USAGE: ./proton_pre_snp_v1.pl  

        DESCRIPTION: 

       AUTHOR: Huangwenpan (RNA function), huangwenpan@genomics.cn
       COMPANY: BGI
       VERSION: 1.0
       CREATED: 05/14/2013 02:43:48 PM

=head1 Usage

    perl  proton_pre_snp_v1.pl [options] [input file]

    -help       print this help to screen
    -pre	the prefix of output file
    -b		bam file of input
    -r		rate of deletion
    -samdir	samtool directory
=head1 Example

    perl  proton_pre_snp_v1.pl -h
    perl  proton_pre_snp_v1.pl

=cut
#-------------------------------help-info-end--------------------------------#
#============================================================================#

use strict;
use warnings;
use Getopt::Long;
use File::Basename;
use File::Path;
use threads;

my ($Need_help, $outfile,$bamfile,$rate,$samtooldir );
GetOptions(
    "help"      => \$Need_help,
    "pre=s"     => \$outfile,
    "b=s"       => \$bamfile,
    "r=f"       => \$rate,
    "samdir=s"	=> \$samtooldir,
);

die `pod2text $0` if ($Need_help);
unless( $outfile && $bamfile ){die `pod2text $0`;}
#============================================================================#
#                              Global Variable                               #
#============================================================================#
my %hashmispos;
my %hashdelpos;
my $five;
$rate ||=0.1;
$samtooldir ||="/home/zhupengyuan/samtools";
#============================================================================#
#                               Main process                                 #
#============================================================================#
print STDERR "---Program\t$0\tstarts --> ".localtime()."\n";

my $dir=dirname($outfile);
unless(-e $dir){`mkdir $dir`;}

open OUTmis,"> $outfile.mis.txt"||die$!;
open OUTdel,"> $outfile.del.txt"||die$!;


open IN,"$samtooldir view $bamfile|"||die$!;
while(<IN>)
{
	my $line=$_;
        my @arr=split(/\s+/,$line);
        my $len=length($arr[9]);
        if($arr[5]=~/^(\d+)S/)
        {
                my $sclip=$1;
                $arr[9]=substr($arr[9],$sclip,$len-$sclip);

        }
        $len=length($arr[9]);
        if($arr[5]=~/(\d+)S$/)
        {
                my $sclip=$1;
                $arr[9]=substr($arr[9],0,$len-$sclip);
        }
        my $newread=$arr[9];
	$len=length($arr[9]);


	if($line=~/MD:Z:(.*?)(\s+)/)
	{
		my $mapinfo=$1;
		my @fiveseq;
		if($mapinfo=~/(\D)/)
		{

			#+++++++ record the deletion base ++++
			my $readpos=0;
			while($arr[5]=~/((\d+)M)|((\d+)I)|((\d+)D)/g)
			{
				if(defined $2)
				{
					$readpos+=$2;
				}
				if(defined $4)
				{
					$readpos+=$4;
				}
				if(defined $6)
				{
					my $temp=$6;
					#++++ call 10 base ++++
					if($readpos-5<0)
					{
						if($readpos+5>$len)
						{
							$five=$arr[9];
						}
						else
						{
							$five=substr($arr[9],0,$readpos+5);
						}
					}
					elsif($readpos+5>$len)
					{
						$five=substr($arr[9],$readpos-5,$len-$readpos+5);
					}
					else
					{
						$five=substr($arr[9],$readpos-5,10);
					}
					################
					#+++++++ defined homo +++++
					if($five=~/AAA|TTT|CCC|GGG/)
					{
						$five.="\tT";
					}
					else
					{
						my $fivelen=length($five);
						my $temp=$five;
						unless($fivelen<8)
						{
							$temp=substr($five,3,5);
						}
						if($temp=~/AA|TT|CC|GG/)
						{
							$five.="\tT";
						}
						else
						{
							$five.="\tN";
						}
						
					}
					###########################
					
					#++++ push them in array ++++

					my $i=0;
					for($i=0;$i<$temp;$i++)
					{
						push @fiveseq,$five;
					}
					############################
				}
			}


			######################################
			
			my $refpos=0;
			while($mapinfo=~/(\d+)(\D+)/g)
			{
				my $i=0;
				if(defined $1)
                                {
                                	my $fir=$1;
                                        my $sec=$2;
					my @a=split(//,$sec);
					$refpos+=$fir;
					if($sec=~/^\^/)
					{
						shift @a;
	                                        foreach my $ele(@a)
						{
							$refpos++;
                                                        print OUTdel "$arr[2]:".($arr[3]+$refpos-1)."\t$arr[0]\t$fiveseq[$i]\n";
							$i++;
							$hashdelpos{"$arr[2]:".($arr[3]+$refpos-1)}++;
						}
					}
					else
					{
                                        	foreach my $ele(@a)
                                        	{
							
							$refpos++;
							print OUTmis "$arr[2]:".($arr[3]+$refpos-1)."\t$arr[0]\n";
							$hashmispos{"$arr[2]:".($arr[3]+$refpos-1)}++;
						}
					}
				}
			}
		}
	}
}
close IN;
close OUTdel;
close OUTmis;


#+++++++++++++++ call match +++++++++++++++++++
my %hashmat;
open IN,"$samtooldir view $bamfile|"||die$!;
while(<IN>)
{
	my $line=$_;
	my @arr=split(/\s+/);
	if($line=~/MD:Z:(.*?)(\s+)/)
	{
		my $mapinfo=$1;
		$mapinfo.="\$";
		my $refpos=$arr[3]-1;
		while($mapinfo=~/(\d+)(\D+)/g)
		{
                	if(defined $1)
                        {
                        	my $fir=$1;
                                my $sec=$2;
				my $i=0;
				for($i=0;$i<$fir;$i++)
				{
					$refpos++;
					if(exists $hashdelpos{"$arr[2]:$refpos"})
					{
						$hashmat{"$arr[2]:$refpos"}++;
					}
				}
                                
                                if($sec=~/^\^/)
                                {
                                       	$refpos+=length($sec)-1;
                                }
				else
				{
					$refpos+=length($sec);
				}
			}
		}
		
	}
	
}
close IN;
###############################################
my %hashdeletion;
open OUT,"> $outfile.mat_mis_del.sta"||die$!;
print OUT "#position\tmatch\tmismatch\tdeltion\trate\n";
foreach my $key(sort {$hashdelpos{$b}<=>$hashdelpos{$a}} keys %hashdelpos)
{
	print OUT "$key\t";
	my $total=0;
	if(exists $hashmat{$key})
	{
		print OUT "$hashmat{$key}\t";
		$total+=$hashmat{$key};
	}
	else
	{
		print OUT "0\t";
	}
	if(exists $hashmispos{$key})
	{
		print OUT "$hashmispos{$key}\t";
		$total+=$hashmispos{$key};
	}
	else
	{
		print OUT "0\t";
	}
	print OUT "$hashdelpos{$key}\t";
	$total+=$hashdelpos{$key};
	printf OUT "%.4f\n",$hashdelpos{$key}/$total;
	
	if($hashdelpos{$key}/$total<$rate)
	{
		$hashdeletion{$key}++;
		#print "$key\n";
	}
}
close OUT;

my $shit=keys %hashdeletion;
print "deletio_nnumber$shit\n";
#%hashdelpos=();
#%hashmispos=();
#%hashmat=();

my %hashreadid;
open OUT,"> $outfile.deletionread.txt"||die$!;
open IN,"< $outfile.del.txt"||die$!;
while(<IN>)
{
	my $line=$_;
	my @arr=split(/\s+/,$line);
	
	if(exists $hashdeletion{$arr[0]})
	{
		if($arr[3] eq "T")
		{
			print OUT "$line";
			$hashreadid{$arr[1]}=1;
		}
	}
}
close OUT;

`$samtooldir view -H $bamfile >$outfile.sam`;
open OUT,">> $outfile.sam"||die$!;

open IN,"$samtooldir view $bamfile|"||die$!;
while(<IN>)
{
        my $line=$_;
        my @a=split(/\s+/,$line);
        unless(exists $hashreadid{$a[0]})
        {
                print OUT $line;
        }
}
close IN;

`$samtooldir view -b -S $outfile.sam >$outfile.bam`;

`$samtooldir index $outfile.bam`;
close OUT;

`rm $outfile.sam`;
print STDERR "---Program\t$0\tends  --> ".localtime()."\n";
##============================================================================#
#                               Subroutines                                  #
#============================================================================#

