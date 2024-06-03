rule diamond:
    input:
        "results/{sample_ID}/02_{sample_ID}_spades_contigs.fasta",
    output:
        "results/{sample_ID}/03_{sample_ID}_spades_diamond.daa",
    log:
        logO="logs/diamond/{sample_ID}.log",
        logE="logs/diamond/{sample_ID}.err.log",
    benchmark:
        "results/{sample_ID}/03_{sample_ID}_benchmark_spades_diamond.txt",
    conda:
        "../envs/diamond-megan_env.yaml"
    threads: 40
    shell:
        """
        diamond blastx --threads {threads} -d /DATA/PHEW/databases/diamond_20240405_v.0.9.14/nr.dmnd -k 20 -q {input} --daa {output} > {log.logO} 2> {log.logE}
        """