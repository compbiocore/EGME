#!/bin/bash
#SBATCH -J egme_align_miRNA
#SBATCH --time=24:00:00
#SBATCH --mem=12G
#SBATCH --array=10-40
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/egme_align_miRNA-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/egme_align_miRNA-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
ALIGNDIR=$WORKDIR/data/alignments
export SINGULARITY_BINDPATH="/gpfs/home/$USER,/gpfs/scratch/$USER,/gpfs/data/cbc"

if (( ${SLURM_ARRAY_TASK_ID} >= 10 ))
then
    ID=${SLURM_ARRAY_TASK_ID}
else
    ID=0${SLURM_ARRAY_TASK_ID}
fi

echo ${ID}

#bowtie2 params are from the paper doi: 10.1093/toxsci/kfz041
#miRNAs
singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie2 -D 20 -R 3 -N 1 -L 10 -i S,1,0.50 -x ${REFDIR}/miRNA -r ${FASTQDIR}/Library_${ID}.fastq -S ${ALIGNDIR}/Library_${ID}_miRNA.sam
