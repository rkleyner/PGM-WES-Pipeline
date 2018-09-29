#!/usr/bin/perl
#2012.12.20 created by luzhiyuan
#lastupdate at 2012.12.27 by luzhiyuan
#This program draws 3 figures(insertion,deletion,accuracy)
my $dir=shift;
my $outdir=shift;

my $usage=<<USAGE;
Description:
	This script draw three figures :insertion size distribution,deletion size distribution,accuracy distribution.
Author:
	Jerry Lu
Usage:
	perl $0 <input dir><output dir>
USAGE
die "$usage" if (!defined $dir || !defined $outdir);

if($dir ne $outdir){
	system "mkdir -p $outdir";
	system "cp $dir/*.map.* $outdir";
}#changed by luzhiyuan ,20130106
my @col=qw{red blue yellow purple green black grey};
my $y_lim=0;
my @gc= glob "$outdir/*.GC";
foreach (@gc){
	open IN,"$_" or die "$!\n";
	my $header=<IN>;
	while (<IN>){
		chomp;
		my ($base,$value)=split /\t/;
		if($y_lim < $value){
			$y_lim=$value;
		}
	}
	close IN;
}
$y_lim += $y_lim/10;
@gc= glob "$outdir/*.GC";
&draw(@gc);

$y_lim=0;
my @len= glob "$outdir/*.len";
foreach (@len){
	open IN,"$_" or die "$!\n";
	my $header=<IN>;
	while (<IN>){
		chomp;
		my ($base,$value)=split /\t/;
		if($y_lim < $value){
			$y_lim=$value;
		}
	}
	close IN;
}
$y_lim += $y_lim/10;
@len= glob "$outdir/*.len";
&draw(@len);

$y_lim=0;
my @insert= glob "$outdir/*.insert";
foreach (@insert){
	open IN,"$_" or die "$!\n";
	my $header=<IN>;
	while (<IN>){
		chomp;
		my ($base,$value)=split /\t/;
		if($y_lim < $value){
			$y_lim=$value;
		}
	}
	close IN;
}
$y_lim += $y_lim/10;
#@len= glob "$outdir/*.insert";
&draw(@insert);

$y_lim=0;
my @del= glob "$outdir/*.del";
foreach (@del){
	open IN,"$_" or die "$!\n";
	my $header=<IN>;
	while (<IN>){
		chomp;
		my ($base,$value)=split /\t/;
		if($y_lim < $value){
			$y_lim=$value;
		}
	}
	close IN;
}
$y_lim += $y_lim/10;
#@len= glob "$outdir/*.insert";
&draw(@del);

$y_lim=0;
my @qual= glob "$outdir/*.qual";
$y_lim=60;
&draw(@qual);

$y_lim=100;
my @base= glob "$outdir/*.base";
my $flag="base";
&draw(@base);

$y_lim=0;
my @indel= glob "$outdir/*.indel";
$y_lim=10;
&draw_accuracy(@indel);

