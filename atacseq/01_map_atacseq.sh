DATA_PATH=/DATA/users/magnitov/tacl/atacseq
GENOME_PATH=/DATA/users/magnitov/tacl/genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa
PICARD=/DATA/users/magnitov/software/picard_2.25.6.jar

mkdir -p ${DATA_PATH}/bam
mkdir -p ${DATA_PATH}/stats

for SAMPLE in T-MAU2_rep1_lane1 T-MAU2_rep1_lane2 T-MAU2_rep2_lane1 T-MAU2_rep2_lane2 T-MAU2_Dox_rep1_lane1 T-MAU2_Dox_rep1_lane2 T-MAU2_Dox_rep2_lane1 T-MAU2_Dox_rep2_lane2 T-mCherry_rep1_lane1 T-mCherry_rep1_lane2 T-mCherry_rep2_lane1 T-mCherry_rep2_lane2
do
	# Mapping reads
	bwa mem -t 24 -M ${GENOME_PATH} ${DATA_PATH}/fastqlinks/${SAMPLE}_R1.fastq.gz ${DATA_PATH}/fastqlinks/${SAMPLE}_R2.fastq.gz |\
		awk '{ if ($3!="chrM") print $0 }' |\
		samtools view -@ 16 -h -S -b -f 2 -q 10 |\
		samtools sort -@ 16 - > ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam
done

for SAMPLE in T-MAU2_rep1 T-MAU2_rep2 T-MAU2_Dox_rep1 T-MAU2_Dox_rep2 T-mCherry_rep1 T-mCherry_rep2
do
	# Merge lanes
	samtools merge -@ 24 ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam \
		${DATA_PATH}/bam/${SAMPLE}_lane1.hg38.mapq.proper.sorted.bam ${DATA_PATH}/bam/${SAMPLE}_lane2.hg38.mapq.proper.sorted.bam
	num_pairs_lane1=`zcat ${DATA_PATH}/fastqlinks/${SAMPLE}_lane1_R1.fastq.gz | wc -l | awk '{print $0/4}'`
	num_pairs_lane2=`zcat ${DATA_PATH}/fastqlinks/${SAMPLE}_lane2_R1.fastq.gz | wc -l | awk '{print $0/4}'`
	num_mapq=`samtools view ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam | wc -l | awk '{print $0/2}'`
    
	# Mark duplicated read pairs
	java -jar ${PICARD} MarkDuplicates REMOVE_DUPLICATES= true \
		I=${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam \
		O=${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		M=${DATA_PATH}/bam/${SAMPLE}_dedupMetrics.txt
	num_mapq_nodups=`samtools view ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam | wc -l | awk '{print $0/2}'`
    
	# Remove intermediate files
	rm ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.bam 
	rm ${DATA_PATH}/bam/${SAMPLE}_lane1.hg38.mapq.proper.sorted.bam ${DATA_PATH}/bam/${SAMPLE}_lane2.hg38.mapq.proper.sorted.bam
    
	#Counting statistics
	mv ${DATA_PATH}/bam/${SAMPLE}_dedupMetrics.txt ${DATA_PATH}/stats/${SAMPLE}_dedupMetrics.txt
	samtools index -@ 24 ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam
	echo "$SAMPLE processing statistics:" > ${DATA_PATH}/stats/${SAMPLE}_processing_stats.txt
	echo "$num_pairs_lane1 read pairs lane1" >> ${DATA_PATH}/stats/${SAMPLE}_processing_stats.txt
	echo "$num_pairs_lane2 read pairs lane2" >> ${DATA_PATH}/stats/${SAMPLE}_processing_stats.txt
	echo "$num_mapq read pairs mapped (not chrM, proper pairs, MAPQ>=10)" >> ${DATA_PATH}/stats/${SAMPLE}_processing_stats.txt
	echo "$num_mapq_nodups read pairs are not duplicated" >> ${DATA_PATH}/stats/${SAMPLE}_processing_stats.txt
done

for SAMPLE in T-MAU2 T-MAU2_Dox T-mCherry
do
	# Merge replicates
	samtools merge -@ 24 ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam \
		${DATA_PATH}/bam/${SAMPLE}_rep1.hg38.mapq.proper.sorted.rmdup.bam ${DATA_PATH}/bam/${SAMPLE}_rep2.hg38.mapq.proper.sorted.rmdup.bam
	samtools index -@ 24 ${DATA_PATH}/bam/${SAMPLE}.hg38.mapq.proper.sorted.rmdup.bam
done