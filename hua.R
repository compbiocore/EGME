library(Rsubread)
#miRNAcsv <- read.csv ("D:/Brown Coursework/EGME/Hua et al/GSE110190_miRNA_normalized_expression.csv")
#miRNAcsv
#names(miRNA)
#dim(miRNA)
#head(miRNA)
library(limma)
library(edgeR)
library(Glimma)
library(gplots)
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("org.Mm.eg.db")
library(org.Mm.eg.db)
library(RColorBrewer)
library(readr)
library(DESeq2)
library(SummarizedExperiment)
install.packages("tidyverse")
install.packages("ggplot2")
library(ggplot2)
library(tidyverse)



#Import CSV file as table
#miRNA <- read_delim("GSE110190_miRNA_normalized_expression.csv", "\t", escape_double = FALSE, trim_ws = TRUE)
#View(miRNA)



#read in delimited text files without considering first column 
miRNA_count <- read.delim(file.choose(), row.names=1)
data.matrix(miRNA_count, rownames.force = NA)

miRNA_count
myCPM <- cpm(miRNA_count)
myCPM
dim(myCPM)
thresh <- myCPM > 0.5
thresh
table(rowSums(thresh))
keep <- rowSums(thresh) >= 2
counts.keep <- miRNA_count[keep,]
summary(keep)
dim(counts.keep)
final_counts <- counts.keep 
summary(final_counts)
dim(final_counts)





#data.matrix(final_counts, rownames.force = NA)
#num <- as.numeric(unlist(final_counts))
#sapply (final_counts, class)
#str(final_counts)
#metadata <- read.delim("metadata.csv", "\t", escape_double = FALSE, trim_ws = TRUE)
#metadata <- read.delim(file.choose(), row.names=1)



#upload metadata directly from files
metadata
dim(metadata)


new_se <- SummarizedExperiment(assays = final_counts,colData = metadata)
new_se
nrow(new_se)

#assayNames(final_counts)
#colData(final_counts)
#all(is.numeric(final_counts))

#dds <- DESeqDataSet(new_se, design = ~ Group)
dds <- DESeqDataSetFromMatrix(final_counts,metadata, design = ~Group)
#?DESeqDataSet
levels(colData(dds)$Group)
nrow(dds)

dds <- dds[ rowSums(counts(dds)) > 1, ]
dds.original <- dds
head(counts(dds.original))
nrow(dds)


design(dds)
dds <- DESeq(dds)
res <- results( dds )
res

res_HvsL <- results( dds, contrast = c("Group", "H-GQE", "L-GQE") )
res_HvsL

#res_LvsH <- results( dds, contrast = c("Group", "L-GQE", "H-GQE") )
#res_LvsH


#sort and filter by adjusted p value or log2 Fold Change
res_sig <- subset(res_HvsL, padj< 0.6)
res_sig
res_pvalue <- subset(res_sig, pvalue< 0.05)
res_pvalue
res_baseMean <- subset(res_pvalue, baseMean> 493)
res_baseMean
#res_lfc <- subset(res_sig, abs(log2FoldChange) > 0.0) 
#head(res_lfc)
#res_lfc
#?subset
#genes_5 <- order(res_baseMean$log2FoldChange, decreasing=TRUE)[1:5]
#genes_5
genes_decreasing_HvsL <- order(res_HvsL$log2FoldChange, decreasing=TRUE)
genes_decreasing_HvsL



write.csv(res_HvsL,"D:/Brown Coursework/EGME/Hua et al/res_HvsL.csv", row.names = FALSE)

write.csv(miRNA,"D:/Brown Coursework/EGME/Hua et al/miRNA.csv", row.names = FALSE)



#Subsetting 5 genes
#res_HvsL_names
#dds5 <- res_HvsL_names[which(res_HvsL_names$miR_name== | "hsa-miR-132-3p")]
#dds5
#head(dds5)
#res_HvsL



#PCA plot
library(vsn)
rld <- rlog(dds, blind = FALSE)
head(rld)
plotPCA(rld, intgroup = c("Group"))
pcaData <- plotPCA(rld, intgroup = c("Group"), returnData = TRUE)
pcaData
percentVar <- round(100 * attr(pcaData, "percentVar"))


#Using ggplot
ggplot(pcaData, aes(x = PC1, y = PC2, color = Group)) +
  geom_point(size =3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  coord_fixed()











#row_index <- which(rownames(res_sig)==$list_of_genes)
#rld[row_index,]




















#Visualisation
plotMA(res)
#Plotting individual genes
plotCounts(dds, gene=which.min(res$padj), intgroup="Group")
plotCounts(dds, gene=which.min(res$pvalue), intgroup="Group")
#plotMA(res, ylim=c(-5,5))




#Normalization & Transformation
#vsd <- vst (dds, nsub=nrow(dds))


#heatmap 
#install.packages("pheatmap")
#library(pheatmap)
#genes <- order(res_lfc$log2FoldChange, decreasing=TRUE)[1:5]




# SmallestPvalue
idx <- which.min(res$pvalue)
counts(dds)[idx, ]



#Normalization
counts(dds, normalized=TRUE)[ idx, ]



#Save result table
resOHT <- res
#Other comparisons
res <- results( dds, contrast = c("Group", "H-GQE", "L-GQE") )
res



coldata <- colnames(final_counts)
coldata


#colSums(final_counts)
#colData(final_counts)

#plot(myCPM[,1],miRNA_count[,1])
#plot(myCPM[,1],miRNA_count[,1],ylim=c(0,50),xlim=c(0,3))
#abline(v=0.5)
#dgeObj <- DGEList(counts.keep)
#dgeObj
#names(dgeObj)
#dgeObj$samples
#dgeObj$samples$lib.size
#barplot(dgeObj$samples$lib.size, names=colnames(dgeObj), las=2)
#title("Barplot of library sizes")
#logcounts <- cpm(dgeObj,log=TRUE)
#logcounts
#boxplot(logcounts, xlab="", ylab="Log2 counts per million",las=2)
#abline(h=median(logcounts),col="blue")
#title("Boxplots of logCPMs (unnormalised)")
#MDS
#plotMDS(dgeObj)
