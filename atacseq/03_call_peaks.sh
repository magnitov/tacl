# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/tacl/atacseq
BLACKLIST=/DATA/users/magnitov/tacl/genome/hg38-blacklist.v2.bed

mkdir -p ${INPUT_PATH}/peaks

# Call peaks
for SAMPLE in T-MAU2 T-MAU2_Dox T-mCherry
do
	# Peaks in merged
	macs2 callpeak -f BAMPE --gsize=hs --qvalue=0.05 --nomodel --keep-dup all \
		-t ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		--name=${SAMPLE}_merged --outdir=${INPUT_PATH}/peaks \
		2> ${INPUT_PATH}/peaks/macs_${SAMPLE}_merged.log
        
#	# Peaks in replicates
	for REPLICATE in rep1 rep2
	do
		macs2 callpeak -f BAMPE --gsize=hs --qvalue=0.05 --nomodel --keep-dup all \
			-t ${INPUT_PATH}/bam/${SAMPLE}_${REPLICATE}.hg38.mapq.proper.sorted.rmdup.bam \
			--name=${SAMPLE}_${REPLICATE} --outdir=${INPUT_PATH}/peaks \
			2> ${INPUT_PATH}/peaks/macs_${SAMPLE}_${REPLICATE}.log
	done
done

# Get replicated peaks and remove peaks from blacklisted regions
cd ${INPUT_PATH}/peaks
rm *.xls *_summits.bed

for SAMPLE in T-MAU2 T-MAU2_Dox T-mCherry
do
	# Remove non-canonical chromosomes
	grep -v -e '^KI' -e '^GL' -e 'chrY' -e 'chrM' ${SAMPLE}_rep1_peaks.narrowPeak > ${SAMPLE}_rep1_peaks.canonical.bed
	grep -v -e '^KI' -e '^GL' -e 'chrY' -e 'chrM' ${SAMPLE}_rep2_peaks.narrowPeak > ${SAMPLE}_rep2_peaks.canonical.bed
	grep -v -e '^KI' -e '^GL' -e 'chrY' -e 'chrM' ${SAMPLE}_merged_peaks.narrowPeak > ${SAMPLE}_merged_peaks.canonical.bed

	# Get replicated peaks set
	bedtools intersect -wo -a ${SAMPLE}_merged_peaks.canonical.bed -b ${SAMPLE}_rep1_peaks.canonical.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep1.bed
	bedtools intersect -wo -a ${SAMPLE}_merged_peaks.canonical.bed -b ${SAMPLE}_rep2_peaks.canonical.bed | awk 'BEGIN{FS="\t";OFS="\t"}{s1=$3-$2; s2=$13-$12; if (($21/s1 >= 0.5) || ($21/s2 >= 0.5)) {print $0}}' | cut -f 1-4 | sort -k1,1 -k2,2n | uniq > overlap_rep2.bed              
	cat overlap_rep1.bed overlap_rep2.bed | sort -k1,1 -k2,2n | uniq -c | awk '{ if ($1>=2) print $2"\t"$3"\t"$4 }' > ${SAMPLE}_peaks.canonical.replicated.bed

	# Remove peaks from blacklisted regions
	bedtools intersect -v -a ${SAMPLE}_peaks.canonical.replicated.bed -b ${BLACKLIST} | awk -v name="$SAMPLE" '{ print $0"\t"name"_peak_"NR }' > ${SAMPLE}_peaks.canonical.replicated.no_blacklist.bed
	
	# Remove intermediate files	
	rm overlap_rep*.bed ${SAMPLE}_*_peaks.canonical.bed ${SAMPLE}_peaks.canonical.replicated.bed
done

# Merge all peaks for overlap analysis
cat *_peaks.canonical.replicated.no_blacklist.bed | sort -k1,1 -k2,2n > all_peaks.canonical.replicated.no_blacklist.bed
bedtools merge -i all_peaks.canonical.replicated.no_blacklist.bed > all_peaks.canonical.replicated.no_blacklist.merged.bed 
rm all_peaks.canonical.replicated.no_blacklist.bed

# Overlap with TACL domains
bedtools intersect -a all_peaks.canonical.replicated.no_blacklist.merged.bed -b /DATA/users/magnitov/tacl/4c/TACL_domains_HMM.bed -wa | sort -k1,1 -k2,2n | uniq > all_peaks.tacl_domains.bed
bedtools intersect -v -a all_peaks.canonical.replicated.no_blacklist.merged.bed -b /DATA/users/magnitov/tacl/4c/TACL_domains_HMM.bed -wa | sort -k1,1 -k2,2n | uniq > all_peaks.not_tacl_domains.bed