sub draw_accuracy {
	my $legend;
	my $file_name=(split /\//,$_[0])[-1];
	my $first_word=(split /\./,$file_name)[0];
	my $last_word=(split /\./,$file_name)[-1];
	my $pdf_out="$file_name.error.pdf";
	my ($x_label,$y_label_1,$y_label_2)=("base_pos","error_rate","accuracy");
	my $new="erracc";
	system "mkdir -p $outdir";
	open R,">>$outdir/$last_word.error.R";
	###############################need rewrite#
	print R <<"R";
	$new <- read.table("$outdir/$file_name",header=TRUE,sep="\\t",skip=0)
	pdf("$outdir/$pdf_out")
plot($new\[,1],$new\[,3],ylim=c(0,$y_lim),xlab="$x_label",ylab="$y_label_1",type="l",col="$col[0]",lwd=2)
lines($new\[,1],$new\[,4],col="$col[1]",lwd=2)
lines($new\[,1],$new\[,5],col="$col[2]",lwd=2)
grid(nx=NA,ny=NULL)
legend("topright",legend=c("mismatch","insertion","deletion"),lty=1,cex=0.8,col=c("red","blue","yellow"))
R
	close R;
	system "/ifs2/DGE_SR/wangxy/bin/R/R-2.12.2/bin/Rscript $outdir/$last_word.error.R";
	$pdf_out="$file_name.accuracy.pdf";
	open R,">>$outdir/$last_word.accuracy.R";
	print R <<"R";
	$new <- read.table("$outdir/$file_name",header=TRUE,sep="\\t",skip=0)
	pdf("$outdir/$pdf_out")
plot($new\[,1],$new\[,6],ylim=c(90,110),xlab="$x_label",ylab="$y_label_2",type="l",col="$col[0]",lwd=2)
grid(nx=NA,ny=NULL)
legend("topright",legend=c("match"),lty=1,cex=0.8,col="red")
R
	system "/ifs2/DGE_SR/wangxy/bin/R/R-2.12.2/bin/Rscript $outdir/$last_word.accuracy.R";
	close R;
#######################################
}


sub draw {
	my $i=0;
	my $legend;
	my $last_word;
	foreach $a (@_){
		#取得文件全名。
		my $file_name=(split /\//,$a)[-1];
		my $first_word=(split /\./,$file_name)[0];
		print "first_word=$first_word\n";
		$last_word=(split /\./,$file_name)[-1];
		print "last_word=$last_word\n";
		my $pdf_out="$file_name.pdf";
		my ($x_label,$y_label);
		if($last_word eq "len"){
			$x_label="base_pos";
			$y_label="read_count";
		}
		if($last_word eq "qual"){
			$x_label="base_pos";
			$y_label="mean_quanlity";
		}
		if($last_word eq "GC"){
			$x_label="GC_content";
			$y_label="read_count";
		}
		if($last_word eq "base"){
			$x_label="base_pos";	
			$y_label="base_rate";	
		}
		print "File:$file_name\n";
		#system "mkdir -p $outdir";
		open R,">>$outdir/$last_word.R";
		#my $legend;
		my $new="len$i";
		if($i==0){
			if($flag eq "base"){
				print R <<"R";
				$new <- read.table("$outdir/$file_name",header=TRUE,sep="\\t",skip=0)
				pdf("$outdir/$pdf_out")
				plot($new\[,1],$new\[,2],ylim=c(1,$y_lim),xlab="$x_label",ylab="$y_label",type="l",col="$col[0]",lwd=2)
lines($new\[,1],$new\[,3],col="$col[1]",lwd=2)
lines($new\[,1],$new\[,4],col="$col[2]",lwd=2)
lines($new\[,1],$new\[,5],col="$col[3]",lwd=2)
grid(nx=NA,ny=NULL)
R
				$legend="\"A\",\"T\",\"C\",\"G\"";
				print "legend=$legend\n";
				last;
			}

print R <<"R";
$new <- read.table("$outdir/$file_name",header=TRUE,sep="\\t",skip=0)
pdf("$outdir/$pdf_out")
plot($new\[,1],$new\[,2],ylim=c(1,$y_lim),xlab="$x_label",ylab="$y_label",type="l",col="$col[$i]",lwd=2)
grid(nx=NA,ny=NULL)
R
			$legend.="\"$first_word\"";
			print "legend=$legend\n";
		}else{
			print R <<"R";
$new <- read.table("$outdir/$file_name",header=TRUE,sep="\\t",skip=0)
lines($new\[,1],$new\[,2],col="$col[$i]",lwd=2)
R
			$legend.=",\"$first_word\"";
			print "legend=$legend\n";
		}
			$i++;
	}
		print R <<"R";
legend("topright",legend=c($legend),lty=1,cex=0.8,col=c("red","blue","yellow","purple","green","black","grey"))
R
		print "last_word=$last_word\n";
		system "/ifs2/DGE_SR/wangxy/bin/R/R-2.12.2/bin/Rscript $outdir/$last_word.R";
		close R;
}
