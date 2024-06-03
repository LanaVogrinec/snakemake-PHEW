rule spades:
    input:
        r1="results/{sample_ID}/01_{sample_ID}_trim_1_paired.fq.gz",
        r2="results/{sample_ID}/01_{sample_ID}_trim_2_paired.fq.gz",
    output:
        d=temp(directory("results/{sample_ID}/{sample_ID}_spades")),
        f="results/{sample_ID}/02_{sample_ID}_spades_contigs.fasta",
    log:
        logO="logs/spades/{sample_ID}.log",
        logE="logs/spades/{sample_ID}.err.log",
    conda:
        "../envs/spades_env.yaml"
    threads: 40
    shell:
        """
        rnaviralspades.py -t {threads} -1 {input.r1} -2 {input.r2} -o {output.d} > {log.logO} 2> {log.logE}
        cp {output.d}/contigs.fasta {output.f}

        """
