# EGME

**Preprint:** [bioRxiv 2025.12.29.693789v1](https://www.biorxiv.org/cgi/content/short/2025.12.29.693789v1) - *Currently under review at Toxicological Sciences (ToxSci)*

## Overview

This repository contains code and analysis pipelines for differential expression analysis of small RNAs (miRNAs, tRNAs, piRNAs) and their annotations in the EGME experiment. The analysis focuses on identifying changes in small RNA expression patterns and their functional implications through over-representation analysis (ORA) of miRNA targets.

## Repository Structure

This repository contains code for the EGME experiment with Dan Spade. Relevant files are in the following folder structure:

 * **scripts:**
   * `01_fastqc.sh` through `10_CompareSams_2.sh`: files in sequence for custom bioinformatics pipeline to map and annotate reads following Stermer et al. 2019. Ultimately we did not use this method for our mapping and annotation, we used sRNAbench.
   * `parse_nonSA.py`: Python script to parse results from sRNAbench into multi-mapped adjusted read counts for different small RNA groups (e.g. miRNAs, tRNAs, ncRNAs, cDNA) based on the ".grouped" files from sRNAbench.
   * `DESeq.Rmd`: R code for running DESeq and generating results stored in **results/DESeq**.
   * `ORA_miRNA_targets.Rmd`: R code for ORA results for miRNA
   * `sig_miRNA_count_plots_by_dosage.Rmd`: R code for generating count plots of significant miRNAs by dosage level
 * **notebooks:**
   * `trna.qmd`: Code to generate tRNA figures
   * `final_coverage_data.csv`: Coverage data for tRNA analysis
   * `links.txt`: Links to related Google documents for documentation
 * **results:**
   * **DESeq:** Folders with DESeq results, labeled by type of sequence (e.g. RNA, cDNA, miRNA), test (l=likelihood, w=wald), and dosage (e.g. 50,60).
   * **UpSet:** CSV and json for exploratory UpSet plots - not in manuscript.
   * **qc:** multiQC reports for raw sequences
   * **read_counts:** Read count CSV files
   * `DESeq.html`: Rendered HTML report of DESeq analysis
   * `ORA_miRNA_targets.html`: Rendered HTML report of over-representation analysis for miRNA targets
   * `sig_miRNA_count_plots_by_dosage.html`: Rendered HTML report of significant miRNA count plots
   * `target_genes_all_no_rep.csv`: CSV file with target genes identified across all analyses (without replicates)
   * `target_genes_by_miRNAs.xlsx`: Excel file with target genes organized by miRNA
 * **figures:**
   * `trna_coverage.pdf`: PDF figure showing tRNA coverage patterns
 * **metadata:**
   * `100.21 RNAseq summary 2020-07-06 DS.xlsx`: Excel file with RNAseq experiment summary and sample metadata
   * `Dockerfile`: Docker configuration for reproducible environment setup with required bioinformatics tools
 * **Root directory files:**
   * `hua.R`: R script for differential expression analysis using DESeq2, including filtering, normalization, PCA, and visualization
   * `Hua et al.Rproj`: RStudio project file for the EGME analysis

# Data availability

Data for this project is stored on Oscar at `/gpfs/data/cbc/dspade/egme/data` as well as copies on the research share `BM_SpadeLab/EGME/CBC`. It is not in this repository due to size constraints. The data in that folder is organized thusly:

 * **fastqs:** The raw fastq files
 * **alignments:** Alignments

# CBC Project Information

```
title: EGME
tags: RNAseq, small RNA
analysts: August Guang
git_repo_url: github.com/compbiocore/EGME
resources_used: bioflows, R, DESeq2
summary:
project_id:
```

# Reproducibility

## Docker Environment

A Docker image is provided in `metadata/Dockerfile` to ensure reproducibility of the analysis environment. The image is based on `rocker/rstudio:4.1.2` and includes:

- R 4.1.2 with RStudio
- Bioinformatics tools: samtools, bedtools, subread, picard, igv, fastqc, trimmomatic, bowtie (versions as specified in the Dockerfile)
- Required system libraries for R package compilation
- Python 3 with pip

To build and run the Docker environment:

```bash
cd metadata
docker build -t egme-analysis .
docker run -e PASSWORD=SECURE_PASSWORD -p 8787:8787 -v /path/to/data:/home/rstudio/data egme-analysis
```

Then access RStudio at `http://localhost:8787` with username `rstudio` and your chosen password.

## R Dependencies

Key R packages used in this analysis include:

- DESeq2: Differential expression analysis
- edgeR: Additional differential expression tools
- limma: Linear models for microarray and RNA-seq data
- ggplot2: Data visualization
- tidyverse: Data manipulation and analysis
- org.Mm.eg.db: Mouse genome annotation

Install R dependencies in R:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("DESeq2", "edgeR", "limma", "org.Mm.eg.db", "SummarizedExperiment"))
install.packages(c("tidyverse", "ggplot2", "RColorBrewer", "readr"))
```

## Running the Analysis

1. **Data preparation**: Ensure raw data is available at the path specified in the "Data availability" section
2. **sRNAbench mapping**: Process raw FASTQs through sRNAbench (not included in this repository)
3. **Parse read counts**: Run `scripts/parse_nonSA.py` to generate read count matrices
4. **Differential expression**: Execute `scripts/DESeq.Rmd` for DESeq2 analysis
5. **Functional analysis**: Run `scripts/ORA_miRNA_targets.Rmd` for over-representation analysis
6. **tRNA analysis**: Execute `notebooks/trna.qmd` for tRNA-specific analyses
7. **Visualization**: Generate plots using `scripts/sig_miRNA_count_plots_by_dosage.Rmd`

Rendered HTML reports are available in the `results/` directory.
