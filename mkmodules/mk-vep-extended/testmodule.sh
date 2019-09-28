#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
# VEP_GENOME_VERSION="GRCh38 or GRCh37, for human"
export VEP_GENOME_VERSION="GRCh38"
export CADD_SNV_REFERENCE="test/reference/CADD/sample_SNVs.tsv.gz"
export CADD_INDEL_REFERENCE="test/reference/CADD/sample_InDels.tsv.gz"
export GENOME_REFERENCE="test/reference/genome/chr22.fa.gz" # this should point to VEP toplevel fasta
export GNOMAD_REFERENCE="test/reference/gnomAD/sample_gnomAD.vcf.bgz"
export GNOMAD_COVERAGE_REFERENCE="test/reference/gnomAD/sample_gnomAD.coverage.summary.bed.gz"
export GENEHANCER_REFERENCE="test/reference/GeneHancer/GeneHancers_with_genes.bed.gz"
export GWASCATALOG_REFERENCE="test/reference/GWAS_catalog/All_20180418_noINFO.GWAScatalog.vcf.gz"
export CLINVAR_REFERENCE="test/reference/ClinVar/Clinvar.vcf.gz"
export MIRBASE_REFERENCE="test/reference/miRBase/miRBase.bed.gz"
export PGKB_DRUG_REFERENCE="test/reference/PharmGKB/All_20180418_noINFO.PGKB.vcf.gz"
export PROJECT_COVERAGE="test/reference/100GMX/sample_coverages.bed.gz"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are *.anno_dbSNP_vep.vcf
./runmk.sh \
&& mv test/data/*.anno_dbSNP_vep.vcf test/results \
&& echo "[>>>] Module Test Successful"
