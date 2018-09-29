# PGM-WES-Pipeline
Pipeline used to analyze data from the Ion Torrent Personal Genome Machine

This pipeline was used and thoroughly described in:

Kleyner R, Malcolmson J, Tegay D, Ward K, Coppinger J, Maughan G, Nelson L, Wang K, Robison R, Lyon GJ. KBG syndrome involving a single base insertion in ANKRD11.

and

Malcolmson J, Kleyner R, Tegay D, Adams W, Ward K, Coppinger J, Nelson L, Meisler MH, Wang K, Robison R, Lyon GJ. SCN8A Mutation in Child Presenting with Seizures and Developmental Delays.

Preprints can be viewed at http://lyonlab.labsites.cshl.edu/publications/

## Variant Calling Pipeline

The OTG-snpcaller pipeline, developed by Zhu et al. was rewritten to be optimized for use. The original program as recieived from the authors, as well as only the scripts used in analysis, can be found in the main and Variant_Calling directories respectively.

Citation: Zhu P, He L, Li Y, Huang W, Xi F, et al. (2015) Correction: OTG-snpcaller: An Optimized Pipeline Based on TMAP and GATK for SNP Calling from Ion Torrent Data. PLoS ONE 10(9): e0138824. doi: 10.1371/journal.pone.0138824

## Python Program

The Python program is used to determine if variants have an autosomal recessive inheritance pattern or are de novo. The program takes ANNOVAR formatted (avinput) files, and outputs avinput and BED files. Sibblings can be added or removed in order to make the program appropriate to use with various pedigrees. 

Information about ANNOVAR can be found here: http://annovar.openbioinformatics.org/en/latest/

## GEMINI Upload Script

A script to create two queryable GEMINI databases for de novo and autosomal recessive variants. These databases are separate.

Information about GEMINI can be found here: http://gemini.readthedocs.io/en/latest/
