#!/bin/bash

exec > /DATB/PHEW/project-marchantia/logs/download_biosample_log_2.txt 2>&1

num_lines=$(wc -l < workflow/scripts/biosample_ID.txt)
echo "Total number of lines in biosample_ID.txt: $num_lines"

while read -r biosample_ID run_IDs; do
    # Skip processing if biosample_ID is empty
    if [ -z "$biosample_ID" ]; then
        continue
    fi

    echo "biosample_ID: $biosample_ID"
    echo "run_IDs: $run_IDs"
    mkdir -p resources/SRA/$biosample_ID
    echo "Downloading files for biosample $biosample_ID"
    for run_ID in $run_IDs; do
        echo "Downloading file for run $run_ID"
        /home/clc/.conda/envs/sra_env/bin/fasterq-dump $run_ID -O resources/SRA/$biosample_ID
    done
    echo "Concatenating fastq files for biosample $biosample_ID"
    cat resources/SRA/$biosample_ID/*_1.fastq > resources/SRA/$biosample_ID/${biosample_ID}_1.fastq
    cat resources/SRA/$biosample_ID/*_2.fastq > resources/SRA/$biosample_ID/${biosample_ID}_2.fastq
    echo "Deleting original fastq files for biosample $biosample_ID"
    rm resources/SRA/$biosample_ID/SRR*_1.fastq resources/SRA/$biosample_ID/SRR*_2.fastq
    echo "Finished processing biosample $biosample_ID"
done < workflow/scripts/biosample_ID.txt