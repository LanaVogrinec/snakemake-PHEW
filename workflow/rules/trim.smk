rule trim:
    input:
        r1="resources/SRA/{biosample_ID}/{biosample_ID}_1.fastq.gz",
        r2="resources/SRA/{biosample_ID}/{biosample_ID}_2.fastq.gz",
        iclip="resources/TruSeq3-PE.fa",

    output:
        tp1="results/{biosample_ID}/01_{biosample_ID}_trim_1_paired.fq.gz",
        tp2="results/{biosample_ID}/01_{biosample_ID}_trim_2_paired.fq.gz",
        tup1="results/{biosample_ID}/01_{biosample_ID}_trim_1_unpaired.fq.gz",
        tup2="results/{biosample_ID}/01_{biosample_ID}_trim_2_unpaired.fq.gz",
        check="results/{biosample_ID}/01_{biosample_ID}_trim_pe.done",
    log:
        logO="logs/trim/{biosample_ID}.log",
        logE="logs/trim/{biosample_ID}.err.log",
    conda:
        "../envs/trimmomatic_env.yaml"
    threads: 4
    shell:
        """
        trimmomatic PE -threads {threads} -phred33 {input.r1} {input.r2} {output.tp1} {output.tup1} {output.tp2} {output.tup2} ILLUMINACLIP:{input.iclip}:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36 > {log.logO} 2> {log.logE}
        touch {output.check}
        """
