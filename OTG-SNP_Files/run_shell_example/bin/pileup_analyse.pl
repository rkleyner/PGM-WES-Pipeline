#!/usr/bin/perl -w
use strict;
unless(@ARGV)
{
	die "<input file> <output file>\n";
}
my %qua;
load_quality(\%qua);
open(IN,"<$ARGV[0]")or die;
open(OUT,">$ARGV[1]")or die;
print OUT "Chromosome\tLocation\tTotal_read\tReference\tRef_Read\tRef_Read_Rate\tRef_Base_Quality\tVariation\tVariation_Read\tVariation_Read_Rate\tVariation_Quality\t...\n";
while(<IN>)
{
	chomp;
	my @line=split(/\t/,$_);
	$line[2]=~tr/acgtn/ACGTN/;
	$line[4]=~s/\^\S|\$//g;
	if($line[4]=~/[\+-]/)
	{
		$line[4]=divided($line[4]);
	}
	my @arr=split(//,$line[5]);
	my %stat;
	my %quality;
	my $cnt=0;
	while($line[4]=~/(\*|[\.,ACGTacgtNn][\+-][\dACGTacgtNn]+|[\.,ACGTacgtNn])/g)
	{
		my $match=$1;
		if(length($match)>1){$match=~s/^[\.,ACGTacgtNn]//;}
		$stat{$match}++;
		if(!defined $quality{$match}){$quality{$match}=0;}
		if(!defined $qua{$arr[$cnt]}){print "$arr[$cnt]\n";}
		$quality{$match}+=$qua{$arr[$cnt]};
		$cnt++;
	}
	if($cnt!=$#arr+1){print "$line[0]\t$line[1]\t$cnt\t$#arr\n";}
	if(!defined $stat{"."}){$stat{"."}=0;$quality{"."}=0;}
	if(!defined $stat{","}){$stat{","}=0;$quality{","}=0;}
	my $ref_qua;
	if($stat{"."}+$stat{","} == 0){$ref_qua="-";}
	else{$ref_qua=($quality{"."}+$quality{","})/($stat{"."}+$stat{","});}
	my $ref_rate=($stat{"."}+$stat{","})/$line[3];
	print OUT "$line[0]\t$line[1]\t$line[3]\t$line[2]\t$stat{'.'};$stat{','}\t$ref_rate\t$ref_qua";
	delete $stat{"."};
	delete $stat{","};
	delete $stat{"*"};
	my %var;
	foreach my $i(keys %stat)
	{
		if(!defined $stat{lc $i}){$stat{lc $i}=0;$quality{lc $i}=0;}
		if(!defined $stat{uc $i}){$stat{uc $i}=0;$quality{uc $i}=0;}
		$var{uc $i}=1;
	}
	foreach my $i(reverse(sort{($stat{$a}+$stat{lc $a}) <=> ($stat{$b}+$stat{lc $b})}keys %var))
	{
		print OUT "\t$i\t$stat{$i};",$stat{lc $i},"\t",($stat{$i}+$stat{lc $i})/$line[3],"\t",($quality{$i}+$quality{lc $i})/($stat{$i}+$stat{lc $i});
	}
	print OUT "\n";
}

close IN;
close OUT;
sub load_quality
{
	my $hash=shift;
	foreach my $i(33..140)
	{
		$hash->{chr $i}=$i-33;
	}
}
sub divided
{
	my $seq=shift;
	if($seq=~/\+/)
	{
		my @s=split(/\+/,$seq);
		foreach my $i(1..$#s)
		{
			if($s[$i]=~/^(\d+)/){$s[$i]=substr($s[$i],0,length($1)+$1)." ".substr($s[$i],length($1)+$1);}
			else{print "error\n";}
		}
		$seq=join("+",@s);
	}
        if($seq=~/\-/)
        {
                my @s=split(/\-/,$seq);
                foreach my $i(1..$#s)
                {
                        if($s[$i]=~/^(\d+)/){$s[$i]=substr($s[$i],0,length($1)+$1)." ".substr($s[$i],length($1)+$1);}
                        else{print "error\n";}
                }
                $seq=join("-",@s);
        }
	return $seq;
}
