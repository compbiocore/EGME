#!/bin/bash
#SBATCH -J egme_EstimateLibraryComplexity
#SBATCH --time=24:00:00
#SBATCH --mem=42G
#SBATCH --array=1-9
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/egme_EstimateLibraryComplexity-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/egme_EstimateLibraryComplexity-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
ALIGNDIR=$WORKDIR/data/alignments

ID=Library_0${SLURM_ARRAY_TASK_ID}

source /gpfs/runtime/cbc_conda/bin/activate_cbc_conda

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_miRNA_mapped_sorted.bam  \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_miRNA_mapped.txt \
VALIDATION_STRINGENCY=LENIENT

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_mRNA_mapped_sorted.bam  \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_mRNA_mapped.txt \
VALIDATION_STRINGENCY=LENIENT

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_piRNA_mapped_sorted.bam  \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_piRNA_mapped.txt \
VALIDATION_STRINGENCY=LENIENT

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_tRNA_mapped_sorted.bam  \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_tRNA_mapped.txt \
VALIDATION_STRINGENCY=LENIENT

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_miRNA.bam  \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_miRNA_bam.txt \
VALIDATION_STRINGENCY=LENIENT

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_mRNA.bam \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_mRNA_bam.txt \
VALIDATION_STRINGENCY=LENIENT

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_piRNA.bam  \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_piRNA_bam.txt \
VALIDATION_STRINGENCY=LENIENT

picard EstimateLibraryComplexity -Xmx10000M  \
I=${ALIGNDIR}/${ID}_tRNA.bam  \
O=${QCDIR}/picard/lib_complex_metrics_${ID}_tRNA_bam.txt \
VALIDATION_STRINGENCY=LENIENT

