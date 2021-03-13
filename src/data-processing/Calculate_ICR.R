# Intercoder reliability
rm(list=ls())
library(here)
library(tidyverse)
library(googlesheets4)

d <- read_csv(here("data/raw/coded-data-NL-2017-campaign.csv")) %>%
  mutate(id = paste(date, party, sep = "_")) %>%
  select(id, text_appeal)

s <- sample_n(d, 200)
write_csv(s, here("data/intermediate/Subset_data_intercoder_reliability.csv"))

