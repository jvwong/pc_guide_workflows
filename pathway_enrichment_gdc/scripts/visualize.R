library("edgeR")

### ============ Declare directories =========
base_dir <- "/home/TCGA"
tcgaov_data_dir <- file.path(base_dir, "data")
tcgaov_output_dir <- file.path(base_dir, "output")

### ============ Declare samples =========
category_baseline <- "Immunoreactive"
category_test <- "Mesenchymal"

tcgaov_dge <- readRDS(file.path(tcgaov_output_dir, "tcgaov_dge.rds"))

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


### ============ Format expression  ===============
### Work with normalized counts per million (CPM)
tcgaov_counts_cpm <- cpm(tcgaov_normalized_tmm, normalized.lib.size=TRUE)

### Merge the DGEList variables 'genes' and 'counts' (as data.frame)
tcgaov_merged <- merge(tcgaov_normalized_tmm$genes,
                      data.frame(tcgaov_counts_cpm, check.names = FALSE),
                      by = "row.names",
                      all = FALSE)

### Data frame: 'external_gene_name', 'ensembl_gene_id' and sample IDs
tcgaov_em_expression <- cbind(tcgaov_merged[,c('external_gene_name',
                                              'ensembl_gene_id')],
                             tcgaov_merged[,-(1:9)])

### Rename columns
colnames(tcgaov_em_expression)[1] <- "NAME"
colnames(tcgaov_em_expression)[2] <- "DESCRIPTION"


### Write
write.table(tcgaov_em_expression,
            file.path(tcgaov_output_dir,
              "MesenchymalvsImmunoreactive_RNAseq_expression.txt"),
            col.name = TRUE,
            sep = "\t",
            row.names = FALSE,
            quote = FALSE)


### ============ Format phenotypes  ===============
### Get the 'Mesenchymal' and 'Immunoreactive'
n_samples <- dim(tcgaov_normalized_tmm)[2]
n_classes <- 2

tcgaov_em_phenotype_file <- file.path(tcgaov_output_dir,
  "MesenchymalvsImmunoreactive_RNAseq_phenotype.cls")

### No. samples, No. classes, 1
cat(paste(n_samples, n_classes, "1", sep = " "),
    file = tcgaov_em_phenotype_file,
    sep = "\n",
    append = FALSE)

### Class label names
cat(paste("#", category_baseline, category_test, sep = " "),
    file = tcgaov_em_phenotype_file,
    sep = "\n",
    append = TRUE)

### Sample class labels
cat(paste(tcgaov_normalized_tmm$samples$group, collapse = "\t"),
    file = tcgaov_em_phenotype_file,
    sep = "\n",
    append = TRUE)
