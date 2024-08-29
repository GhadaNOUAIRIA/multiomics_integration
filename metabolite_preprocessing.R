#! usr/R

# This script tidies, evaluates, and filters metabolite data
# Input: metabolite data (csv)
# Output: preprocessed metabolite data (csv)

# Read the libraries
library(tidyverse)

# Read the data
data <- read_csv("data/metabolomics_data.csv")

# Tidy the data
data <- data %>%
  # Removing metabolite type which is irrelevant metadata
  select(-"SUPER PATHWAY") %>%
  # Transposing the table so that each row represents a patient and each column represents a compound
  pivot_longer(cols = c(-1), names_to = "patient_id") %>%
  pivot_wider(names_from = c(1)) %>% 
  # Create a numeric patient ID column
  select(-patient_id) %>% 
  rownames_to_column(var = "patient_id") %>% 
  mutate(patient_id = as.numeric(patient_id))

# Evaluate the data
## Checking for NA's  
data %>% is.na() %>%
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
## Conclusion: There are 15 constant columns.

# Filter the data
data <- data %>% 
  # Removing columns with constant values
  select_if(~n_distinct(na.omit(.x)) > 1)

# Save the table 
write_csv(data, "results/metabolite_preprocessed.csv")
