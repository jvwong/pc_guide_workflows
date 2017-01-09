devtools::install_github("jvwong/emFlow")

base_dir <- "/home/TCGA"
output_dir <- file.path(base_dir, "output")

# Retrieve the TCGA-OV RNA-seq data from GDC
tcgaov_se <- emFlow::retrieve_gdc_rnaseq("TCGA-OV",
  c("TCGA-04-1365-01A",
    "TCGA-29-1766-01A",
    "TCGA-09-2051-01A",
    "TCGA-24-1427-10A"))

# Integrate class assignments
# TCGA-OV subtypes (supplied)
pheno_file <- system.file("extdata",
  "Verhaak_JCI_2013_tableS1.txt",
  package = "emFlow")

tcgaov_dge <- emFlow::integrate_classes(
  tcgaov_se,
  "patient",  # d_merge_key
  pheno_file, # pheno_file
  "ID",       # p_merge_key
  "SUBTYPE")  # p_pheno_key

# Save
save(tcgaov_dge, file = file.path(output_dir, "tcgaov_dge.RData"))
