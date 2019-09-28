VEPextended
===
'VEPextended' is a tool, implemented in Nextflow, that annotates called variants using Variant Effect Predictor (VEP) and additional plugins that implement functionalities, that are not include in variation API. 

---

### Features
  **-v 0.0.1**

* VEPextended supports vcf compressed files as input.
* Results include annotated compressed and indexed vcf files.
* Scalability and reproducibility via a Nextflow-based framework.
* VEPextended incorporates GeneHancer database to extend annotation.
* VEPextended incorporates gnomAD database to extend annotation.
* VEPextended incorporates GWAS Catalog database to extend annotation.
* VEPextended incorporates ClinVar database to extend annotation.
* VEPextended incorporates miRBase database to extend annotation.
* VEPextended incorporates PGKB Drug database to extend annotation.
* VEPextended uses a recent dbsnp file to annotate rsIDs to variants.
* Chromosome level paralelization. 
* Variants that are not detected in any sample are filtered (min_ac<0)

---

## Requirements
#### Compatible OS*:
* [Ubuntu 18.04.03 LTS](http://releases.ubuntu.com/18.04/)

\* VEPextended may run in other UNIX based OS and versions, but testing is required.

#### Software:
| Requirement | Version  | Required Commands * |
|:---------:|:--------:|:-------------------:|
| [bcftools](https://samtools.github.io/bcftools/) | 1.9-220-gc65ba41 | bcftools |
| [htslib](http://www.htslib.org/download/) | 1.9 | tabix, bgzip |
| [ensembl-vep](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html) | 96 | vep |
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 19.04.1.5072 | nextflow |
| [Plan9 port](https://github.com/9fans/plan9port) | Latest (as of 10/01/2019 ) | mk \** |

\* These commands must be accessible from your `$PATH` (*i.e.* you should be able to invoke them from your command line).  

\** Plan9 port builds many binaries, but you ONLY need the `mk` utility to be accessible from your command line.

---

### Installation
Download VEPextended from Github repository:  
```
git clone https://jballesterosv@bitbucket.org/iaguilaror/vepextended.git ???
```

---

#### Test
To test VEPextended's execution using test data, run:
```
./runtest.sh
```

Your console should print the Nextflow log for the run, once every process has been submitted, the following message will appear:
```
======
VEP annotator: Basic pipeline TEST SUCCESSFUL
======
```

VEPextended results for test data should be in the following file:
```
test/results/_pos1_rejoin_chromosomes/sample.filtered.untangled_multiallelics.anno_dbSNP_vep.vcf.gz
```

---

### Usage
To run VEPextended go to the pipeline directory and execute:
```
nextflow run vep-annotator.nf --vcffile <path to input 1> [--output_dir path to results ] [-resume]
```

For information about options and parameters, run:
```
nextflow run vep-annotator --help
```

---

### Pipeline Inputs
* A compressed vcf file with extension '.vcf.gz', which must have a TABIX index with .tbi extension, located in the same directory as the vcf file.

**Note(s)**: INFO must cointain AC

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
```
* `*_dbSNP.vcf.gz` : A reference dbSNP b152 file (dbSNPb152_GRCH38_for_GATK.vcf.gz), that contains rsID of variants. Available in: https://ftp.ncbi.nlm.nih.gov/snp/ 
* `*_InDels.tsv.gz`, `*_InDels.tsv.gz.tbi`, `*_SNVs.tsv.gz` and `*_SNVs.tsv.gz.tbi` : Pre-scored files for SNVs and InDels compressed and indexed provided from CADD. Availables in: https://cadd.gs.washington.edu/download
* `Clinvar.vcf.gz` and `Clinvar.vcf.gz.tbi`: Clinvar compressed and index files. Downloaded from ClinVar ftp, and slightly edited for compatiblity with VEP, which contain clinic associations. Availables in: https://www.ncbi.nlm.nih.gov/clinvar/docs/ftp_primer/ 
* `GeneHancers_with_genes.ved.gz` and `GeneHancers_with_genes.ved.gz.tbi` : contains every double elite relationship as regulator element - gene, integrated by iaguilar from UCSC data at Spring 2019. 
* `*_gnomAD.vcf.bgz` contains variants from gnomAD/v2.1.1/liftover-GRCh38/genomes/variants/all-in-one-vcf/completegenome_gnomAD.vcf.bgz (this file is a liftedover version of gnomAD release for 2.1.1).
* `*_gnomAD.coverage.summary.bed.gz` contains coverages from gnomAD/v2.1.1/liftover-GRCh38/genomes/coverage/gnomad.genomes.coverage.summary.bed.gz (this file is a liftedover version of gnomAD release for 2.1 -note: for coverages there was no changes in update to 2.1.1).
* `All_20180418_noINFO.GWAScatalog.vcf.gz` : contains every GWAS association for SNVs (no haplotypes) compiled by iaguilar from GWAScat database at Spring 2019. Available in: https://www.ebi.ac.uk/gwas/docs/file-downloads 
* `miRBase.bed.gz` : contains coordinates for every pre-miRNA, mature miRNA and seed region from miRBase v22 integrated by iaguilar at Spring 2019. Available in: ftp://mirbase.org/pub/mirbase/CURRENT/
* `_coverages.bed.gz` : contains covergage of your sample.
* `All_20180418_noINFO.PGKB.vcf.gz` contains genotype - drug associations from PGKB var_drug_ann.tsv file integrated by iaguilar at Spring 2019 (CREATED_2019-06-14). Available in: https://www.pharmgkb.org/downloads 

---

### Pipeline Results
* A compressed vcf file with `untangled_multiallelics.anno_dbSNP_vep.vcf.gz` extension.  

Example line(s):
```
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22	30000353	rs1241919392	G	T	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=1755;nhomalt_mx=0;ANN=-|non_coding_transcript_exon_variant|MODIFIER|DDX11L1|ENSG00000223972|Transcript|ENST00000456328.2|processed_transcript|3/3||ENST00000456328.2:n.938_941del||936-939/1657|||||rs1241919392||1||deletion|HGNC|HGNC:37102|YES|1||||||||||||2|chr1:g.13690_13693del|||||||||6.645e-05|0.0006155|0|0|0|0|0|0|0|0.0006155|gnomAD_AFR|||||||||2.748|0.115295||rs1232866893|15|29040|0.000516529|1034884|0|0||0|417|30256|0.0137824|0|15|7794|0.00192456|0|0|1696|0|0|0|796|0|0|0|1552|0|0|0|0|7984|0|0|0|4572|0|0|0|14252|0|0|0|3472|0|0|0|214|0|0|0|960|0|0|afr|15|7794|0.00192456|0|53.1&53.23&53.99&53.9|||||||||||||||||||
chr22	20485	rs1382673735	CA	C	.	PASS	AC=1;AF_mx=0.00641;AN=152;DP=827;nhomalt_mx=0;ANN=-|intron_variant&non_coding_transcript_variant|MODIFIER|WASH7P|ENSG00000227232|Transcript|ENST00000488147.1|unprocessed_pseudogene||2/10|ENST00000488147.1:n.192-2120del|||||||rs1382673735||-1||deletion|HGNC|HGNC:38034|YES||||||||||||||chr1:g.20487del||||||||||||||||||||||||||||0.664|-0.113030||rs1382673735|58|29098|0.00199326|837075|0|0||0|409|30720|0.0133138|0|58|7860|0.00737913|0|0|1692|0|0|0|794|0|0|0|1558|0|0|0|0|7980|0|0|0|4568|0|0|0|14240|0|0|0|3476|0|0|0|214|0|0|0|956|0|0|afr|58|7860|0.00737913|0|40.37|||||||||||||||||||

```

#### Output format Descriptions:
Output annotation fields will be added in INFO column. For mor info about fields description, see: https://www.ensembl.org/info/docs/tools/vep/vep_formats.html#other_fields 

Our extended pipeline additionaly include:
* CADD score: 
* ClinVar associations: 
* dbSNP rsID: 
* GeneHancer overlaps: 
* gnomAD data: 
* GWAS Catalog associations: 
* miRBase overlaps: 
* PharmGKB associations:

---

### VEPextended directory structure
````
VEPextended						## Pipeline main directory.
├── nextflow.config				## Configuration file for this pipeline.
├── README.md					## This document. General workflow description
├── runtest.sh					## Execution script for pipeline testing.
├── vep-annotator.nf				## Flow control script of this pipeline.
├── launchers						## Directory for different scripts to run vepextended
├── mkmodules					## Directory for submodule organization 
│   ├── mk-annotate-rsid			## Submodule to annotate rsID in ID column of a vcf to each variant of a vcf file.
│   ├── mk-extract-chromosomes			## Submodule to extract variants per chromosome from a single vcf.
│   ├── mk-filter-vcf			## Submodule to keep variants with at least one copy of an alternative allele.
│   ├── mk-rejoin-chromosomes			## Submodule to concatenate vcfs from different chromosomes.
│   ├── mk-split-chromosomes			## Submodule to make chunks of a chromosome vcf file.
│   ├── mk-untangle-multiallelic			## Submodule to split multiallelic variants.
│   └── mk-vep-extended			## Submodule to annotate variants with VEP.
└── test							## Test directory.
    ├── data						## Test data directory
    └──reference							## Test references directory.

````

#### References
Under the hood VEPextended implements some widely known tools. Please include the following ciations in your work:

* Fishilevich, S., Nudel, R., Rappaport, N., Hadar, R., Plaschkes, I., Iny Stein, T., ... & Lancet, D. (2017). GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database, 2017.
* Karczewski, K. J., Francioli, L. C., Tiao, G., Cummings, B. B., Alföldi, J., Wang, Q., ... & Gauthier, L. D. (2019). Variation across 141,456 human exomes and genomes reveals the spectrum of loss-of-function intolerance across human protein-coding genes. BioRxiv, 531210.
* Kitts, A., & Sherry, S. (2002). The single nucleotide polymorphism database (dbSNP) of nucleotide sequence variation. The NCBI Handbook. McEntyre J, Ostell J, eds. Bethesda, MD: US National Center for Biotechnology Information.
* Kozomara, A., & Griffiths-Jones, S. (2010). miRBase: integrating microRNA annotation and deep-sequencing data. Nucleic acids research, 39(suppl_1), D152-D157.
* Landrum, M. J., & Kattman, B. L. (2018). Clinvar at five years: delivering on the promise. Human mutation, 39(11), 1623-1630.
* Li, H. (2011). Tabix: fast retrieval of sequence features from generic TAB-delimited files. Bioinformatics, 27(5), 718-719.
* MacArthur, J., Bowler, E., Cerezo, M., Gil, L., Hall, P., Hastings, E., ... & Pendlington, Z. M. (2016). The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic acids research, 45(D1), D896-D901.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
* Rentzsch, P., Witten, D., Cooper, G. M., Shendure, J., & Kircher, M. (2018). CADD: predicting the deleteriousness of variants throughout the human genome. Nucleic acids research, 47(D1), D886-D894.
* Whirl‐Carrillo, M., McDonagh, E. M., Hebert, J. M., Gong, L., Sangkuhl, K., Thorn, C. F., ... & Klein, T. E. (2012). Pharmacogenomics knowledge for personalized medicine. Clinical Pharmacology & Therapeutics, 92(4), 414-417.


---

### Contact
If you have questions, requests, or bugs to report, please email
<iaguilaror@gmail.com>

#### Dev Team
Israel Aguilar-Ordonez <iaguilaror@gmail.com>   
