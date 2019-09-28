#!/usr/bin/env nextflow

/*================================================================
The MORETT LAB presents...

  The Variant Effect Predictor Annotation Pipeline

- A vcf rsId and functional effect prediction tool (and more)

==================================================================
Version: 0.0.1
Project repository: https://bitbucket.org/morett_lab/nf-vcf-annotation/src/master/
==================================================================
Authors:

- Bioinformatics Design
 Israel Aguilar-Ordonez (iaguilaror@gmail)

- Bioinformatics Development
 Israel Aguilar-Ordonez (iaguilaror@gmail)

- Nextflow Port
 Israel Aguilar-Ordonez (iaguilaror@gmail)

=============================
Pipeline Processes In Brief:
.
Pre-processing:
  _pre1_filter_vcf
  _pre2_extract_chromosomes
	_pre3_split_chromosomes

Core-processing:
  _001_untangle_multiallelic
  _002_annotate_rsID
  _003_vep_extended

Pos-processing
  _pos1_rejoin_chromosomes

================================================================*/

/* Define the help message as a function to call when needed *//////////////////////////////
def helpMessage() {
	log.info"""
  ==========================================
  The Variant Effect Predictor Annotation Pipeline
  - A vcf rsId and functional effect prediction tool (and more)
  v${version}
  ==========================================

	Usage:

  nextflow run vep-annotator.nf --vcffile <path to input 1> [--output_dir path to results ]

	  --vcffile    <- compressed vcf file for annotation;
				accepted extension is vcf.gz;
				vcf file must have a TABIX index with .tbi extension, located in the same directory as the vcf file
	  --output_dir     <- directory where results, intermediate and log files will bestored;
				default: same dir where --query_fasta resides
	  -resume	   <- Use cached results if the executed project has been run before;
				default: not activated
				This native NF option checks if anything has changed from a previous pipeline execution.
				Then, it resumes the run from the last successful stage.
				i.e. If for some reason your previous run got interrupted,
				running the -resume option will take it from the last successful pipeline stage
				instead of starting over
				Read more here: https://www.nextflow.io/docs/latest/getstarted.html#getstart-resume
	  --help           <- Shows Pipeline Information
	  --version        <- Show ExtendAlign version
	""".stripIndent()
}

/*//////////////////////////////
  Define pipeline version
  If you bump the number, remember to bump it in the header description at the begining of this script too
*/
version = "0.0.1"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
pipeline_name = "VEPannotation"

/*
  Initiate default values for parameters
  to avoid "WARN: Access to undefined parameter" messages
*/
params.vcffile = false  //if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.help = false //default is false to not trigger help message automatically at every run
params.version = false //default is false to not trigger version message automatically at every run

/*//////////////////////////////
  If the user inputs the --help flag
  print the help message and exit pipeline
*/
if (params.help){
	helpMessage()
	exit 0
}

/*//////////////////////////////
  If the user inputs the --version flag
  print the pipeline version
*/
if (params.version){
	println "VEP Annotator v${version}"
	exit 0
}

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by iaguilar at FEB 2019
*/
nextflow_required_version = '18.10.1'
/*
  Try Catch to verify compatible Nextflow version
  If user Nextflow version is lower than the required version pipeline will continue
  but a message is printed to tell the user maybe it's a good idea to update her/his Nextflow
*/
try {
	if( ! nextflow.version.matches(">= $nextflow_required_version") ){
		throw GroovyException('Your Nextflow version is older than Pipeline required version')
	}
} catch (all) {
	log.error "-----\n" +
			"  This pipeline requires Nextflow version: $nextflow_required_version \n" +
      "  But you are running version: $workflow.nextflow.version \n" +
			"  The pipeline will continue but some things may not work as intended\n" +
			"  You may want to run `nextflow self-update` to update Nextflow\n" +
			"============================================================"
}

/*//////////////////////////////
  INPUT PARAMETER VALIDATION BLOCK
  TODO (iaguilar) check the extension of input queries; see getExtension() at https://www.nextflow.io/docs/latest/script.html#check-file-attributes
*/

/* Check if vcffile provided
    if they were not provided, they keep the 'false' value assigned in the parameter initiation block above
    and this test fails
*/
if ( !params.vcffile ) {
  log.error " Please provide both, the --vcffile \n\n" +
  " For more information, execute: nextflow run vcf-annotation.nf --help"
  exit 1
}

/*
Output directory definition
Default value to create directory is the parent dir of --vcffile
*/
params.output_dir = file(params.vcffile).getParent()

/*
  Results and Intermediate directory definition
  They are always relative to the base Output Directory
  and they always include the pipeline name in the variable (pipeline_name) defined by this Script

  This directories will be automatically created by the pipeline to store files during the run
*/
results_dir = "${params.output_dir}/${pipeline_name}-results/"
intermediates_dir = "${params.output_dir}/${pipeline_name}-intermediate/"

