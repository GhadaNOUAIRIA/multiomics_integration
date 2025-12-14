# multiomics_integration

## Overview

This repository contains the scripts used for the integration of **miRNA, proteomics, and metabolomics** data to investigate **disease subclassification and biological insights in patients with Primary Sclerosing Cholangitis (PSC)**.

The workflow includes **data preprocessing**, **exploratory analyses**, **network-based approaches (WGCNA)**, and **multi-omics integration using mixOmics**.

---

## Repository Structure

### 1️⃣ Data preprocessing

These scripts load the raw `.csv` files and perform preprocessing steps to prepare each omics layer and the associated metadata for downstream analyses and multi-omics integration.

* `metadata_preprocessing.R`
* `miRNA_preprocessing.R`
* `protein_preprocessing.R`
* `metabolite_preprocessing.R`

---

### 2️⃣ Data analysis and integration

The following R Markdown files perform exploratory analyses, network analysis, and multi-omics integration.

* `data_exploration.Rmd`
* `WGCNA_multi_omics.Rmd`
* `mixOmics_multi_omics.Rmd`

**Important note**
The files suffixed with `_vf.Rmd` (e.g. `data_exploration_vf.Rmd`, `WGCNA_multi_omics_vf.Rmd`, `mixOmics_multi_omics_vf.Rmd`) correspond to the **corrected and final versions** used for the results reported in the associated manuscript.
The non-`_vf` versions represent **earlier versions prior to final corrections and refinements**.

---

### 3️⃣ Additional / legacy scripts

These scripts are provided for completeness and reproducibility but are **not used in the final analyses** presented in the manuscript.

* `WGCNA_conc.Rmd`
  *Older version of the multi-omics WGCNA approach using concatenated data.*

* `WGCNA_uniomic.Rmd`
  *WGCNA performed separately on each omics layer without concatenation or integration.*

---

## Reproducibility

All analyses were performed in **R**. Package versions, parameters, and methodological details are documented within each script or R Markdown file to ensure reproducibility.

---

## Authors and Affiliation

**Ghada Nouairia**
Annika Bergquist Group
Center for Bioinformatics and Biostatistics
Department of Medicine, Huddinge (MedH)
Karolinska Institutet, Sweden

