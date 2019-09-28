echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run vep-annotator.nf \
	--vcffile test/data/sample.vcf.gz \
	--reference_dbsnp test/reference/dbSNP/sample_dbSNP.vcf.gz \
	--cadd_snv_reference test/reference/CADD/sample_SNVs.tsv.gz \
	--cadd_indel_reference test/reference/CADD/sample_InDels.tsv.gz \
	--genome_reference test/reference/genome/chr22.fa.gz \
	--gnomad_reference test/reference/gnomAD/sample_gnomAD.vcf.bgz \
	--gnomad_coverage_reference test/reference/gnomAD/sample_gnomAD.coverage.summary.bed.gz \
	--genehancer_reference test/reference/GeneHancer/GeneHancers_with_genes.bed.gz \
	--gwascatalog_reference test/reference/GWAS_catalog/All_20180418_noINFO.GWAScatalog.vcf.gz \
	--clinvar_reference test/reference/ClinVar/Clinvar.vcf.gz \
	--mirbase_reference test/reference/miRBase/miRBase.bed.gz \
	--pharmgkb_drug_reference test/reference/PharmGKB/All_20180418_noINFO.PGKB.vcf.gz \
	--project_coverage test/reference/100GMX/sample_coverages.bed.gz \
	--output_dir test/results \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n VEP annotator: Basic pipeline TEST SUCCESSFUL \n======"