/*
Useful functions definition
*/
/* define a function for extracting the file name from a full path */
/* The full path will be the one defined by the user to indicate where the reference file is located */
def get_baseName(f) {
	/* find where is the last appearance of "/", then extract the string +1 after this last appearance */
  	f.substring(f.lastIndexOf('/') + 1);
}


/*//////////////////////////////
  LOG RUN INFORMATION
*/
log.info"""
==========================================
The Variant Effect Predictor Annotation Pipeline
- A vcf rsId and functional effect prediction tool (and more)
v${version}
==========================================
"""
log.info "--Nextflow metadata--"
/* define function to store nextflow metadata summary info */
def nfsummary = [:]
/* log parameter values beign used into summary */
/* For the following runtime metadata origins, see https://www.nextflow.io/docs/latest/metadata.html */
nfsummary['Resumed run?'] = workflow.resume
nfsummary['Run Name']			= workflow.runName
nfsummary['Current user']		= workflow.userName
/* string transform the time and date of run start; remove : chars and replace spaces by underscores */
nfsummary['Start time']			= workflow.start.toString().replace(":", "").replace(" ", "_")
nfsummary['Script dir']		 = workflow.projectDir
nfsummary['Working dir']		 = workflow.workDir
nfsummary['Current dir']		= workflow.launchDir
nfsummary['Launch command'] = workflow.commandLine
log.info nfsummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "\n\n--Pipeline Parameters--"
/* define function to store nextflow metadata summary info */
def pipelinesummary = [:]
/* log parameter values beign used into summary */
pipelinesummary['VCFfile']			= params.vcffile
// pipelinesummary['vars per chunk']			= params.variants_per_chunk
pipelinesummary['REF: dbsnp']			= params.reference_dbsnp
pipelinesummary['REF: vep']			= params.vep_cache
pipelinesummary['vep gversion']			= params.vep_genome_version
pipelinesummary['REF: genome']			= params.genome_reference
pipelinesummary['REF: gnomAD']			= params.gnomad_reference
pipelinesummary['REF: gnomAD coverage']			= params.gnomad_coverage_reference
pipelinesummary['REF: GeneHancer']			= params.genehancer_reference
pipelinesummary['REF: GWAS catalog']			= params.gwascatalog_reference
pipelinesummary['REF: Clinvar']			= params.clinvar_reference
pipelinesummary['REF: miRBase']			= params.mirbase_reference
pipelinesummary['Results Dir']		= results_dir
pipelinesummary['Intermediate Dir']		= intermediates_dir
/* print stored summary info */
log.info pipelinesummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "==========================================\nPipeline Start"

/*//////////////////////////////
  PIPELINE START
*/

/*
	READ INPUTS
*/

/* Load vcf files AND TABIX INDEX into channel */
Channel
  .fromPath("${params.vcffile}*")
	.toList()
  .set{ vcf_inputs }

