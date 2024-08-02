#! usr/R

# This script tidies, evaluates, and filters and protein data
# Input: protein data (csv)
## Output: preprocessed protein data (csv)

# Read the libraries
library(tidyverse)

# Read the data
data <- read_csv("data/protein_data.csv")

# Tidy the data

data <- data %>% 
  # Remove protein control samples/not patients
  filter(!Patient_ID %in% c("Control_1", "Control_2")) %>%
  mutate(Patient_ID = case_when(
    Patient_ID == "pool_1" ~ "34", 
    Patient_ID == "pool_2" ~ "35", 
    Patient_ID == "pool_3" ~ "36", 
    .default = Patient_ID
  ), 
  Patient_ID = as.numeric(Patient_ID)
  ) %>% 
  arrange(Patient_ID) %>% 
  rename(patient_id = Patient_ID)

# Filter the data
data <- data %>%
  # Remove problematic proteins
  dplyr::select(-OID01399, -OID01397, -OID01367, -OID01373, -OID01332, -OID01368, -OID01364, -OID01312, -OID01348, -OID01350, -OID01436, -OID01396, -OID01404, -OID01425, -OID01446, -OID01465, -OID00940,
       -OID00948, -OID00953, -OID00967, -OID00972, -OID00975, -OID00979, -OID00981, -OID00986, -OID00989, -OID01000, -OID01003, -OID01012, -OID01022, -OID01024, -OID00493, -OID00495, -OID00497,
       -OID00509, -OID00524, -OID00525, -OID00526, -OID00537, -OID00543, -OID00544, -OID00546, -OID00547, -OID01158, -OID01159, -OID01173, -OID01201, -OID01205, -OID05405, -OID05407, -OID00544,
       -OID05409, -OID05426, -OID05432, -OID05433, -OID05435, -OID05443, -OID05444, -OID05447, -OID05450, -OID05476, -OID05481, -OID05485, -OID05490, -OID01028, -OID01033, -OID01035, -OID01057,
       -OID01062, -OID01064, -OID01069, -OID01072, -OID01073, -OID01077, -OID01083, -OID01088, -OID01091, -OID01097, -OID01106, -OID01109, -OID00529, -OID00543, -OID01020, -OID00492, -OID00548,
       -OID01048, -OID01154, -OID01182, -OID05416, -OID05436, -OID05475, -OID00559, -OID01346, -OID01357, -OID01315, -OID01308, -OID01395, -OID01327, -OID01369, -OID01426, -OID00939, -OID00954,
       -OID00962, -OID00983, -OID00489, -OID01141, -OID01145, -OID01169, -OID05442, -OID05125, -OID01092, -OID01107) %>%
  # Remove up to 8% of bad measurements
  dplyr::select(-OID01111, -OID01105, -OID01104, -OID01101, -OID01096, -OID01081, -OID01078, -OID01063, -OID01059, -OID05463, -OID05462, -OID05448, -OID05437, -OID05415, -OID01200, -OID01167, -OID00508, -OID01011, -OID00936, -OID01326)

# Evaluate the data
## Checking for NA's
data %>% 
  is.na() %>%
  sum()
## Conclusion: There are no NA's

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
  summarise(sum = sum(distinct))
## Conclusion: There are no constant columns.

# Save the data as .csv
write_csv(data, "results/protein_preprocessed.csv")

# Alternative with protein_filtered_data

# data0 <- read_csv("data/protein_data_filtered.csv")
# 
# # Tidy the data
# data0 <- data0 %>% 
#   # Create a numeric patient ID column
#   rownames_to_column(var = "patient_id") %>% 
#   mutate(patient_id = as.numeric(patient_id)) %>% 
#   dplyr::select(-2)
