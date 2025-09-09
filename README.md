# EGME

This repository contains code for the EGME experiment with Dan Spade. The folders are organized thusly:

 * **scripts:**
   * *parse_nonSA.py:* Python script to parse results from sRNAbench into multi-mapped adjusted read counts for different small RNA groups (e.g. miRNAs, tRNAs, ncRNAs, cDNA) based on the ".grouped" files from sRNAbench.
 * **notebooks:** notebooks for processed data
 * **results:** any files that will be provided to the collaborator

# Data availability

Data for this project is stored on Oscar at `/gpfs/data/cbc/dspade/egme/data`. It is not in this repository due to size constraints. The data in that folder is organized thusly:

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
