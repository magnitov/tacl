# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/tacl/chipseq

mkdir -p ${INPUT_PATH}/bigwig

for SAMPLE in T-mCherry T-MAU2 T-MAU2_Dox
do
	for HISTONE_MARK in H3K27ac H3K4me3
	do
		bamCoverage -p 32 -bs 50 --effectiveGenomeSize 2913022398 --normalizeUsing RPGC \
			-b ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}.rmdup.sorted.bam \
			-o ${INPUT_PATH}/bigwig/${SAMPLE}_${HISTONE_MARK}.rpgc.bw
		bamCompare -p 32 -bs 50 --effectiveGenomeSize 2913022398 --operation ratio \
			-b1 ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}.rmdup.sorted.bam \
			-b2 ${INPUT_PATH}/bam/Input_${SAMPLE}.rmdup.sorted.bam \
			-o ${INPUT_PATH}/bigwig/${SAMPLE}_${HISTONE_MARK}.input.bw
		for REPLICATE in rep1 rep2
		do
			bamCoverage -p 32 -bs 50 --effectiveGenomeSize 2913022398 --normalizeUsing RPGC \
				-b ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.rmdup.sorted.bam \
				-o ${INPUT_PATH}/bigwig/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.rpgc.bw
			bamCompare -p 32 -bs 50 --effectiveGenomeSize 2913022398 --operation ratio \
				-b1 ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.rmdup.sorted.bam \
				-b2 ${INPUT_PATH}/bam/Input_${SAMPLE}.rmdup.sorted.bam \
				-o ${INPUT_PATH}/bigwig/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.input.bw
		done
	done
done
