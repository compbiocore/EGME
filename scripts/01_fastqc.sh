#!/bin/bash
#SBATCH -J egme_fastqc
#SBATCH --time=24:00:00
#SBATCH --mem=24G
#SBATCH --array=10-40
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/fastq-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/fastq-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/100_21_SF_EGME_RNA_seq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs

#if ${SLURM_ARRAY_TASK_ID} > 10
#then
#    ID=${SLURM_ARRAY_TASK_ID}
#else
#    ID=0${SLURM_ARRAY_TASK_ID}
#fi

sample=Library_${SLURM_ARRAY_TASK_ID}.fastq

source /gpfs/runtime/cbc_conda/bin/activate_cbc_conda

fastqc -o ${QCDIR}/fastqc fastqc $FASTQDIR/${sample}
