# mk-split-chromosomes  
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** August-2019  

---

## Module description:
Split in chunks a vcf file, keeping its format.
1. Save the header of a vcf in a temporary file.
2. Save the body of a vcf in a temporary file.
3. Make chunks of the body of the vcf file.
4. Add the header to each body chunk.

---

## Module Dependencies:
bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)

---

### Input:

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


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
chr22   30000353        .       G       T       .       PASS    AC=107;AF_mx=0.708;AN=150;DP=883;nhomalt_mx=39
chr22   30000507        .       A       G       .       PASS    AC=0;AF_mx=;AN=150;DP=572;nhomalt_mx=0
```

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
##bcftools_viewCommand=view --compression-level 0 --output-type z --min-ac 1 --threads 1 ./test/data/sample.vcf.gz;
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22   30000353        .       G       T       .       PASS    AC=107;AF_mx=0.708;AN=150;DP=883;nhomalt_mx=39
chr22   30000507        .       A       G       .       PASS    AC=0;AF_mx=;AN=150;DP=572;nhomalt_mx=0
```

Each chunk will contain different parts of the original body plus the header.

---

## Temporary files:
`*.chunk*.tmp`: Split body of the original vcf in 10 chunk files.

`*.header.vcf.tmp`: Header of the original vcf. It does not contain the body.

`*body.vcf.tmp`*: Body of original vcf. It does not contain the header.

---


## Module parameters:
NONE

---

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-split-chromosomes directory structure

````
mk-split-chromosomes/					      ## Module main directory
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
. Bioinformatics (Oxford, England) 2016;32;11;1749-51. PUBMED: 26826718; PMC: 4892413; DOI: 10.1093/bioinformatics/btw044
