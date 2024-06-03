# Snakemake workflow: `project-marchantia`

A Snakemake workflow designed to search for DNA viruses in high-throughput sequencing data from Marchantia polymorpha.
This workflow is based on [project-tobamo] (https://github.com/nezapajek/project-tobamo) created by Neža Pajek (https://github.com/nezapajek). 

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)

## Usage

To run this Snakemake workflow, follow these steps:

1. **Prerequisites**: Ensure that you have the following software and dependencies installed:
   - Snakemake (version ≥6.3.0)
   
Snakemake is best installed via the Mamba package manager (a drop-in replacement for conda). If you have neither Conda nor Mamba, it can be installed via Mambaforge. Given that Mamba is installed, run:

        mamba create -c conda-forge -c bioconda --name snakemake snakemake

For all following commands ensure that this environment is activated via:

        conda activate snakemake

2. **Clone Repository**: Clone this repository to your local machine.

First, create an appropriate project working directory on your system and enter it:

        mkdir -p path/to/project-workdir
        cd path/to/project-workdir

Then, clone the github repository:
   
        git clone https://github.com/LanaVogrinec/snakemake-marchantia

3. **Configure workflow** Modify the workflow to your needs.

Modify the configuration file (config/config.yaml) and the Snakefile (workflow/Snakefile) to specify input files, parameters, and any other settings specific to your project. 

4. **Run workflow** Run the workflow with the following command: 

        snakemake --use-conda --cores <num_cores> 

## Workflow

1. Download and merging of all fastq files associated with a Biosample ID from the SRA database. 
    (script: download_biosample.sh., list of biosample IDs and SRA IDs: biosample_ID.txt)
2. Quality control and adapter trimming with [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
3. De Novo Assembly with [megahit](https://www.metagenomics.wiki/tools/assembly/megahit)
4. Search for similarity against non-redundant (NR) protein database with [Diamond](https://bio.tools/diamond) blastx
5. Assigning taxonomy with [Megan6] (https://www.computomics.com/services/megan6.html).


If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of the original repository.
