rule fastq_gzip:
    input:
        fastq_1 ="resources/SRA/{biosample_ID}/{biosample_ID}_1.fastq",
        fastq_2 ="resources/SRA/{biosample_ID}/{biosample_ID}_2.fastq"
    output:
        fastq_1_gz = "resources/SRA/{biosample_ID}/{biosample_ID}_1.fastq.gz",
        fastq_2_gz = "resources/SRA/{biosample_ID}/{biosample_ID}_2.fastq.gz"
    log:
        logO="logs/gzip/{biosample_ID}.log",
        logE="logs/gzip/{biosample_ID}.err.log",
    conda:
        "../envs/fastq-gunzip_env.yaml"
    shell:
        """
        gzip -c {input.fastq_1} > {output.fastq_1_gz} && gzip -c {input.fastq_2} > {output.fastq_2_gz} && rm {input} > {log.logO} 2> {log.logE}
        """
