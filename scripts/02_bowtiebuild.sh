#!/bin/bash
#SBATCH -J egme_bowtie_build
#SBATCH --time=24:00:00
#SBATCH --mem=24G
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -e /gpfs/data/cbc/dspade/EGME/logs/bowtie_build-%A-%a-%J.err
#SBATCH -o /gpfs/data/cbc/dspade/EGME/logs/bowtie_build-%A-%a-%J.out

WORKDIR=/gpfs/data/cbc/dspade/EGME
FASTQDIR=$WORKDIR/data/fastq
QCDIR=$WORKDIR/data/qc
LOGIDR=$WORKDIR/logs
REFDIR=$WORKDIR/data/references
ENVDIR=$WORKDIR/env
export SINGULARITY_BINDPATH="/gpfs/home/$USER,/gpfs/scratch/$USER,/gpfs/data/cbc"

#piRNA
singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie2-build ${REFDIR}/Rattus_norvegicus_piRNA_AND_TAXONOMY10116_AND_entry_typeSequence.fasta.gz ${REFDIR}/piRNA

#mRNA fragments
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie2-build ${REFDIR}/Ensembl_transcriptome.fa ${REFDIR}/mRNA

#tRFs 
#fasta deflines have spaces in them, clean up before making indices and running alignments
#sed -e 's/\s\+/_/g' ${REFDIR}/rn6_tRNA.fasta > ${REFDIR}/rn6_tRNA_edit.fasta
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie2-build ${REFDIR}/rn6_tRNA_edit.fasta ${REFDIR}/tRNA

#miRNA
#singularity exec ${ENVDIR}/dspade-egme-20220222.sif bowtie2-build ${REFDIR}/hairpin.fa.gz ${REFDIR}/miRNA
