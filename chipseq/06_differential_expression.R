library(DESeq2)

counts <- as.matrix(read.csv('/DATA/users/magnitov/tacl/chipseq/counts/counts_deseq2.H3K27ac.txt',
                             sep = "\t", row.names = 1))

samples <- read.csv('/DATA/users/magnitov/tacl/chipseq/counts/samples_deseq2.txt', 
                    sep = "\t", row.names = 1)
samples$line <- factor(samples$line)
samples$replicate <- factor(samples$replicate)

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = samples,
                              design = ~ line+replicate)

vsd <- vst(dds, blind=FALSE)
plotPCA(vsd, intgroup=c("line"))

dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

res_tmau2_tmcherry <- results(dds, contrast=c("line","T_MAU2","T_mCherry"), alpha = 0.05)
res_tmau2dox_tmau2 <- results(dds, contrast=c("line","T_MAU2_Dox","T_MAU2"), alpha = 0.05)
res_tmau2dox_tmcherry <- results(dds, contrast=c("line","T_MAU2_Dox","T_mCherry"), alpha = 0.05)

write.table(as.data.frame(res_tmau2_tmcherry), file = "/DATA/users/magnitov/tacl/chipseq/dars/dars_H3K27ac_TMAU2_vs_TmCherry_DESeq2.csv")
write.table(as.data.frame(res_tmau2dox_tmau2), file = "/DATA/users/magnitov/tacl/chipseq/dars/dars_H3K27ac_TMAU2_Dox_vs_TMAU2_DESeq2.csv")
write.table(as.data.frame(res_tmau2dox_tmcherry), file = "/DATA/users/magnitov/tacl/chipseq/dars/dars_H3K27ac_TMAU2_Dox_vs_TmCherry_DESeq2.csv")
