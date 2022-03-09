#!/bin/bash
#SBATCH -J egme_align_piRNA
#SBATCH --time=24:00:00
#SBATCH --mem=24G
#SBATCH --array=1-40
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/egme_align_piRNA-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/egme_align_piRNA-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
ALIGNDIR=$WORKDIR/data/alignments
export SINGULARITY_BINDPATH="/gpfs/home/$USER,/gpfs/scratch/$USER,/gpfs/data/cbc"

#piRNA

if (( ${SLURM_ARRAY_TASK_ID} >= 10 ))
then
    ID=${SLURM_ARRAY_TASK_ID}
else
    ID=0${SLURM_ARRAY_TASK_ID}
fi

#singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie -v 0 -S ${REFDIR}/piRNA ${FASTQDIR}/Library_${ID}.fastq ${ALIGNDIR}/Library_${ID}_piRNA.sam
singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie2 --very-sensitive-local -x ${REFDIR}/piRNA -r ${FASTQDIR}/Library_${ID}.fastq -S ${ALIGNDIR}/Library_${ID}_piRNA.sam


