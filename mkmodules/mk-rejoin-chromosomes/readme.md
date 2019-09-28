# mk-rejoin-chromosomes  
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** August-2019  

---

## Module description:
Concatenate annotated chunks in a single vcf file.

---

## Module Dependencies:
* bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)
* tabix 1.9 >
[Download and compile tabix](http://www.htslib.org/download/)

---

### Input:

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	AC	AN	DP	AF_mx	nhomalt_mx	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	TSL	APPRIS	CCDS	ENSP	SWISSPROT	TREMBL	UNIPARC	SOURCE	GENE_PHENO	SIFT	PolyPhen	DOMAINS	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	AA_AF	EA_AF	gnomAD_AF	gnomAD_AFR_AF	gnomAD_AMR_AF	gnomAD_ASJ_AF	gnomAD_EAS_AF	gnomAD_FIN_AF	gnomAD_NFE_AF	gnomAD_OTH_AF	gnomAD_SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	PUBMED	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	GeneHancer_type_and_Genes	gnomADg	gnomADg_AC	gnomADg_AN	gnomADg_AF	gnomADg_DP	gnomADg_AC_nfe_seu	gnomADg_AN_nfe_seu	gnomADg_AF_nfe_seu	gnomADg_nhomalt_nfe_seu	gnomADg_AC_raw	gnomADg_AN_raw	gnomADg_AF_raw	gnomADg_nhomalt_raw	gnomADg_AC_afr	gnomADg_AN_afr	gnomADg_AF_afr	gnomADg_nhomalt_afr	gnomADg_AC_nfe_onf	gnomADg_AN_nfe_onf	gnomADg_AF_nfe_onf	gnomADg_nhomalt_nfe_onf	gnomADg_AC_amr	gnomADg_AN_amr	gnomADg_AF_amr	gnomADg_nhomalt_amr	gnomADg_AC_eas	gnomADg_AN_eas	gnomADg_AF_eas	gnomADg_nhomalt_eas	gnomADg_nhomalt	gnomADg_AC_nfe_nwe	gnomADg_AN_nfe_nwe	gnomADg_AF_nfe_nwe	gnomADg_nhomalt_nfe_nwe	gnomADg_AC_nfe_est	gnomADg_AN_nfe_est	gnomADg_AF_nfe_est	gnomADg_nhomalt_nfe_est	gnomADg_AC_nfe	gnomADg_AN_nfe	gnomADg_AF_nfe	gnomADg_nhomalt_nfe	gnomADg_AC_fin	gnomADg_AN_fin	gnomADg_AF_fin	gnomADg_nhomalt_fin	gnomADg_AC_asj	gnomADg_AN_asj	gnomADg_AF_asj	gnomADg_nhomalt_asj	gnomADg_AC_oth	gnomADg_AN_oth	gnomADg_AF_oth	gnomADg_nhomalt_oth	gnomADg_popmax	gnomADg_AC_popmax	gnomADg_AN_popmax	gnomADg_AF_popmax	gnomADg_nhomalt_popmax	gnomADg_cov	gwascatalog	gwascatalog_GWASC_trait	gwascatalog_GWASC_pvalue	gwascatalog_GWASC_study	clinvar	clinvar_CLNDN	clinvar_CLNSIG	clinvar_GENEINFO	clinvar_CLNDISDB	miRBase	pharmgkb_drug	pharmgkb_drug_PGKB_annid	pharmgkb_drug_PGKB_gene	pharmgkb_drug_PGKB_chem	pharmgkb_drug_PGKB_phencat
chr22	16132524	.	G	C	27	156	1962	0.173	3	C	intergenic_variant	MODIFIER	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	SNV	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	chr22:g.16132524G>C	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.
```

**Note(s):**
Each chunk will contain different parts of the original body plus the header.

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



---

## Temporary files:
NONE

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

## mk-rejoin-chromosomes directory structure

````
mk-rejoin-chromosomes/					      ## Module main directory
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
* Li, H. (2011). Tabix: fast retrieval of sequence features from generic TAB-delimited files. Bioinformatics, 27(5), 718-719.