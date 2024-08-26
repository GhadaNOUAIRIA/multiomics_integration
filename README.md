# multiomics_integration
Using miRNA, proteomics and metabolomics data and their integration to study disease subclassification and insights in PSC patients.

## 1. These scripts reads the data (csv files) and pre-processes it in preparation for analysis and integration:
metadata_preprocessing.R
miRNA_preprocessing.R
protein_preprocessing.R
metadata_preprocessing.R

## 2. These scripts analyse the data
1. Data exploration for each omics
   data_exploration.Rmd
2. WGCNA network analysis
   WGCNA_multi_omics.Rmd
3. mixOmics DIABLO integration
   mixOmics_multi_omics
4. Enrichment analysis of variables associated to certain clinical traits
   enrichment_analysis.Rmd
