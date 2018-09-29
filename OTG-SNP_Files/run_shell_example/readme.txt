Proton exome analysis of OTG-snpcaller

Notice:
1. The following softwares are needed for analysis: tmap, samtools, MarkDuplicates(picard) and gatk.
2. In 'run.sh' is the example of how to do the analysis. Perl scripts are in the directory 'bin'. Replace the paths and filenames in 'run.sh' and other '*/*sh' into your own filenames, then run the commands in 'run.sh' line by line.

Steps:
#	Data downsampling
sh ./raw_lib/cut_rawdata.sh
#	Alignment
sh ./tmap/tmap.sh
sh ./alignment_sorted/sort_index.sh
sh ./alignment_sorted/split_by_chr.sh
#	Remove duplicates
sh ./rmdup/rm_dup.sh
cd rmdup && sh merge.TP00005.QC2.sh && cd ..
#	Call variants
sh ./pre_variant/pre_gatk.sh
sh ./variant/total_gatk.sh
sh ./variant/all.vqsr.sh
sh ./variant/all.indel_filter.sh
cat ./variant/TP00005/chr*/chr*.final.indel > ./variant/TP00005/TP00005.indel  && cat ./variant/TP00005/TP00005.head ./variant/TP00005/TP00005.indel > ./result/TP00005/result_variation/indel/TP00005.indel.vcf
perl ./pipeline/bin/seprate_snp.pl ./variant/TP00005/TP00005.vqsr.vcf ./result/TP00005/result_variation/snp/TP00005.snp.vcf
