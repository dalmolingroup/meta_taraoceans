# meta_taraocean

This repository is the result of a master's project in Bioinformatics, focusing on ocean metagenomics. For this analysis, data obtained from the [Tara Oceans Expedition](http://ocean-microbiome.embl.de/companion.html) and the [MEDUSA](https://github.com/dalmolingroup/MEDUSA) open source pipeline were used.

To reproduce the results, it is important to correctly follow the steps present in this README or even those present in each directory of this repository.

## Repository structure

- doc: Tables used in the project.
  - tables/original: Tables retrieved directly from the Tara Oceans website.
  - tables/used: Tables containing only information about the samples selected for the present work.
- data: All material developed in this project.
  - pipeline_workflow: MEDUSA pipeline configuration and execution files.
  - results: Code and results obtained with the output of the MEDUSA pipeline.
    Each subfolder of these repositories has as respective subfolders "biodiversity", "functional" and "taxonomic",
    with their due explanations present in the README.md files present in each one of them.
    - results/code: All the code created to build tables, graphs and figures for interpreting the results.
    - results/input: Input files for analyzing the results. These files are the MEDUSA pipeline output files.
    - results/output: Output files with the results obtained in the analyses, such as tables, graphs and figures.

## Preparation of the working environment

Here, we used the MEDUSA, a tool for metagenomics analysis. The code used in this project followed the step-by-step guide described on the [Supplementary Material](https://www.frontiersin.org/articles/10.3389/fgene.2022.814437/full#supplementary-material) of the MEDUSA paper.

1. Go to data/pipeline_workflow/00-default

```
cd meta_taraoceans/data/pipeline_workflow/00-default
```

2. Adjust the paths of variables present in 00-var.sh to your local computer

```
nano 00-var.sh
```

3. Follow the steps present in 00-environment.sh

## Pipeline execution

1. Activate the environment

```
conda activate medusaPipeline
```

2. Execute, in order, each step of the pipeline. Note: only start the next one after finishing the previous one.

```
nohup 01-raw_data.sh &
nohup 02-preprocessing.sh &
nohup 03-alignment.sh &
nohup 04-taxonomic_classification.sh &
nohup 05-functional_annotation.sh &
```

## Results

- Taxonomic Classification

```
cd meta_taraoceans/data/results/code/taxonomic
Rscript taxonomic.R
```

- Biodiversity

```
cd meta_taraoceans/data/results/code/biodiversity
Rscript biodiversity.R
```

- Functional Annotation

```
cd meta_taraoceans/data/results/code/functional
Rscript functional.R
```

For more information about the MEDUSA pipeline, check:

> Morais, D.A.A.; Cavalcante, J.V.F.; Monteiro, S.S.; Pasquali, M.A.B.; Dalmolin, R.J.S. MEDUSA: A Pipeline for Sensitive
> Taxonomic Classification and Flexible Functional Annotation of Metagenomic Shotgun Sequences, 2022. https://doi.org/10.3389/fgene.2022.814437.
