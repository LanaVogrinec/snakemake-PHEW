rule megan_meganizer:
    input:
        "results/{sample_ID}/03_{sample_ID}_spades_diamond.daa",
    output:
        "results/{sample_ID}/04_{sample_ID}_meganizer.daa",
    log:
        logO="logs/megan_meganizer/{sample_ID}.log",
        logE="logs/megan_meganizer/{sample_ID}.err.log",
    benchmark:
        "results/{sample_ID}/04_{sample_ID}_benchmark_meganizer.txt"
    conda:
        "../envs/diamond-megan_env.yaml"
    threads: 40

    shell:
        """
        cp {input} {output}
        if [[ $(diamond view --daa {output} | wc -l) -ge 1 ]]; then
            daa-meganizer --threads {threads} -i {output} -mdb /home/clc/Documents/MEGAN6_database/megan-map-Feb2022.db -supp 0 > {log.logO} 2> {log.logE}
        fi
        """


