#!usr/bin/perl -w
use strict;
use Getopt::Long;
use File::Basename;

my ($bamfile,$outdir,$AS_limit,$bin,$help);

GetOptions
(
	"i:s"=>\$bamfile,
	"a:s"=>\$AS_limit,
	"o:s"=>\$outdir,
	"h"=>\$help,
);

my $usage=<<USAGE;
usage:perl $0 -i <bamfile> -a <AS_limit> -o <outdir> -h help
USAGE

die $usage if (!$bamfile || $help || !$outdir || !$AS_limit);

mkdir $outdir unless -d $outdir;
my %HASH;
my %AS;
my %LIM;
my $line = 0;
my $aligned = 0;

my $name = basename($bamfile);
$name =~ s/\.bam$//g;
my $outsam = $outdir."\/$name\_rmdup\.sam";
my $outbam = $outdir."\/$name\_rmdup\.bam";
my $outsorted = $outdir."\/$name\.rmDup_sorted";
my $outsorted_bam = $outdir."\/$name\.rmDup_sorted\.bam";
my $stat = $outdir."\/"."$name"."\_rmDup.stat";
open ST,">$stat" or die $!;

`/ifs4/BC_CANCER/01bin/samtools/samtools view $bamfile -H >$outsam`;
open SAM, ">>", "$outsam" || die "Can't open outsam\n$!";
open BAM, "/ifs4/BC_CANCER/01bin/samtools/samtools view $bamfile | " || die "Can't open bam file\n$!";
while (<BAM>)
{
	chomp;
	my @d = split (/\t/,$_);
	if ($d[1] == 4)
	{
		next;
	}
	$line++;

	my $asQ;
	if (/AS\:i\:(\d+)/)
	{
		$asQ = $1;
	}
	else
	{
		print "Unfind aliQ line $line\n";
		last;
	}
	
	my $readID = $d[0];
	my $strand = $d[1];
	my $flag   = $d[5];
	my $start  = $d[3];
	my $chr    = $d[2];

	if ($strand eq "16")
	{
		my @Ms = $flag =~ m/(\d+)M/g;
		my @Ds = $flag =~ m/(\d+)D/g;
		my $length = 0;
	    for(my $t=0; $t<=$#Ms; $t++)
		{
			$length += $Ms[$t];
		}
		for(my $s=0; $s<=$#Ds; $s++)
		{
			$length += $Ds[$s];
		}
		$start = $start+$length-1;
		
	}

	my $YY = $chr."SS".$strand."SS".$start;
	if (exists $HASH{$YY})
	{
		my $ID = $HASH{$YY};		
		if ($asQ >= $AS{$ID})		
		{
			if ($AS{$ID} >= $AS_limit)
			{
				my $tmp = $AS{$ID};
				$LIM{$ID} = $tmp;
				delete $AS{$ID};
				$AS{$readID} = $asQ;
				$HASH{$YY} = $readID;
			}
			else
			{
				delete $AS{$ID};
				$AS{$readID} = $asQ;
				$HASH{$YY} = $readID;
			}
		}
		else
		{
			if ($asQ >= $AS_limit)
			{
				$LIM{$readID} = $asQ;
			}
		}
	}
	else
	{
		$HASH{$YY} = $readID;
		$AS{$readID} = $asQ;
	}
}
close BAM;

open BAMS, "/ifs4/BC_CANCER/01bin/samtools/samtools view $bamfile | " || die "Can't open bam file\n$!";
while (<BAMS>)
{
	chomp;
	my @d = split (/\t/,$_);
	if ($d[1] == 4)
	{
		next;
	}
#	$line++;

	my $readID = $d[0];
	if (exists $AS{$readID})
	{
		print SAM "$_\n";
		$aligned++;
	}
	elsif (exists $LIM{$readID})
	{
		print SAM "$_\n";
		$aligned++;
	}
	else
	{
		next;
	}
}
close BAMS;
close SAM;
my $removed = $line-$aligned;
my $dup = $removed/$line;
print ST "total mapped reads:\t$line\nthe remained mapped reads:\t$aligned\n";
printf ST "the duplication rate:\t%.4f%%\n",100*$dup;
close ST;

`/ifs4/BC_CANCER/01bin/samtools/samtools view -S $outsam -b -o $outbam`;
`/ifs4/BC_CANCER/01bin/samtools/samtools sort $outbam $outsorted`;
`/ifs4/BC_CANCER/01bin/samtools/samtools index $outsorted_bam`;
`rm $outsam $outbam`;
