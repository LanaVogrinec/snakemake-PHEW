rule megan_meganizer:
    input:
        "results/{biosample_ID}/03_{biosample_ID}_megahit_diamond.daa",
    output:
        "results/{biosample_ID}/04_{biosample_ID}_meganizer.daa",
    log:
        logO="logs/megan_meganizer/{biosample_ID}.log",
        logE="logs/megan_meganizer/{biosample_ID}.err.log",
    benchmark:
        "results/{biosample_ID}/04_{biosample_ID}_benchmark_meganizer.txt"
    conda:
        "../envs/diamond-megan.yaml"
    threads: 40

    shell:
        """
        cp {input} {output}
        if [[ $(diamond view --daa {output} | wc -l) -ge 1 ]]; then
            daa-meganizer --threads {threads} -i {output} -mdb /home/clc/Documents/MEGAN6_database/megan-map-Feb2022.db -supp 0 > {log.logO} 2> {log.logE}
        fi
        """


