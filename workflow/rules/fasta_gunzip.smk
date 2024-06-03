rule fasta_gzip:
    input:
        "results/{sample_ID}/02_{sample_ID}_spades_contigs.fasta"
    output:
        "results/{sample_ID}/02_{sample_ID}_spades_contigs.fasta.gz"
    log:
        logO="logs/fasta_gzip/{sample_ID}.log",
        logE="logs/fasta_gzip/{sample_ID}.err.log",
    shell:
        """
        gzip -c {input[0]} > {output[0]} 2> {log.logE}
        """
