sh ./raw_lib/cut_rawdata.sh 
sh ./tmap/tmap.sh 
sh ./alignment_sorted/sort_index.sh
sh ./alignment_sorted/split_by_chr.sh
sh ./rmdup/rm_dup.sh
cd rmdup && sh merge.TP00005.QC2.sh && cd ..
sh ./pre_variant/pre_gatk.sh
sh ./variant/total_gatk.sh
sh ./variant/all.vqsr.sh
sh ./variant/all.indel_filter.sh
cat ./variant/TP00005/chr1/chr1.final.indel ./variant/TP00005/chr2/chr2.final.indel ./variant/TP00005/chr3/chr3.final.indel ./variant/TP00005/chr4/chr4.final.indel ./variant/TP00005/chr5/chr5.final.indel ./variant/TP00005/chr6/chr6.final.indel ./variant/TP00005/chr7/chr7.final.indel ./variant/TP00005/chr8/chr8.final.indel ./variant/TP00005/chr9/chr9.final.indel ./variant/TP00005/chr10/chr10.final.indel ./variant/TP00005/chr11/chr11.final.indel ./variant/TP00005/chr12/chr12.final.indel ./variant/TP00005/chr13/chr13.final.indel ./variant/TP00005/chr14/chr14.final.indel ./variant/TP00005/chr15/chr15.final.indel ./variant/TP00005/chr16/chr16.final.indel ./variant/TP00005/chr17/chr17.final.indel ./variant/TP00005/chr18/chr18.final.indel ./variant/TP00005/chr19/chr19.final.indel ./variant/TP00005/chr20/chr20.final.indel ./variant/TP00005/chr21/chr21.final.indel ./variant/TP00005/chr22/chr22.final.indel ./variant/TP00005/chrX/chrX.final.indel ./variant/TP00005/chrY/chrY.final.indel ./variant/TP00005/chrM/chrM.final.indel > ./variant/TP00005/TP00005.indel  && cat ./variant/TP00005/TP00005.head ./variant/TP00005/TP00005.indel > ./result/TP00005/result_variation/indel/TP00005.indel.vcf 
perl ./pipeline/bin/seprate_snp.pl ./variant/TP00005/TP00005.vqsr.vcf ./result/TP00005/result_variation/snp/TP00005.snp.vcf
