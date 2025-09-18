# EGME

This repository contains code for the EGME experiment with Dan Spade. Relevant files are in the following folder structure:

 * **scripts:**
   * `01_fastqc.sh` through `10_CompareSams_2.sh`: files in sequence for custom bioinformatics pipeline to map and annotate reads following Stermer et al. 2019. Ultimately we did not use this method for our mapping and annotation, we used sRNAbench.
   * `parse_nonSA.py`: Python script to parse results from sRNAbench into multi-mapped adjusted read counts for different small RNA groups (e.g. miRNAs, tRNAs, ncRNAs, cDNA) based on the ".grouped" files from sRNAbench.
   * `DESeq.Rmd`: R code for running DESeq and generating results stored in **results/DESeq**.
   * `ORA_miRNA_targets.Rmd`: R code for ORA results for miRNA
 * **notebooks:**
   * `trna.qmd:` Code to generate tRNA figures
 * **results:**
   * **DESeq:** Folders with DESeq results, labeled by type of sequence (e.g. RNA, cDNA, miRNA), test (l=likelihood, w=wald), and dosage (e.g. 50,60).
   * **UpSet:** CSV and json for exploratory UpSet plots - not in manuscript.
   * **qc:** multiQC reports for raw sequences
   * **read_counts:** Read count CSV files

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
