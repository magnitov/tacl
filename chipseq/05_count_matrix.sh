INPUT_PATH=/DATA/users/magnitov/tacl/chipseq

mkdir -p ${INPUT_PATH}/counts

### H3K27ac peaks
for SAMPLE in T-MAU2_H3K27ac_rep1 T-MAU2_H3K27ac_rep2 T-MAU2_Dox_H3K27ac_rep1 T-MAU2_Dox_H3K27ac_rep2 T-mCherry_H3K27ac_rep1 T-mCherry_H3K27ac_rep2
do
	bedtools intersect -a ${INPUT_PATH}/peaks/all_H3K27ac_peaks.canonical.replicated.no_blacklist.merged.bed \
		-b ${INPUT_PATH}/bam/${SAMPLE}.rmdup.sorted.bam -c -wa > \
		${INPUT_PATH}/counts/${SAMPLE}.peaks_counts.txt
done
paste ${INPUT_PATH}/counts/T-mCherry_H3K27ac_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-mCherry_H3K27ac_rep2.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_H3K27ac_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_H3K27ac_rep2.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_Dox_H3K27ac_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_Dox_H3K27ac_rep2.peaks_counts.txt | awk '{ print $1"_"$2"_"$3"\t"$4"\t"$8"\t"$12"\t"$16"\t"$20"\t"$24 }' > ${INPUT_PATH}/counts/counts_deseq2.H3K27ac.txt
cd ${INPUT_PATH}/counts
sed -i '1 i\peak_id\tT_mCherry_rep1\tT_mCherry_rep2\tT_MAU2_rep1\tT_MAU2_rep2\tT_MAU2_Dox_rep1\tT_MAU2_Dox_rep2' counts_deseq2.H3K27ac.txt

### H3K4me3
for SAMPLE in T-MAU2_H3K4me3_rep1 T-MAU2_H3K4me3_rep2 T-MAU2_Dox_H3K4me3_rep1 T-MAU2_Dox_H3K4me3_rep2 T-mCherry_H3K4me3_rep1 T-mCherry_H3K4me3_rep2
do
	bedtools intersect -a ${INPUT_PATH}/peaks/all_H3K4me3_peaks.canonical.replicated.no_blacklist.merged.bed \
		-b ${INPUT_PATH}/bam/${SAMPLE}.rmdup.sorted.bam -c -wa > \
		${INPUT_PATH}/counts/${SAMPLE}.peaks_counts.txt
done
paste ${INPUT_PATH}/counts/T-mCherry_H3K4me3_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-mCherry_H3K4me3_rep2.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_H3K4me3_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_H3K4me3_rep2.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_Dox_H3K4me3_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_Dox_H3K4me3_rep2.peaks_counts.txt | awk '{ print $1"_"$2"_"$3"\t"$4"\t"$8"\t"$12"\t"$16"\t"$20"\t"$24 }' > ${INPUT_PATH}/counts/counts_deseq2.H3K4me3.txt
cd ${INPUT_PATH}/counts
sed -i '1 i\peak_id\tT_mCherry_rep1\tT_mCherry_rep2\tT_MAU2_rep1\tT_MAU2_rep2\tT_MAU2_Dox_rep1\tT_MAU2_Dox_rep2' counts_deseq2.H3K4me3.txt

