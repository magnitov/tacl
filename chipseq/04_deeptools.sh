# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/tacl/chipseq
BLACKLIST=/DATA/users/magnitov/tacl/genome/hg38-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/piles

computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -a 2000 -b 2000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/bigwig/T-mCherry_H3K27ac.rpgc.bw ${INPUT_PATH}/bigwig/T-MAU2_H3K27ac.rpgc.bw \
	-R ${INPUT_PATH}/peaks/H3K27ac_peaks.tacl_domains.enhancer.bed ${INPUT_PATH}/peaks/H3K27ac_peaks.other.enhancer.bed \
	-o ${INPUT_PATH}/piles/ChIPseq_H3K27ac_signal_enhancers.gz

plotProfile -m ${INPUT_PATH}/piles/ChIPseq_H3K27ac_signal_enhancers.gz -out ${INPUT_PATH}/piles/h3k27ac_signal_enhancers.pdf \
	--yMin 0 --yMax 60 --legendLocation upper-right \
	--regionsLabel "TACL (N=877)" "Other (N=33951)" --refPointLabel "" \
	--samplesLabel T-mCherry T-MAU2 \
	--plotWidth 6
    
computeMatrix reference-point -p 32 -bl ${BLACKLIST} --referencePoint center -a 2000 -b 2000 --missingDataAsZero --skipZeros \
	-S ${INPUT_PATH}/bigwig/T-mCherry_H3K27ac.rpgc.bw ${INPUT_PATH}/bigwig/T-MAU2_H3K27ac.rpgc.bw \
	-R ${INPUT_PATH}/peaks/H3K27ac_peaks.tacl_domains.promoter.bed ${INPUT_PATH}/peaks/H3K27ac_peaks.other.promoter.bed \
	-o ${INPUT_PATH}/piles/ChIPseq_H3K27ac_signal_promoters.gz

plotProfile -m ${INPUT_PATH}/piles/ChIPseq_H3K27ac_signal_promoters.gz -out ${INPUT_PATH}/piles/h3k27ac_signal_promoters.pdf \
	--yMin 0 --yMax 60 --legendLocation upper-right \
	--regionsLabel "TACL (N=263)" "Other (N=15444)" --refPointLabel "" \
	--samplesLabel T-mCherry T-MAU2 \
	--plotWidth 6
