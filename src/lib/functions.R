# Libraries necessary to reproduce 'When the cat’s away, the mice will play' Paper
library(tidyverse)
library(rvest)
library(ggstatsplot)
library(haven)
library(here)
library(xtable)
library(broom)
library(scales)
library(viridis)
library(specr)
library(DataCombine)
library(lme4)
library(ggridges)
library(patchwork)

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

# specific model fitting function
glmer_mv <- function(formula, data,...) {
  require(lme4)
  require(broom.mixed)
  formula <- paste0(formula, "+ l_negative_appeal + (1|party)")
  glmer(formula, data, family = poisson(link = "log"))
}

#' Render a template using jinja2 command line tool
render_j2 = function(template, output, data, auto_unbox=TRUE, na="string") {
  data = jsonlite::toJSON(data, pretty=TRUE, auto_unbox=auto_unbox, na=na)
  system(glue::glue("env/bin/j2 --format json {template} -o {output}"), input=data)
}
