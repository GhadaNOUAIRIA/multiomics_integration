#! usr/R

# This script prepares the metadata for PSC multi-omics project
# Input: raw metadata (csv)
# Ouput: cleaned metadata (csv)

# Read the libraries
library(tidyverse)

# Read the data
metadata <- read_csv(file = "data/metadata_patients.csv")

# Clean the data
## Defining a patient_id column
## Defining binary columns for sex (0 = M, 1 = F), cca and ibd (0 = no, 1 = yes), fibrosis, alp, bilirubin
### fibrosis_binary (0: 1-2, 1: 3-4)
### alp_binary (0: <2.85, 1: >=2.85)
### bilirubin_binary (0: <20, 1: =20)
## Cleaning the columns crohn_or_uc, crp
## Defining categories for the columns bmi and age
## !To do: auto_anb, alat
metadata <- metadata %>% 
  rownames_to_column(var = "patient_id") %>% 
  mutate(
    patient_id = as.numeric(patient_id), 
    cca_binary = case_when(
      cca %in% c("x", "X") ~ 0,
      nchar(cca) == 8 ~ 1,
      .default = NA),
    ibd_binary = case_when(
      crohn_or_uc %in% c("ej IBD", "N") ~ 0,
      crohn_or_uc %in% c("UC", "Crohns", "CROHNS") ~ 1,
      .default = NA),
    fibrosis_binary = case_when(
      fibrosis %in% c("1", "2", "1-2") ~ 0,
      fibrosis %in% c("3", "4") ~ 1,
      .default = NA),
    sex_binary = case_when(
      sex == "M" ~ 0,
      sex == "F" ~ 1,
      sex == NA ~ NA),
    alp_binary = case_when(
      alp < 2.85 ~ 0,
      alp >= 2.85 ~ 1,
      .default = NA),
    bilirubin_binary = case_when(   
      bilirubin <= 20 ~ 0, # Bilirubin == 20 as low
      bilirubin > 20 ~ 1,
      .default = NA),
    across('crohn_or_uc', str_replace, 'ej IBD', 'N'), 
    across('crohn_or_uc', str_replace, 'Crohns', 'CROHNS'), 
    across('crp', str_replace, '<', ''), 
    crp = as.numeric(crp), 
    bmi = as.numeric(bmi), 
    bmi_cat = cut(
      bmi, 
      breaks = c(0, 18, 25, 30, 35, 90), 
      labels = c("<18", "18-25", "25-30", "30-35", ">35")),  
    age_cat = cut(
      age, 
      breaks = c(0, 20, 30, 40, 50, 60, 70, 80, 100), 
      labels = c("<20", "20-30", "30-40", "40-50", "50-60", "60-70", "70-80", ">80"))
    ) %>% 
  separate_wider_delim(
      IgG_IgA_level, 
      delim = "/", 
      names = c("IgG", "IgA"), 
      too_few = "align_start", 
      cols_remove = FALSE
    ) %>% 
  mutate(
    IgG = case_when(
      IgG == "ND" ~ NA, 
      IgG != "ND" ~ IgG
    ), 
    IgA = case_when(
      IgA == "ND" ~ NA, 
      IgA != "ND" ~ IgA
    ), 
    IgG = as.numeric(str_replace(IgG, ",", ".")), 
    IgA = as.numeric(str_replace(IgA, ",", "."))) %>% 
  relocate(patient_id, cca, cca_binary, crohn_or_uc, ibd_binary, fibrosis, fibrosis_binary, alp, alp_binary, bilirubin, bilirubin_binary, sex, sex_binary, age, age_cat, bmi, bmi_cat, crp, IgG_IgA_level, IgG, IgA)

# Investigating the distribution in the outcome groups CCA, IBD, and fibrosis excluding controls (n = 3)
summary(as.factor(metadata$cca_binary))
# CCA: 27 patients without and 6 patients with
summary(as.factor(metadata$ibd_binary))
# IBD: 11 patients without and 22 patients with
summary(as.factor(metadata$fibrosis_binary))
# fibrosis: 13 patients with low level, 16 patients with high level, and 4 patients unknown

# Save the data as .csv
write_csv(metadata, "results/metadata_preprocessed.csv")
