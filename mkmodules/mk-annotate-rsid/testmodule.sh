#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
# REFERENCE_DBSNP="path to a recent dbSNP vcf; chr nomenclature must math wiht the one used on your sample VCF"
export REFERENCE_DBSNP="test/reference/sample_dbSNP.vcf.gz"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are *.anno_rsid.vcf
./runmk.sh \
&& mv test/data/*.anno_dbSNP.vcf test/results \
&& echo "[>>>] Module Test Successful"
