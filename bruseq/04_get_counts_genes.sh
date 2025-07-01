# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/tacl/bruseq
GENE_ANNOTATION=/DATA/users/magnitov/tacl/genome/gencode.v44.annotation.gtf

mkdir -p ${INPUT_DIR}/counts
cd ${INPUT_DIR}/bam/

htseq-count -f bam --stranded no --nonunique all --order pos --type gene \
	T-MAU2_NT_rep1_forward.bam T-MAU2_NT_rep2_forward.bam T-MAU2_NT_rep3_forward.bam \
	T-MAU2_Dox2h_rep1_forward.bam T-MAU2_Dox2h_rep2_forward.bam T-MAU2_Dox2h_rep3_forward.bam \
	T-mCherry_NT_rep1_forward.bam T-mCherry_NT_rep2_forward.bam T-mCherry_NT_rep3_forward.bam \
	T-mCherry_Dox2h_rep1_forward.bam T-mCherry_Dox2h_rep2_forward.bam T-mCherry_Dox2h_rep3_forward.bam \
	${GENE_ANNOTATION} > ${INPUT_DIR}/counts/counts_forward.TACL_BrUseq.txt
htseq-count -f bam --stranded no --nonunique all --order pos --type gene \
	T-MAU2_NT_rep1_reverse.bam T-MAU2_NT_rep2_reverse.bam T-MAU2_NT_rep3_reverse.bam \
	T-MAU2_Dox2h_rep1_reverse.bam T-MAU2_Dox2h_rep2_reverse.bam T-MAU2_Dox2h_rep3_reverse.bam \
	T-mCherry_NT_rep1_reverse.bam T-mCherry_NT_rep2_reverse.bam T-mCherry_NT_rep3_reverse.bam \
	T-mCherry_Dox2h_rep1_reverse.bam T-mCherry_Dox2h_rep2_reverse.bam T-mCherry_Dox2h_rep3_reverse.bam \
	${GENE_ANNOTATION} > ${INPUT_DIR}/counts/counts_reverse.TACL_BrUseq.txt

cd ../counts/
sed -i '1 i\gene_id\tT-MAU2_NT_rep1\tT-MAU2_NT_rep2\tT-MAU2_NT_rep3\tT-MAU2_Dox2h_rep1\tT-MAU2_Dox2h_rep2\tT-MAU2_Dox2h_rep3\tT-mCherry_NT_rep1\tT-mCherry_NT_rep2\tT-mCherry_NT_rep3\tT-mCherry_Dox2h_rep1\tT-mCherry_Dox2h_rep2\tT-mCherry_Dox2h_rep3' counts_deseq2.TACL.txt


