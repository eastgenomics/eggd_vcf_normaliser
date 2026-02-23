# eggd_vcf_normaliser (DNAnexus platform app)

## What does this app do?

Normalises variants in a supplied input VCF, using bcftools norm via the htslib suite of tools (v1.22.0).

## What are typical use cases for this app?



## What inputs are required for this app to run?

- `input_vcf`: A VCF file of variants to normalise
- `fasta_tar`: A tar archive of a reference genome fasta and its index

## What does this app output?

- `output_vcf`: Product of normalising the input VCF using bcftools norm
- `output_index`: Index file for output VCF

This is the source code for an app that runs on the DNAnexus Platform.
For more information about how to run or modify it, see https://documentation.dnanexus.com/.

#### This app was made by EMEE GLH
