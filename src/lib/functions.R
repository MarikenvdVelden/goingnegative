# Libraries necessary to reproduce 'When the cat’s away, the mice will play' Paper
library(tidyverse)
library(rvest)
library(ggstatsplot)
library(haven)
library(broom)
library(scales)
library(viridis)

get_cio <- function(data, var1, var2, var3, var4, issue, party){
  df <- data %>%
    select(var1, var2, var3, var4) 
  df <- df %>%
    filter(df[,3] == issue |
             df[,4] == issue) %>%
    select(var1, var2) %>%
    pivot_longer(everything(),
                 names_to = "question",
                 values_to = "position") %>%
    select(!question) %>%
    mutate(position = recode(position,
                             `5` = -2,
                             `4` = -1,
                             `3` = 0,
                             `2` = 1,
                             `1` = 2),
           party = party,
           issue = issue) %>%
    drop_na() %>%
    group_by(party, issue) %>%
    summarise(cio_n = sum(position),
              cio_mean = round(mean(position),2),
              cio_median = median(position),
              cio_sd = sd(position)) %>%
    ungroup()
  return(df)
}