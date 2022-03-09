#!/bin/bash
#SBATCH -J egme_CollectMultipleMetrics
#SBATCH --time=24:00:00
#SBATCH --mem=42G
#SBATCH --array=1-9
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/egme_CollectMultipleMetrics-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/egme_CollectMultipleMetrics-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
ALIGNDIR=$WORKDIR/data/alignments

export SINGULARITY_BINDPATH="/gpfs/home/$USER,/gpfs/scratch/$USER,/gpfs/data/cbc"

ID=Library_0${SLURM_ARRAY_TASK_ID}
#ID=Library_${SLURM_ARRAY_TASK_ID}

picard CollectMultipleMetrics -Xmx10000M  \
I=${ALIGNDIR}/${ID}_miRNA_sorted.bam \
O=${QCDIR}/picard_rerun/multiple_metrics_${ID}_miRNA_sorted_bam \
R=${REFDIR}/hairpin.fa.gz \
VALIDATION_STRINGENCY=LENIENT \
PROGRAM=CollectAlignmentSummaryMetrics \
PROGRAM=CollectGcBiasMetrics \
PROGRAM=QualityScoreDistribution

picard CollectMultipleMetrics -Xmx10000M  \
I=${ALIGNDIR}/${ID}_tRNA_sorted.bam \
O=${QCDIR}/picard_rerun/multiple_metrics_${ID}_tRNA_sorted_bam \
R=${REFDIR}/rn6_tRNA.fasta \
VALIDATION_STRINGENCY=LENIENT \
PROGRAM=CollectAlignmentSummaryMetrics \
PROGRAM=CollectGcBiasMetrics \
PROGRAM=QualityScoreDistribution

picard CollectMultipleMetrics -Xmx10000M  \
I=${ALIGNDIR}/${ID}_mRNA_sorted.bam \
O=${QCDIR}/picard_rerun/multiple_metrics_${ID}_mRNA_sorted_bam \
R=${REFDIR}/Ensembl_transcriptome.fa \
VALIDATION_STRINGENCY=LENIENT \
PROGRAM=CollectAlignmentSummaryMetrics \
PROGRAM=CollectGcBiasMetrics \
PROGRAM=QualityScoreDistribution

picard CollectMultipleMetrics -Xmx10000M  \
I=${ALIGNDIR}/${ID}_piRNA_sorted.bam \
O=${QCDIR}/picard_rerun/multiple_metrics_${ID}_piRNA_sorted_bam \
R=${REFDIR}/Rattus_norvegicus_piRNA_AND_TAXONOMY10116_AND_entry_typeSequence.fasta.gz \
VALIDATION_STRINGENCY=LENIENT \
PROGRAM=CollectAlignmentSummaryMetrics \
PROGRAM=CollectGcBiasMetrics \
PROGRAM=QualityScoreDistribution
