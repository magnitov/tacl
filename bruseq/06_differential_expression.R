library(DESeq2)

###
### Note: three samples have failed and were excluded from the differential expression analyses.
### This, however, means that some conditions had 1 or 2 samples to be considered in the test.
###
counts <- as.matrix(read.csv('/DATA/users/magnitov/tacl/bruseq/counts/counts_deseq2.TACL.txt',
                             sep = "\t", row.names = 1))
counts <- counts[, !colnames(counts) %in% c("TmCherry_NT_rep1", "TmCherry_Dox2h_rep1", "TmCherry_Dox2h_rep2")]

samples <- read.csv('/DATA/users/magnitov/tacl/bruseq/counts/samples_deseq2.TACL.txt', 
                    sep = "\t", row.names = 1)
samples <- samples[-c(7, 10, 11), ]
samples$line <- factor(samples$condition)
samples$replicate <- factor(samples$replicate)

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = samples,
                              design = ~ condition)
keep <- rowSums(counts(dds) >= 10) >= 9
dds <- dds[keep,]

vsd <- vst(dds, nsub = 1000)
plotPCA(vsd, intgroup=c("condition", "replicate"), returnData=TRUE)

dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)
dds <- nbinomWaldTest(dds)

res_tmau2_dox_vs_nt <- results(dds, contrast=c("condition","TMAU2_DOX","TMAU2_NT"), alpha = 0.05)
res_tmcherry_dox_vs_nt <- results(dds, contrast=c("condition","TmCherry_DOX","TmCherry_NT"), alpha = 0.05)
res_tmau2_vs_tmcherry <- results(dds, contrast=c("condition","TMAU2_NT","TmCherry_NT"), alpha = 0.05)
write.table(as.data.frame(res_tmau2_dox_vs_nt), file = "/DATA/users/magnitov/tacl/bruseq/degs/degs_TMAU2_DOX_vs_NT_DESeq2_ruiqi.csv")
write.table(as.data.frame(res_tmcherry_dox_vs_nt), file = "/DATA/users/magnitov/tacl/bruseq/degs/degs_TmCherry_DOX_vs_NT_DESeq2_ruiqi.csv")
write.table(as.data.frame(res_tmau2_vs_tmcherry), file = "/DATA/users/magnitov/tacl/bruseq/degs/degs_TMAU2_vs_TmCherry_DESeq2_ruiqi.csv")
