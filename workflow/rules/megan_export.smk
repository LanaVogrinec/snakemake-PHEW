rule megan_export:
    input:
        "results/{biosample_ID}/04_{biosample_ID}_meganizer.daa",
    output:
        taxon="results/{biosample_ID}/05_{biosample_ID}_meganizer_read_classification.tsv",
        class_count="results/{biosample_ID}/05_{biosample_ID}_meganizer_class_count.tsv",
    log:
        logO="logs/megan_export/{biosample_ID}.log",
        logE="logs/megan_export/{biosample_ID}.err.log",
    conda:
        "../envs/diamond-megan.yaml"
    shell:
        """
        daa2info -i {input} -r2c Taxonomy -p -o {output.taxon} > {log.logO} 2> {log.logE}
        daa2info -i {input} -c2c Taxonomy -p -o {output.class_count} >> {log.logO} 2>> {log.logE}
        """