# mk-annotate-rsid
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** August-2019  

---

## Module description:
Annotate rsID to each variant in ID column of a VCF.
1. Make a Reference file with a define range.
2. Compress input file.
3. Annotate rsID in the compressed input file using a Reference.

---

## Module Dependencies:
* bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)
* tabix 1.9 >
[Download and compile tabix](http://www.htslib.org/download/)
* bgzip 1.9 > [Download and compile bgzip](http://www.htslib.org/download/)

---

### Input:

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. Changes will be done in ID column.

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
##FILTER=<ID=PASS,Description="All filters passed">
##GATKCommandLine.ApplyRecalibration.2=<ID=ApplyRecalibration,Version=3.8-0-ge9d806836,Date="Sun Sep 16 01:11:33 UTC 2018",Epoch=1537060293182,CommandLineOptions="analysis_type=ApplyRecalibration input_fi
##INFO=<ID=AF_mx,Number=A,Type=Float,Description="Allele Frequency, for each ALT allele, in the same order as listed">
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22   30000353        .       G       T       .       PASS    AC=107;AF_mx=0.708;AN=150;DP=883;nhomalt_mx=39
chr22   30000507        .       A       G       .       PASS    AC=1;AF_mx=0.006494;AN=150;DP=572;nhomalt_mx=0
```
**Note(s):**

Please observe that ID column is empty.

---

### Output:

`VCF` files with only variants of each chromosome of the input.

Example line(s):  
```
##fileformat=VCFv4.2
##FILTER=<ID=PASS,Description="All filters passed">
##GATKCommandLine.ApplyRecalibration.2=<ID=ApplyRecalibration,Version=3.8-0-ge9d806836,Date="Sun Sep 16 01:11:33 UTC 2018",Epoch=1537060293182,CommandLineOptions="analysis_type=ApplyRecalibration input_fi
##INFO=<ID=AC,Number=A,Type=Integer,Description="Allele count in genotypes, for each ALT allele, in the same order as listed">
##INFO=<ID=AF_mx,Number=A,Type=Float,Description="Allele Frequency, for each ALT allele, in the same order as listed">
##contig=<ID=chr1,length=248956422>
##contig=<ID=chr2,length=242193529>
##contig=<ID=chr3,length=198295559>
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22   30000353        rs5763691       G       T       .       PASS    AC=107;AF_mx=0.708;AN=150;DP=883;nhomalt_mx=39
chr22   30000507        rs117064489     A       G       .       PASS    AC=1;AF_mx=0.006494;AN=150;DP=572;nhomalt_mx=0
```

**Note(s):**
Please observe that the ID column already has the rsID for each variant.

---

## Temporary files:
`*.vcf.coordinate_columns.tmp` : Columns 1 and 2 (CHROM and POS) of a vcf sorted.

`*.anno_dbSNP.subsampled_reference.vcf.gz.tmp` : Reference vcf with IDs of limited range.

`*.vcf.gz.tmp` : Compressed original VCF file.

---


## Module parameters:
Path to a recent dbSNP vcf; chr nomenclature must math wiht the one used on your sample VCF.
```
REFERENCE_DBSNP="test/reference/sample_dbSNP.vcf.gz"`
```
---

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-annotate-rsid directory structure

````
mk-annotate-rsid/					      ## Module main directory
├── mkfile								## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````
---

## References
* BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data.
Narasimhan V, Danecek P, Scally A, Xue Y, Tyler-Smith C and Durbin R
. Bioinformatics (Oxford, England) 2016;32;11;1749-51. PUBMED: 26826718; PMC: 4892413; DOI: 10.1093/bioinformatics/btw044.
* Li, H. (2011). Tabix: fast retrieval of sequence features from generic TAB-delimited files. Bioinformatics, 27(5), 718-719.
