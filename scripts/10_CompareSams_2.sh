#!/bin/bash
#SBATCH -J egme_CompareSAMs
#SBATCH --time=24:00:00
#SBATCH --mem=42G
#SBATCH --array=1-9
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/egme_CompareSAMs-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/egme_CompareSAMs-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
ALIGNDIR=$WORKDIR/data/alignments

ID=Library_0${SLURM_ARRAY_TASK_ID}

source /gpfs/runtime/cbc_conda/bin/activate_cbc_conda

picard CompareSAMs \
${ALIGNDIR}/${ID}_miRNA_mapped_sorted.bam \
${ALIGNDIR}/${ID}_piRNA_mapped_sorted.bam \
VALIDATION_STRINGENCY=LENIENT \
LENIENT_LOW_MQ_ALIGNMENT=true \
LENIENT_DUP=true \
LENIENT_HEADER=true \
O=${QCDIR}/picard/${ID}_miRNA_vs_piRNA.txt

picard CompareSAMs \
${ALIGNDIR}/${ID}_miRNA_mapped_sorted.bam \
${ALIGNDIR}/${ID}_mRNA_mapped_sorted.bam \
VALIDATION_STRINGENCY=LENIENT \
LENIENT_LOW_MQ_ALIGNMENT=true \
LENIENT_DUP=true \
LENIENT_HEADER=true \
O=${QCDIR}/picard/${ID}_miRNA_vs_mRNA.txt

picard CompareSAMs \
${ALIGNDIR}/${ID}_miRNA_mapped_sorted.bam \
${ALIGNDIR}/${ID}_tRNA_mapped_sorted.bam \
VALIDATION_STRINGENCY=LENIENT \
LENIENT_LOW_MQ_ALIGNMENT=true \
LENIENT_DUP=true \
LENIENT_HEADER=true \
O=${QCDIR}/picard/${ID}_miRNA_vs_tRNA.txt
