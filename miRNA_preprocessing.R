#! usr/R

# This script tidies, evaluates, and filters miRNA data
# Input: miRNA data (csv)
# Output: preprocessed miRNA data (csv)

# Read the libraries
library(tidyverse)

# Read the data
data <- read_csv('data/miRNA_hairpin_log.csv')
data1 <- read_csv('data/miRNA_mature_log.csv')

# Hairpin

# Tidy the data
data <- data %>%
  # Transposing the table so that each row represents a patient and each column represents a compound
  pivot_longer(cols = c(-1), names_to = "patient_id") %>%
  pivot_wider(names_from = c(1)) %>%
  mutate(across('patient_id', str_replace, '_.*', '')) %>% 
  # Create a numeric patient ID column
  mutate(patient_id = as.numeric(patient_id)) %>% 
  arrange(patient_id)

# Evaluate the data
## Checking for NA's
data %>% 
  is.na() %>%
  sum()
## Conclusion: There are no NA's.

## Checking for constant columns
data %>% 
  dplyr::select(-1) %>% 
  pivot_longer(
    everything(), 
    names_to = "variable", 
    values_to = "value"
  ) %>% 
  group_by(variable) %>% 
  summarise(distinct = n_distinct(value)) %>% 
  filter(distinct == 1) %>% 
  summarise(n = n())
## Conclusion: There are 412 constant columns.

# Filter the data
data <- data %>% 
  # Removing columns with constant values
  select_if(~ n_distinct(.x) > 1)

# Mature

# Tidy the data
data1 <- data1 %>%
  # Transposing the table so that each row represents a patient and each column represents a compound
  pivot_longer(cols = c(-1), names_to = "patient_id") %>%
  pivot_wider(names_from = c(1)) %>%
  mutate(across('patient_id', str_replace, '_.*', '')) %>% 
  # Create a numeric patient ID column
  mutate(patient_id = as.numeric(patient_id)) %>% 
  arrange(patient_id)

# Evaluate the data
## Checking for NA's
data1 %>% 
  is.na() %>%
  sum()
## Conclusion: There are no NA's.

## Checking for constant columns
data1 %>% 
  dplyr::select(-1) %>% 
  pivot_longer(
    everything(), 
    names_to = "variable", 
    values_to = "value"
  ) %>% 
  group_by(variable) %>% 
  summarise(distinct = n_distinct(value)) %>% 
  filter(distinct == 1) %>% 
  summarise(n = n())
## Conclusion: There are 1187 constant columns.

# Filter the data
data1 <- data1 %>% 
  # Removing columns with constant values
  select_if(~ n_distinct(.x) > 1)

# Join and save the data as .csv
data %>%
  inner_join(data1, by = "patient_id") %>%
  write_csv("results/miRNA_preprocessed.csv")
