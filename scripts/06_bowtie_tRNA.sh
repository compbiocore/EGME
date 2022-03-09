#!/bin/bash
#SBATCH -J egme_align_tRNA
#SBATCH --time=24:00:00
#SBATCH --mem=24G
#SBATCH --array=10
#SBATCH -n 4
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/egme_align_tRNA-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/egme_align_tRNA-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
ALIGNDIR=$WORKDIR/data/alignments
export SINGULARITY_BINDPATH="/gpfs/home/$USER,/gpfs/scratch/$USER,/gpfs/data/cbc"

#tRFs

#if (( ${SLURM_ARRAY_TASK_ID} > 10 ))
#then
#    ID=${SLURM_ARRAY_TASK_ID}
#else
#    ID=0${SLURM_ARRAY_TASK_ID}
#fi

ID=${SLURM_ARRAY_TASK_ID}

singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie2 --very-sensitive-local -x ${REFDIR}/tRNA -r ${FASTQDIR}/Library_${ID}.fastq -S ${ALIGNDIR}/Library_${ID}_tRNA.sam 
