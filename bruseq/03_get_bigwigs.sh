# !/bin/bash
INPUT_DIR=/DATA/users/magnitov/tacl/bruseq

mkdir -p ${INPUT_DIR}/bigwig

SCALEFACTOR_TMAU2_NT_rep1=1.17562927557
SCALEFACTOR_TMAU2_NT_rep2=1.6433276851
SCALEFACTOR_TMAU2_NT_rep3=1.09261162727

SCALEFACTOR_TMAU2_DOX_2H_rep1=1.76203076946
SCALEFACTOR_TMAU2_DOX_2H_rep2=1.46718924557
SCALEFACTOR_TMAU2_DOX_2H_rep3=1

SCALEFACTOR_TMCHERRY_NT_rep1=2.59535040435
SCALEFACTOR_TMCHERRY_NT_rep2=1.14591948255
SCALEFACTOR_TMCHERRY_NT_rep3=1.01836758744

SCALEFACTOR_TMCHERRY_DOX_2H_rep1=4.74539500982
SCALEFACTOR_TMCHERRY_DOX_2H_rep2=3.67247715443
SCALEFACTOR_TMCHERRY_DOX_2H_rep3=1.85264374181

SCALEFACTOR_TMAU2_NT=1
SCALEFACTOR_TMAU2_DOX_2H=1.05569583168
SCALEFACTOR_TMCHERRY_NT=1.0600189137
SCALEFACTOR_TMCHERRY_DOX_2H=2.32144918389

bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-MAU2_NT.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-MAU2_NT.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-MAU2_NT_forward.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-MAU2_NT_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-MAU2_NT_reverse.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-MAU2_NT_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-MAU2_Dox2h.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-MAU2_Dox2h.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-MAU2_Dox2h_forward.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-MAU2_Dox2h_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-MAU2_Dox2h_reverse.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-MAU2_Dox2h_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-mCherry_NT.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-mCherry_NT.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-mCherry_NT_forward.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-mCherry_NT_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-mCherry_NT_reverse.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-mCherry_NT_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-mCherry_Dox2h.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-mCherry_Dox2h.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-mCherry_Dox2h_forward.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-mCherry_Dox2h_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H -p 24 -b ${INPUT_DIR}/bam/BrUseq_T-mCherry_Dox2h_reverse.bam -o ${INPUT_DIR}/bigwig/BrUseq_T-mCherry_Dox2h_reverse.bw


bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep1 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep1.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep1.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep1 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep1_forward.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep1_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep1 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep1_reverse.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep1_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep2 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep2.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep2.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep2 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep2_forward.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep2_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep2 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep2_reverse.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep2_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep3 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep3.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep3.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep3 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep3_forward.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep3_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_NT_rep3 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_NT_rep3_reverse.bam -o ${INPUT_DIR}/bigwig/T-MAU2_NT_rep3_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep1 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep1.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep1.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep1 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep1_forward.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep1_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep1 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep1_reverse.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep1_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep2 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep2.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep2.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep2 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep2_forward.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep2_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep2 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep2_reverse.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep2_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep3 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep3.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep3.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep3 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep3_forward.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep3_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_NT_rep3 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_NT_rep3_reverse.bam -o ${INPUT_DIR}/bigwig/T-mCherry_NT_rep3_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep1 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep1.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep1.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep1 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep1_forward.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep1_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep1 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep1_reverse.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep1_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep2 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep2.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep2.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep2 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep2_forward.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep2_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep2 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep2_reverse.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep2_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep3 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep3.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep3.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep3 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep3_forward.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep3_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMAU2_DOX_2H_rep3 -p 24 -b ${INPUT_DIR}/bam/T-MAU2_Dox2h_rep3_reverse.bam -o ${INPUT_DIR}/bigwig/T-MAU2_Dox2h_rep3_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep1 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep1.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep1.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep1 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep1_forward.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep1_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep1 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep1_reverse.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep1_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep2 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep2.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep2.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep2 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep2_forward.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep2_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep2 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep2_reverse.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep2_reverse.bw

bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep3 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep3.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep3.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep3 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep3_forward.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep3_forward.bw
bamCoverage --scaleFactor $SCALEFACTOR_TMCHERRY_DOX_2H_rep3 -p 24 -b ${INPUT_DIR}/bam/T-mCherry_Dox2h_rep3_reverse.bam -o ${INPUT_DIR}/bigwig/T-mCherry_Dox2h_rep3_reverse.bw
