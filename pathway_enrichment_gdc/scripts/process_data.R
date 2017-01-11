rm(list=ls(all=TRUE))


### ============ Install packages from Bioconductor ========
library("edgeR")

### ============ Declare directories =========
base_dir <- "/home/TCGA"
tcgaov_output_dir <- file.path(base_dir, "output")

### ============ Declare samples =========
category_baseline <- "Immunoreactive"
category_test<- "Mesenchymal"

load(file.path(tcgaov_output_dir, "tcgaov_dge.RData"))


### ============ 1. Filter ===============
index_baseline <- tcgaov_dge$samples$group == category_baseline
index_test <- tcgaov_dge$samples$group == category_test
index_baseline_test <- which(index_baseline | index_test)
tcgaov_dge_bt <- tcgaov_dge[,index_baseline_test]

row_with_mincount <-
  rowSums(cpm(tcgaov_dge_bt) > 10) >= min(sum(index_baseline), sum(index_test))
tcgaov_filtered <- tcgaov_dge_bt[row_with_mincount, , keep.lib.sizes=FALSE]


### ============ 2. Normalize ===============
tcgaov_normalized_tmm <- calcNormFactors(tcgaov_filtered, method = "TMM")


### ============ 3. Fit ===============
tcgaov_fitted_commondisp <- estimateCommonDisp(tcgaov_normalized_tmm)
tcgaov_fitted_tagwise <- estimateTagwiseDisp(tcgaov_fitted_commondisp)

###  Plotting BCV
plotBCV(tcgaov_fitted_tagwise)
plotMeanVar(tcgaov_fitted_tagwise, show.tagwise.vars=TRUE, NBline = TRUE)

### ============ 4. Test ===============
tcgaov_de <- exactTest(tcgaov_fitted_tagwise,
                      pair = c(category_baseline, category_test))


### ============ 5. Adjust ===============
tcgaov_tt <- topTags(tcgaov_de,
                     n = nrow(tcgaov_filtered),
                     adjust.method = "BH",
                     sort.by = "PValue")

###  Plotting
rn <- rownames(tcgaov_tt$table)
deg <- rn[tcgaov_tt$table$FDR<0.05]
plotSmear(tcgaov_filtered, pair=c(category_baseline, category_test), de.tags=deg)


### ============ 6. Rank ===============
tcgaov_ranks <- sign(tcgaov_tt$table$logFC) * (-1) * log10(tcgaov_tt$table$PValue)
genenames <- tcgaov_tt$table$external_gene_name
tcgaov_ranks <- data.frame(gene=genenames, rank=tcgaov_ranks)
tcgaov_ordered_ranks <- tcgaov_ranks[order(tcgaov_ranks[,2], decreasing = TRUE),]


## Save to file as tab-delimited text
write.table(tcgaov_ordered_ranks,
            file.path(tcgaov_output_dir,
              "MesenchymalvsImmunoreactive_edger_ranks.rnk"),
            col.name = TRUE,
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)
