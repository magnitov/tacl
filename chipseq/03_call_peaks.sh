# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/tacl/chipseq
BLACKLIST=/DATA/users/magnitov/tacl/genome/hg38-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/peaks

# Call peaks
for SAMPLE in T-mCherry T-MAU2 T-MAU2_Dox
do
	for HISTONE_MARK in H3K27ac H3K4me3
	do
		macs2 callpeak -f BAMPE --gsize=hs --qvalue=0.05 --nomodel --keep-dup all \
			-t ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}.rmdup.sorted.bam\
			--name=${SAMPLE}_${HISTONE_MARK}_merged --outdir=${INPUT_PATH}/peaks \
			2> ${INPUT_PATH}/peaks/macs_${SAMPLE}_${HISTONE_MARK}_merged.log
		for REPLICATE in rep1 rep2
		do
			macs2 callpeak -f BAMPE --gsize=hs --qvalue=0.05 --nomodel --keep-dup all \
				-t ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.rmdup.sorted.bam \
				--name=${SAMPLE}_${HISTONE_MARK}_${REPLICATE} --outdir=${INPUT_PATH}/peaks \
				2> ${INPUT_PATH}/peaks/macs_${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.log
		done
	done
done

for SAMPLE in T-mCherry T-MAU2 T-MAU2_Dox
do
	for HISTONE_MARK in H3K27me3 H3K9me3
	do
		macs2 callpeak -f BAMPE --gsize=hs --broad --broad-cutoff 0.1 --nomodel --keep-dup all \
			-t ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}.rmdup.sorted.bam\
			--name=${SAMPLE}_${HISTONE_MARK}_merged --outdir=${INPUT_PATH}/peaks \
			2> ${INPUT_PATH}/peaks/macs_${SAMPLE}_${HISTONE_MARK}_merged.log
		for REPLICATE in rep1 rep2
		do
			macs2 callpeak -f BAMPE --gsize=hs --broad --broad-cutoff 0.1 --nomodel --keep-dup all \
				-t ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.rmdup.sorted.bam \
				--name=${SAMPLE}_${HISTONE_MARK}_${REPLICATE} --outdir=${INPUT_PATH}/peaks \
				2> ${INPUT_PATH}/peaks/macs_${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.log
		done
	done
done

# Get replicated peaks and remove peaks from blacklisted regions
cd ${INPUT_PATH}/peaks
rm *.xls *_summits.bed

for SAMPLE in T-MAU2 T-MAU2_Dox T-mCherry
do
	for HISTONE_MARK in H3K27ac H3K4me3
	do
		# Remove non-canonical chromosomes
		grep -v -e '^KI' -e '^GL' -e 'chrY' -e 'chrM' -e 'TetO' ${SAMPLE}_${HISTONE_MARK}_rep1_peaks.narrowPeak > ${SAMPLE}_${HISTONE_MARK}_rep1_peaks.canonical.bed
		grep -v -e '^KI' -e '^GL' -e 'chrY' -e 'chrM' -e 'TetO' ${SAMPLE}_${HISTONE_MARK}_rep2_peaks.narrowPeak > ${SAMPLE}_${HISTONE_MARK}_rep2_peaks.canonical.bed
		grep -v -e '^KI' -e '^GL' -e 'chrY' -e 'chrM' -e 'TetO' ${SAMPLE}_${HISTONE_MARK}_merged_peaks.narrowPeak > ${SAMPLE}_${HISTONE_MARK}_merged_peaks.canonical.bed

		# Get replicated peaks set
		bedtools intersect -wo -a ${SAMPLE}_${HISTONE_MARK}_merged_peaks.canonical.bed -b ${SAMPLE}_${HISTONE_MARK}_rep1_peaks.canonical.bed | \
			awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep1.bed
		bedtools intersect -wo -a ${SAMPLE}_${HISTONE_MARK}_merged_peaks.canonical.bed -b ${SAMPLE}_${HISTONE_MARK}_rep2_peaks.canonical.bed | \
			awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep2.bed
		cat overlap_rep1.bed overlap_rep2.bed | sort -k1,1 -k2,2n | uniq -c | awk '{ if ($1>=2) print $2"\t"$3"\t"$4 }' > ${SAMPLE}_${HISTONE_MARK}_peaks.canonical.replicated.bed

		# Remove peaks from blacklisted regions
		bedtools intersect -v -a ${SAMPLE}_${HISTONE_MARK}_peaks.canonical.replicated.bed -b ${BLACKLIST} | \
			awk -v name="$SAMPLE" '{ print $0"\t"name"_peak_"NR }' > ${SAMPLE}_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.bed

		# Remove intermediate files	
		rm overlap_rep*.bed ${SAMPLE}_${HISTONE_MARK}_*_peaks.canonical.bed ${SAMPLE}_${HISTONE_MARK}_peaks.canonical.replicated.bed
	done
done

# Merge all H3K27ac and H3K4me3 peaks for overlap analysis
for HISTONE_MARK in H3K27ac H3K4me3
do
	cat *_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.bed | sort -k1,1 -k2,2n > all_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.bed
	bedtools merge -i all_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.bed > all_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.merged.bed 
	rm all_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.bed
done

# Overlap H3K27ac anf H3K4me3 peaks with TACL domains
for HISTONE_MARK in H3K27ac H3K4me3
do
	bedtools intersect -a all_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.merged.bed -b /DATA/users/magnitov/tacl/4c/TACL_domains_HMM.bed -wa | sort -k1,1 -k2,2n | uniq > all_${HISTONE_MARK}_peaks.tacl_domains.bed
	bedtools intersect -v -a all_${HISTONE_MARK}_peaks.canonical.replicated.no_blacklist.merged.bed -b /DATA/users/magnitov/tacl/4c/TACL_domains_HMM.bed -wa | sort -k1,1 -k2,2n | uniq > all_${HISTONE_MARK}_peaks.not_tacl_domains.bed
done
