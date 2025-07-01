# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/tacl/bruseq
GENOME_DIR=/DATA/users/magnitov/tacl/genome
STAR=/DATA/users/magnitov/software/STAR-2.7.9a/bin/Linux_x86_64/STAR
PICARD=/DATA/users/magnitov/software/picard_2.25.6.jar

mkdir -p ${GENOME_DIR}/hg38_STARgenome
${STAR} --runMode genomeGenerate --runThreadN 16 --genomeDir ${GENOME_DIR}/hg38_STARgenome \
	--genomeFastaFiles ${GENOME_DIR}/Homo_sapiens.GRCh38.dna.primary_assembly.fa --sjdbGTFfile ${GENOME_DIR}/gencode.v44.annotation.gtf

mkdir -p ${INPUT_DIR}/bam
mkdir -p ${INPUT_DIR}/stats

for SAMPLE in T-MAU2_NT_rep1 T-MAU2_NT_rep2 T-MAU2_NT_rep3 T-MAU2_Dox2h_rep1 T-MAU2_Dox2h_rep2 T-MAU2_Dox2h_rep3 T-mCherry_NT_rep1 T-mCherry_NT_rep2 T-mCherry_NT_rep3 T-mCherry_Dox2h_rep1 T-mCherry_Dox2h_rep2 T-mCherry_Dox2h_rep3
do
	echo "Mapping reads"
	${STAR} --runThreadN 24 --outSAMtype BAM SortedByCoordinate --readFilesCommand zcat --quantMode GeneCounts \
		--genomeDir ${GENOME_DIR}/hg38_STARgenome --outFileNamePrefix ${INPUT_DIR}/bam/${SAMPLE}_ \
		--readFilesIn ${INPUT_DIR}/fastqlinks/${SAMPLE}.fastq.gz
	rm ${INPUT_DIR}/bam/${SAMPLE}_Log.out ${INPUT_DIR}/bam/${SAMPLE}_Log.progress.out
	rm ${INPUT_DIR}/bam/${SAMPLE}_SJ.out.tab  ${INPUT_DIR}/bam/${SAMPLE}_ReadsPerGene.out.tab
	num_pairs=`zcat ${INPUT_DIR}/fastqlinks/${SAMPLE}.fastq.gz | wc -l | awk '{print $0/4}'`

	echo "Filtering mapped pairs by MAPQ"
	samtools view -@ 24 -h -S -b -q 10 -o ${INPUT_DIR}/bam/${SAMPLE}_mapq.bam \
		${INPUT_DIR}/bam/${SAMPLE}_Aligned.sortedByCoord.out.bam
	num_mapq=`samtools view ${INPUT_DIR}/bam/${SAMPLE}_mapq.bam | wc -l | awk '{print $0}'`
	rm ${INPUT_DIR}/bam/${SAMPLE}_Aligned.sortedByCoord.out.bam

	echo "Cleaning files"
	mv ${INPUT_DIR}/bam/${SAMPLE}_mapq.bam ${INPUT_DIR}/bam/${SAMPLE}.bam
	samtools index -@ 24 ${INPUT_DIR}/bam/${SAMPLE}.bam
	mv ${INPUT_DIR}/bam/${SAMPLE}_Log.final.out ${INPUT_DIR}/stats/${SAMPLE}_Log.final.out

	echo "Counting statistics"
	echo "$SAMPLE processing statistics:" > ${INPUT_DIR}/stats/${SAMPLE}_processing_stats.txt
	echo "$num_pairs read pairs" >> ${INPUT_DIR}/stats/${SAMPLE}_processing_stats.txt
	echo "$num_mapq read pairs mapped with MAPQ>=10" >> ${INPUT_DIR}/stats/${SAMPLE}_processing_stats.txt
done
