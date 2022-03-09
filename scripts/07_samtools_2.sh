#!/bin/bash
#SBATCH -J egme_samtools
#SBATCH --time=24:00:00
#SBATCH --mem=40G
#SBATCH --array=1-9
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/egme_samtools-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/egme_samtools-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
ALIGNDIR=$WORKDIR/data/alignments
export SINGULARITY_BINDPATH="/gpfs/home/$USER,/gpfs/scratch/$USER,/gpfs/data/cbc"

#input=($(ls ${ALIGNDIR}/Library_*.sam))
#sample_bn=${input[$((SLURM_ARRAY_TASK_ID))]}
#sample=($(basename ${sample_bn} .sam))

sample=Library_0${SLURM_ARRAY_TASK_ID}

echo ${ALIGNDIR}/${sample}_type.sam

singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -o ${ALIGNDIR}/${sample}_miRNA.bam ${ALIGNDIR}/${sample}_miRNA.sam
singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_miRNA_sorted.bam ${ALIGNDIR}/${sample}_miRNA.bam
singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_miRNA_sorted.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -F 0x4 -o ${ALIGNDIR}/${sample}_miRNA_mapped.bam ${ALIGNDIR}/${sample}_miRNA.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_miRNA_mapped_sorted.bam ${ALIGNDIR}/${sample}_miRNA_mapped.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_miRNA_mapped_sorted.bam

#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -o ${ALIGNDIR}/${sample}_mRNA.bam ${ALIGNDIR}/${sample}_mRNA.sam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_mRNA_sorted.bam ${ALIGNDIR}/${sample}_mRNA.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_mRNA_sorted.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -F 0x4 -o ${ALIGNDIR}/${sample}_mRNA_mapped.bam ${ALIGNDIR}/${sample}_mRNA.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_mRNA_mapped_sorted.bam ${ALIGNDIR}/${sample}_mRNA_mapped.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_mRNA_mapped_sorted.bam

#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -o ${ALIGNDIR}/${sample}_piRNA.bam ${ALIGNDIR}/${sample}_piRNA.sam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_piRNA_sorted.bam ${ALIGNDIR}/${sample}_piRNA.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_piRNA_sorted.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -F 0x4 -o ${ALIGNDIR}/${sample}_piRNA_mapped.bam ${ALIGNDIR}/${sample}_piRNA.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_piRNA_mapped_sorted.bam ${ALIGNDIR}/${sample}_piRNA_mapped.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_piRNA_mapped_sorted.bam

#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -o ${ALIGNDIR}/${sample}_tRNA.bam ${ALIGNDIR}/${sample}_tRNA.sam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_tRNA_sorted.bam ${ALIGNDIR}/${sample}_tRNA.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_tRNA_sorted.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools view -bh -F 0x4 -o ${ALIGNDIR}/${sample}_tRNA_mapped.bam ${ALIGNDIR}/${sample}_tRNA.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools sort -o ${ALIGNDIR}/${sample}_tRNA_mapped_sorted.bam ${ALIGNDIR}/${sample}_tRNA_mapped.bam
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif samtools index -b ${ALIGNDIR}/${sample}_tRNA_mapped_sorted.bam
