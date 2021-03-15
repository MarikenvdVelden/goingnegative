# Intercoder reliability
rm(list=ls())
library(here)
library(tidyverse)
library(irr)

d <- read_csv(here("data/raw/coded-data-NL-2017-campaign.csv")) %>%
  mutate(id = paste(date, party, sep = "_")) %>%
  select(id, text_appeal)

s <- sample_n(d, 200)
write_csv(s, here("data/intermediate/Subset_data_intercoder_reliability.csv"))

# Calculate ICR on issues
d <- read_csv(here("data/intermediate/Subset_data_intercoder_reliability.csv"))

neg <- matrix(c(d$neg1, d$neg2), ncol = 2)
kappa2(neg)

issue <- matrix(c(d$issue_theme1, d$issue_theme2), ncol = 2)
kappa2(issue)
