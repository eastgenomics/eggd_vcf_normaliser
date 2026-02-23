# eggd_vcf_normaliser (DNAnexus platform app)

## What does this app do?

Normalises variants in a supplied input VCF, using `bcftools norm` via the htslib suite of tools (v1.22.0).

The default behaviour of the app is to run the following command:
`bcftools norm "$input_vcf" -f "$genome_fasta" -Oz -o "$output_vcf"`

Additional arguments for this command can optionally be supplied using the `bcftools_options` input.

## What inputs are required for this app to run?

- `input_vcf`: A VCF file of variants to be normalised (`.vcf.gz`)
- `fasta_tar`: A tar archive of a reference genome fasta and its index (`tar.gz` containing `genome.fa` and `genome.fa.fai`)

## What optional inputs can be supplied?

- `bcftools_options`: String of space-separated args and values to pass to bcftools norm
- e.g. `"-m -any"` to split multiallelics, `"--keep-sum AD"` to keep sum of AD values constant

Example:
```
-ibcftools_options="-m -any --keep-sum AD"
```

## What does this app output?

- `output_vcf`: Product of bcftools norm on the input VCF (`.vcf.gz`)
- `output_index`: Index file for output VCF (`.vcf.gz.tbi`)

<br></br>

This is the source code for an app that runs on the DNAnexus Platform.
For more information about how to run or modify it, see https://documentation.dnanexus.com/.

#### This app was made by EMEE GLH
