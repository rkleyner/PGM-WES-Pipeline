#!/bin/bash

ref=$PATH/reference_file.fasta
denovo=$PATH/denovo.vcf
autrec=$PATH/autrec.vcf

#De Novo Dataset

vt decompose -s $denovo | vt normalize -r $ref - > de_novo_normalized.vcf

perl $HOME/downloads/ensembl-tools-release-74/scripts/variant_effect_predictor/variant_effect_predictor.pl \
-i de_novo_normalized.vcf \
--cache \
--sift b \
--polyphen b \
--symbol \
--numbers \
--biotype \
--total_length \
-o de_novo_annotated.vcf \
--vcf \
--fields Consequence,Codons,Amino_acids,Gene,SYMBOL,Feature,EXON,PolyPhen,SIFT,Protein_position,BIOTYPE

gemini load -v de_novo_annotated.vcf -t VEP denovo.db

#AUTREC DataSet

vt decompose -s $autrec | vt normalize -r $ref - > autrec_normalized.vcf

perl $HOME/downloads/ensembl-tools-release-74/scripts/variant_effect_predictor/variant_effect_predictor.pl \
-i autrec_normalized.vcf \
--cache \
--sift b \
--polyphen b \
--symbol \
--numbers \
--biotype \
--total_length \
-o autrec_annotated.vcf \
--vcf \
--fields Consequence,Codons,Amino_acids,Gene,SYMBOL,Feature,EXON,PolyPhen,SIFT,Protein_position,BIOTYPE

gemini load -v autrec_annotated.vcf -t VEP autrec.db