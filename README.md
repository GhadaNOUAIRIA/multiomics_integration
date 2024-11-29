# multiomics_integration
Using miRNA, proteomics and metabolomics data and their integration to study disease subclassification and insights in PSC patients.

## 1. These scripts reads the data (csv files) and pre-processes it in preparation for analysis and integration:
metadata_preprocessing.R  
miRNA_preprocessing.R  
protein_preprocessing.R  
metadata_preprocessing.R  

## 2. These scripts analyse the data

data_exploration.Rmd  
WGCNA_multi_omics.Rmd  
mixOmics_multi_omics.Rmd  
enrichment_analysis.Rmd  

## 3. Extra scripts

WGCNA_conc.Rmd (older version of WGCNA_multi_omics.Rmd)
WGCNA_uniomic.Rmd (using WGCNA on each omic data without concatenation or integration)