/* _pre1_filter_vcf */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-filter-vcf/*")
	.toList()
	.set{ mkfiles_pre1 }

process _pre1_filter_vcf {

	publishDir "${intermediates_dir}/_pre1_filter_vcf/",mode:"symlink"

	input:
	file sample from vcf_inputs
	file mk_files from mkfiles_pre1

	output:
	file "*.vcf.gz*" into results_pre1_filter_vcf

	"""
	bash runmk.sh
	"""

}

/* 	Process _pre2_extract_chromosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-extract-chromosomes/*")
	.toList()
	.set{ mkfiles_pre2 }

process _pre2_extract_chromosomes {

	publishDir "${intermediates_dir}/_pre2_extract_chromosomes/",mode:"symlink"

	input:
	file sample from results_pre1_filter_vcf
	file mk_files from mkfiles_pre2

	output:
	file "*.subsampled*.vcf" into results_pre2_extract_chromosomes mode flatten

	"""
	bash runmk.sh
	"""

}

/* _pre3_split_chromosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-split-chromosomes/*")
	.toList()
	.set{ mkfiles_pre3 }

process _pre3_split_chromosomes {

	publishDir "${intermediates_dir}/_pre3_split_chromosomes/",mode:"symlink"

	input:
	file sample from results_pre2_extract_chromosomes
	file mk_files from mkfiles_pre3

	output:
	file "*.chunk*.vcf" into results_pre3_split_chromosomes mode flatten

	"""
	bash runmk.sh
	"""

}

/* 	Process _001_untangle_multiallelic */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-untangle-multiallelic/*")
	.toList()
	.set{ mkfiles_001 }

process _001_untangle_multiallelic {

	publishDir "${intermediates_dir}/_001_untangle_multiallelic/",mode:"symlink"

	input:
	file sample from results_pre3_split_chromosomes
	file mk_files from mkfiles_001

	output:
	file "*.untangled_multiallelics.vcf" into results_001_untangle_multiallelic mode flatten

	"""
	bash runmk.sh
	"""

}

/* 	Process _002_annotate_rsID */
/* get the reference into a channel */
Channel
	.fromPath("${params.reference_dbsnp}*")
	.toList()
	.set{ reference_dbSNP }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-annotate-rsid/*")
	.toList()
	.set{ mkfiles_002 }

process _002_annotate_rsID {

	publishDir "${intermediates_dir}/_002_annotate_rsID/",mode:"symlink"

	input:
	file sample from results_001_untangle_multiallelic
	file dbSNPref from reference_dbSNP
	file mk_files from mkfiles_002

	output:
	file "*.anno_dbSNP.vcf" into results_002_annotate_rsID

	"""
	export REFERENCE_DBSNP="${get_baseName(params.reference_dbsnp)}"
	bash runmk.sh
	"""

}

/* 	Process _003_vep_extended */
/* Get every annotation reference into a channel */
cadd_snv = Channel.fromPath("${params.cadd_snv_reference}*")
cadd_indel = Channel.fromPath("${params.cadd_indel_reference}*")
genome_reference = Channel.fromPath("${params.genome_reference}*")
gnomad_reference = Channel.fromPath("${params.gnomad_reference}*")
gnomad_coverage_reference = Channel.fromPath("${params.gnomad_coverage_reference}*")
genehancer_reference = Channel.fromPath("${params.genehancer_reference}*")
gwascatalog_reference = Channel.fromPath("${params.gwascatalog_reference}*")
clinvar_reference = Channel.fromPath("${params.clinvar_reference}*")
mirbase_reference = Channel.fromPath("${params.mirbase_reference}*")
pgkb_reference = Channel.fromPath("${params.pharmgkb_drug_reference}*")
project_coverage_reference = Channel.fromPath("${params.project_coverage}*")

/* mix channels for VEP required references */
cadd_snv
	.mix(
		cadd_indel
		,genome_reference
		,gnomad_reference
		,gnomad_coverage_reference
		,genehancer_reference
		,gwascatalog_reference
		,clinvar_reference
		,mirbase_reference
		,pgkb_reference
		,project_coverage_reference
	)
	.toList()
	.set{ references_for_VEP }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-vep-extended/*")
	.toList()
	.set{ mkfiles_003 }

process _003_vep_extended {

	publishDir "${intermediates_dir}/_003_vep_extended/",mode:"symlink"

	input:
	file sample from results_002_annotate_rsID
	file refs from references_for_VEP
	file mk_files from mkfiles_003

	output:
	file "*.anno_dbSNP_vep.vcf" into results_003_vep_extended mode flatten

	"""
	export VEP_CACHE="${params.vep_cache}"
	export VEP_GENOME_VERSION="${params.vep_genome_version}"
	export CADD_SNV_REFERENCE="${get_baseName(params.cadd_snv_reference)}"
	export CADD_INDEL_REFERENCE="${get_baseName(params.cadd_indel_reference)}"
	export GENOME_REFERENCE="${get_baseName(params.genome_reference)}"
	export GNOMAD_REFERENCE="${get_baseName(params.gnomad_reference)}"
	export GNOMAD_COVERAGE_REFERENCE="${get_baseName(params.gnomad_coverage_reference)}"
	export GENEHANCER_REFERENCE="${get_baseName(params.genehancer_reference)}"
	export GWASCATALOG_REFERENCE="${get_baseName(params.gwascatalog_reference)}"
	export CLINVAR_REFERENCE="${get_baseName(params.clinvar_reference)}"
	export PGKB_DRUG_REFERENCE="${get_baseName(params.pharmgkb_drug_reference)}"
	export MIRBASE_REFERENCE="${get_baseName(params.mirbase_reference)}"
	export PROJECT_COVERAGE="${get_baseName(params.project_coverage)}"
	bash runmk.sh
	"""

}

/* _pos1_rejoin_chromosomes */
/* Gather every vcf */
results_003_vep_extended
  .toList()
  .set{ inputs_for_003 }

/* 	Process _pos1_rejoin_chromosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-rejoin-chromosomes/*")
	.toList()
	.set{ mkfiles_pos1 }

process _pos1_rejoin_chromosomes {

	publishDir "${results_dir}/_pos1_rejoin_chromosomes/",mode:"copy"

	input:
	file sample from inputs_for_003
	file mk_files from mkfiles_pos1

	output:
	file "*.vcf.gz*" into _pos1_rejoin_chromosomes

	"""
	bash runmk.sh
	"""

}
