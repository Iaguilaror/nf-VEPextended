# mk-vep-extended
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** August-2019  

---

## Module description:
Annotate variants with Variant Effector Predictor tool (VEP).
For more information about, see [VEP](https://www.ensembl.org/info/docs/tools/vep/index.html)

---

## Module Dependencies:
* ensembl-vep 97.3 >
[Download and compile vep](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html)

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
chr22   30000353        rs5763691       G       T       .       PASS    AC=107;AF_mx=0.708;AN=150;DP=883;nhomalt_mx=39
chr22   30000507        rs117064489     A       G       .       PASS    AC=1;AF_mx=0.006494;AN=150;DP=572;nhomalt_mx=0
```

---

### Output:

`VCF` files with only variants of each chromosome of the input.

Example line(s):  

```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	AC	AN	DP	AF_mx	nhomalt_mx	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	TSL	APPRIS	CCDS	ENSP	SWISSPROT	TREMBL	UNIPARC	SOURCE	GENE_PHENO	SIFT	PolyPhen	DOMAINS	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	AA_AF	EA_AF	gnomAD_AF	gnomAD_AFR_AF	gnomAD_AMR_AF	gnomAD_ASJ_AF	gnomAD_EAS_AF	gnomAD_FIN_AF	gnomAD_NFE_AF	gnomAD_OTH_AF	gnomAD_SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	PUBMED	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	GeneHancer_type_and_Genes	gnomADg	gnomADg_AC	gnomADg_AN	gnomADg_AF	gnomADg_DP	gnomADg_AC_nfe_seu	gnomADg_AN_nfe_seu	gnomADg_AF_nfe_seu	gnomADg_nhomalt_nfe_seu	gnomADg_AC_raw	gnomADg_AN_raw	gnomADg_AF_raw	gnomADg_nhomalt_raw	gnomADg_AC_afr	gnomADg_AN_afr	gnomADg_AF_afr	gnomADg_nhomalt_afr	gnomADg_AC_nfe_onf	gnomADg_AN_nfe_onf	gnomADg_AF_nfe_onf	gnomADg_nhomalt_nfe_onf	gnomADg_AC_amr	gnomADg_AN_amr	gnomADg_AF_amr	gnomADg_nhomalt_amr	gnomADg_AC_eas	gnomADg_AN_eas	gnomADg_AF_eas	gnomADg_nhomalt_eas	gnomADg_nhomalt	gnomADg_AC_nfe_nwe	gnomADg_AN_nfe_nwe	gnomADg_AF_nfe_nwe	gnomADg_nhomalt_nfe_nwe	gnomADg_AC_nfe_est	gnomADg_AN_nfe_est	gnomADg_AF_nfe_est	gnomADg_nhomalt_nfe_est	gnomADg_AC_nfe	gnomADg_AN_nfe	gnomADg_AF_nfe	gnomADg_nhomalt_nfe	gnomADg_AC_fin	gnomADg_AN_fin	gnomADg_AF_fin	gnomADg_nhomalt_fin	gnomADg_AC_asj	gnomADg_AN_asj	gnomADg_AF_asj	gnomADg_nhomalt_asj	gnomADg_AC_oth	gnomADg_AN_oth	gnomADg_AF_oth	gnomADg_nhomalt_oth	gnomADg_popmax	gnomADg_AC_popmax	gnomADg_AN_popmax	gnomADg_AF_popmax	gnomADg_nhomalt_popmax	gnomADg_cov	gwascatalog	gwascatalog_GWASC_trait	gwascatalog_GWASC_pvalue	gwascatalog_GWASC_study	clinvar	clinvar_CLNDN	clinvar_CLNSIG	clinvar_GENEINFO	clinvar_CLNDISDB	miRBase	pharmgkb_drug	pharmgkb_drug_PGKB_annid	pharmgkb_drug_PGKB_gene	pharmgkb_drug_PGKB_chem	pharmgkb_drug_PGKB_phencat
chr22	16132524	.	G	C	27	156	1962	0.173	3	C	intergenic_variant	MODIFIER	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	SNV	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	chr22:g.16132524G>C	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.
chr22	27840687	.	G	T	69	156	2311	0.442	18	T	intergenic_variant	MODIFIER	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	SNV	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	chr22:g.27840687G>T	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	0	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.
```

**Note(s):**
Please observe that the flags were annotated in new columns.

---

## Temporary files:
NONE

---


## Module parameters:
Path to the directory where VEP cache resides. Adjustable to each home.
```
VEP_CACHE="/home/judith/.vep/cache"
```
Version of human genome.
```
VEP_GENOME_VERSION="GRCh38"
```
Path to file of CADD SNV reference.
```
CADD_SNV_REFERENCE="test/reference/CADD/sample_SNVs.tsv.gz"
```
Path ti file of CADD INDEL reference.
```
CADD_INDEL_REFERENCE="test/reference/CADD/sample_InDels.tsv.gz"
```
Path to Genome Reference. This should point to VEP toplevel fasta
```
GENOME_REFERENCE="test/reference/genome/homo_sapiens_vep_97_GRCh38.fa.gz"
```
Path to gnomAD reference file.
```
GNOMAD_REFERENCE="test/reference/gnomAD/sample_gnomAD.vcf.bgz"
```
Path to gnomAD coverage reference file.
```
GNOMAD_COVERAGE_REFERENCE="test/reference/gnomAD/sample_gnomAD.coverage.summary.bed.gz"
```
Path to GeneHancer reference file.
```
GENEHANCER_REFERENCE="test/reference/GeneHancer/GeneHancers_with_genes.bed.gz"
```
Path to GWAS Catalog reference file.
```
GWASCATALOG_REFERENCE="test/reference/GWAS_catalog/All_20180418_noINFO.GWAScatalog.vcf.gz"
```
Path to ClinVar reference  file.
```
CLINVAR_REFERENCE="test/reference/ClinVar/Clinvar.vcf.gz"
```
Path to miRBase reference file.
```
MIRBASE_REFERENCE="test/reference/miRBase/miRBase.bed.gz"
```
Path to PGKB drug reference file.
```
PGKB_DRUG_REFERENCE="test/reference/PharmGKB/All_20180418_noINFO.PGKB.vcf.gz"
```
Path to Project coverage file.
```
PROJECT_COVERAGE="test/reference/100GMX/sample_coverages.bed.gz"
```
---

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-vep-entended directory structure

````
mk-vep-extended/					      ## Module main directory
├── mkfile								## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
|   ├── reference							## Test reference directory.
└── testmodule.sh							## Script to test module functunality using test data
````
---

## References
* Fishilevich, S., Nudel, R., Rappaport, N., Hadar, R., Plaschkes, I., Iny Stein, T., ... & Lancet, D. (2017). GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database, 2017.
* Karczewski, K. J., Francioli, L. C., Tiao, G., Cummings, B. B., Alföldi, J., Wang, Q., ... & Gauthier, L. D. (2019). Variation across 141,456 human exomes and genomes reveals the spectrum of loss-of-function intolerance across human protein-coding genes. BioRxiv, 531210.
* Kitts, A., & Sherry, S. (2002). The single nucleotide polymorphism database (dbSNP) of nucleotide sequence variation. The NCBI Handbook. McEntyre J, Ostell J, eds. Bethesda, MD: US National Center for Biotechnology Information.
* Kozomara, A., & Griffiths-Jones, S. (2010). miRBase: integrating microRNA annotation and deep-sequencing data. Nucleic acids research, 39(suppl_1), D152-D157.
* Landrum, M. J., & Kattman, B. L. (2018). Clinvar at five years: delivering on the promise. Human mutation, 39(11), 1623-1630.
* MacArthur, J., Bowler, E., Cerezo, M., Gil, L., Hall, P., Hastings, E., ... & Pendlington, Z. M. (2016). The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic acids research, 45(D1), D896-D901.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Rentzsch, P., Witten, D., Cooper, G. M., Shendure, J., & Kircher, M. (2018). CADD: predicting the deleteriousness of variants throughout the human genome. Nucleic acids research, 47(D1), D886-D894.
* Whirl‐Carrillo, M., McDonagh, E. M., Hebert, J. M., Gong, L., Sangkuhl, K., Thorn, C. F., ... & Klein, T. E. (2012). Pharmacogenomics knowledge for personalized medicine. Clinical Pharmacology & Therapeutics, 92(4), 414-417.
