# !/bin/bash
cd ./bam/

for DATASET in T-MAU2_NT_rep1 T-MAU2_NT_rep2 T-MAU2_NT_rep3 T-MAU2_Dox2h_rep1 T-MAU2_Dox2h_rep2 T-MAU2_Dox2h_rep3 T-mCherry_NT_rep1 T-mCherry_NT_rep2 T-mCherry_NT_rep3 T-mCherry_Dox2h_rep1 T-mCherry_Dox2h_rep2 T-mCherry_Dox2h_rep3
do
	samtools view -@ 16 -b -f 16 ${DATASET}.bam > ${DATASET}_forward_unsorted.bam
	samtools sort -@ 16 -o ${DATASET}_forward.bam ${DATASET}_forward_unsorted.bam
	rm ${DATASET}_forward_unsorted.bam

	samtools view -@ 16 -b -F 16 ${DATASET}.bam > ${DATASET}_reverse_unsorted.bam
	samtools sort -@ 16 -o ${DATASET}_reverse.bam ${DATASET}_reverse_unsorted.bam
	rm ${DATASET}_reverse_unsorted.bam

	samtools index ${DATASET}_forward.bam
	samtools index ${DATASET}_reverse.bam
done

for DATASET in T-MAU2_NT T-MAU2_Dox2h T-mCherry_NT T-mCherry_Dox2h
do
	samtools merge -@ 16 BrUseq_${DATASET}_unsorted.bam ${DATASET}_rep1.bam ${DATASET}_rep2.bam ${DATASET}_rep3.bam
	samtools sort -@ 16 -o BrUseq_${DATASET}.bam BrUseq_${DATASET}_unsorted.bam
	rm BrUseq_${DATASET}_unsorted.bam
	samtools index BrUseq_${DATASET}.bam

	samtools merge -@ 16 BrUseq_${DATASET}_forward_unsorted.bam ${DATASET}_rep1_forward.bam ${DATASET}_rep2_forward.bam ${DATASET}_rep3_forward.bam
	samtools sort -@ 16 -o BrUseq_${DATASET}_forward.bam BrUseq_${DATASET}_forward_unsorted.bam
	rm BrUseq_${DATASET}_forward_unsorted.bam
	samtools index BrUseq_${DATASET}_forward.bam

	samtools merge -@ 16 BrUseq_${DATASET}_reverse_unsorted.bam ${DATASET}_rep1_reverse.bam ${DATASET}_rep2_reverse.bam ${DATASET}_rep3_reverse.bam
	samtools sort -@ 16 -o BrUseq_${DATASET}_reverse.bam BrUseq_${DATASET}_reverse_unsorted.bam
	rm BrUseq_${DATASET}_reverse_unsorted.bam
	samtools index BrUseq_${DATASET}_reverse.bam
done
