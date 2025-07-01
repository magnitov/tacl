# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/tacl/atacseq
BLACKLIST=/DATA/users/magnitov/tacl/genome/hg38-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/bigwig

for SAMPLE in T-MAU2 T-MAU2_Dox T-mCherry T-MAU2_rep1 T-MAU2_rep2 T-MAU2_Dox_rep1 T-MAU2_Dox_rep2 T-mCherry_rep1 T-mCherry_rep2 
do
	bamCoverage -p 24 -bs 10 -bl ${BLACKLIST} --effectiveGenomeSize 2913022398 --normalizeUsing RPGC \
		-b ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam -o ${INPUT_PATH}/bigwig/${SAMPLE}.rpgc.bw
done
