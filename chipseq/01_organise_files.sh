# !/bin/bash
INPUT_PATH=/DATA/users/magnitov/tacl/chipseq

mkdir -p ${INPUT_PATH}/bam

# Merge H3K27ac ChIP-seq
samtools merge -@ 32 ${INPUT_PATH}/bam/T-mCherry_H3K27ac.bam ${INPUT_PATH}/peter/bam/VER9100_eHAP1_C17_Tmcherry_H3k27ac_rep1_filtered_dedup.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_Tmcherry_H3k27ac_rep2_filtered_dedup.bam
samtools merge -@ 32 ${INPUT_PATH}/bam/T-MAU2_H3K27ac.bam ${INPUT_PATH}/peter/bam/VER9100_eHAP1_C17_TMAU2_H3k27ac_rep1_filtered_dedup.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_H3k27ac_rep2_filtered_dedup.bam
samtools merge -@ 32 ${INPUT_PATH}/bam/T-MAU2_Dox_H3K27ac.bam ${INPUT_PATH}/peter/bam/VER9100_eHAP1_C17_TMAU2_Dox1h_H3k27ac_rep1_filtered_dedup.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_Dox1h_H3k27ac_rep2_filtered_dedup.bam
cp ${INPUT_PATH}/peter/bam/VER9100_eHAP1_C17_Tmcherry_H3k27ac_rep1_filtered_dedup.bam ${INPUT_PATH}/bam/T-mCherry_H3K27ac_rep1.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_Tmcherry_H3k27ac_rep2_filtered_dedup.bam ${INPUT_PATH}/bam/T-mCherry_H3K27ac_rep2.bam
cp ${INPUT_PATH}/peter/bam/VER9100_eHAP1_C17_TMAU2_H3k27ac_rep1_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_H3K27ac_rep1.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_H3k27ac_rep2_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_H3K27ac_rep2.bam
cp ${INPUT_PATH}/peter/bam/VER9100_eHAP1_C17_TMAU2_Dox1h_H3k27ac_rep1_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_Dox_H3K27ac_rep1.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_Dox1h_H3k27ac_rep2_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_Dox_H3K27ac_rep2.bam

# Merge H3K4me3 ChIP-seq
samtools merge -@ 32 ${INPUT_PATH}/bam/T-mCherry_H3K4me3.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_Tmcherry_H3k4me3_rep1_filtered_dedup.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_Tmcherry_H3k4me3_rep2_filtered_dedup.bam
samtools merge -@ 32 ${INPUT_PATH}/bam/T-MAU2_H3K4me3.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_H3k4me3_rep1_filtered_dedup.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_H3k4me3_rep2_filtered_dedup.bam
samtools merge -@ 32 ${INPUT_PATH}/bam/T-MAU2_Dox_H3K4me3.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_Dox1h_H3k4me3_rep1_filtered_dedup.bam ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_Dox1h_H3k4me3_rep2_filtered_dedup.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_Tmcherry_H3k4me3_rep1_filtered_dedup.bam ${INPUT_PATH}/bam/T-mCherry_H3K4me3_rep1.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_Tmcherry_H3k4me3_rep2_filtered_dedup.bam ${INPUT_PATH}/bam/T-mCherry_H3K4me3_rep2.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_H3k4me3_rep1_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_H3K4me3_rep1.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_H3k4me3_rep2_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_H3K4me3_rep2.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_Dox1h_H3k4me3_rep1_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_Dox_H3K4me3_rep1.bam
cp ${INPUT_PATH}/peter/bam/VER9308_TACL_RH_ChIP_seq_eHAP1_C17_TMAU2_Dox1h_H3k4me3_rep2_filtered_dedup.bam ${INPUT_PATH}/bam/T-MAU2_Dox_H3K4me3_rep2.bam

# Copy input files
cp ${INPUT_PATH}/peter/bam/VER7726_TACL_RH_Ehap1_C17_TetR-mcherry_Input_filtered_dedup.bam ${INPUT_PATH}/bam/Input_T-mCherry.bam
cp ${INPUT_PATH}/peter/bam/VER7726_TACL_RH_Ehap1_C17_TetR-hMAU2v2_Input_filtered_dedup.bam ${INPUT_PATH}/bam/Input_T-MAU2.bam
cp ${INPUT_PATH}/peter/bam/VER7726_TACL_RH_Ehap1_C17_TetR-hMAU2v2_Dox_60min_Input_filtered_dedup.bam ${INPUT_PATH}/bam/Input_T-MAU2_Dox.bam

# Sort BAM files
for SAMPLE in T-mCherry_H3K27ac T-mCherry_H3K4me3 T-MAU2_H3K27ac T-MAU2_H3K4me3 T-MAU2_Dox_H3K27ac T-MAU2_Dox_H3K4me3 Input_T-mCherry Input_T-MAU2 Input_T-MAU2_Dox
do
	samtools sort -@ 32 -o ${INPUT_PATH}/bam/${SAMPLE}.rmdup.sorted.bam ${INPUT_PATH}/bam/${SAMPLE}.bam
	samtools index -@ 32 ${INPUT_PATH}/bam/${SAMPLE}.rmdup.sorted.bam
	rm ${INPUT_PATH}/bam/${SAMPLE}.bam
done

for SAMPLE in T-mCherry T-MAU2 T-MAU2_Dox
do
	for HISTONE_MARK in H3K27ac H3K4me3
	do
		for REPLICATE in rep1 rep2
		do
			samtools sort -@ 32 -o ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.rmdup.sorted.bam ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.bam
			samtools index -@ 32 ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.rmdup.sorted.bam
			rm ${INPUT_PATH}/bam/${SAMPLE}_${HISTONE_MARK}_${REPLICATE}.bam
		done
	done
done
