#!/bin/bash

_download_inputs() {
    mark-section "Downloading inputs"
    echo "Downloading input files..."
    dx-download-all-inputs --parallel
    # Move files to the correct directory
    find ~/in/ -type f -name "*" -print0 | xargs -0 -I {} mv {} /home/dnanexus
}

_extract_reference() {
    mark-section "Extracting reference"
    echo "Extracting reference archive..."
    tar -I pigz -xf "$fasta_tar_name"
    genome_fasta=$(find ~/ -type f -name "*.fa" -print0)
    echo "Reference genome fasta used: ${genome_fasta}"
}

_create_output_name() {
    mark-section "Creating output filenames"
    echo "Creating output filenames..."
    output_vcf="${input_vcf_prefix}_normalised.vcf.gz"
    output_index="${input_vcf_prefix}_normalised.vcf.gz.tbi"
}

_normalise_vcf() {
    mark-section "Normalising and indexing VCF"
    echo "Normalising and indexing VCF..."
    if [[ -n $bcftools_options ]]; then
        read -r -a bcftools_args <<< "$bcftools_options"
        bcftools norm "$input_vcf_name" -f "$genome_fasta" "${bcftools_args[@]}" -Oz -o "$output_vcf"
    else
        bcftools norm "$input_vcf_name" -f "$genome_fasta" -Oz -o "$output_vcf"
    fi
    tabix -p vcf "$output_vcf"
}

_upload_outputs() {
    mark-section "Uploading outputs"
    echo "Uploading outputs..."
    uploaded_vcf=$(dx upload "$output_vcf" --brief)
    uploaded_index=$(dx upload "$output_index" --brief)
    dx-jobutil-add-output output_vcf "$uploaded_vcf" --class=file
    dx-jobutil-add-output output_index "$uploaded_index" --class=file
}

main() {
    set -exo pipefail
    _download_inputs
    _extract_reference
    _create_output_name
    _normalise_vcf
    _upload_outputs
    echo "Done!"
    mark-success
}
