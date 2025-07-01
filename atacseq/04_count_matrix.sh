INPUT_PATH=/DATA/users/magnitov/tacl/atacseq

mkdir -p ${INPUT_PATH}/counts

for SAMPLE in T-MAU2 T-MAU2_Dox T-mCherry T-MAU2_rep1 T-MAU2_rep2 T-MAU2_Dox_rep1 T-MAU2_Dox_rep2 T-mCherry_rep1 T-mCherry_rep2
do
	bedtools intersect -a ${INPUT_PATH}/peaks/all_peaks.canonical.replicated.no_blacklist.merged.bed \
		-b ${INPUT_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam -c -wa > \
		${INPUT_PATH}/counts/${SAMPLE}.peaks_counts.txt
done

paste ${INPUT_PATH}/counts/T-mCherry_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-mCherry_rep2.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_rep2.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_Dox_rep1.peaks_counts.txt ${INPUT_PATH}/counts/T-MAU2_Dox_rep2.peaks_counts.txt | awk '{ print $1"_"$2"_"$3"\t"$4"\t"$8"\t"$12"\t"$16"\t"$20"\t"$24 }' > ${INPUT_PATH}/counts/counts_deseq2.TACL.txt
cd ${INPUT_PATH}/counts
sed -i '1 i\peak_id\tT_mCherry_rep1\tT_mCherry_rep2\tT_MAU2_rep1\tT_MAU2_rep2\tT_MAU2_Dox_rep1\tT_MAU2_Dox_rep2' counts_deseq2.TACL.txt