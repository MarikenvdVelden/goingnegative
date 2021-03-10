Analyses
================

# Scripts

  - [Required Packages &
    Reproducibility](#required-packages-&-reproducibility)
  - [Analyses](#analyses)
      - [H1 Direct Effect of Journalistic Control on Negative
        Appeals](#H1-Direct-Effect-of-Journalistic-Control-on-Negative-Appeals)
      - [H2 Interaction Effect of Polls with Journalistic Control on
        Negative
        Appeals](#H2-Interaction-Effect-of-Polls-with-Journalistic-Control-on-Negative-Appeals)
      - [H3 Interaction Effect of Ideological Extremity with
        Journalistic Control on Negative
        Appeals](#H3-Interaction-Effect-of-Ideological-Extremity-with-Journalistic-Control-on-Negative-Appeals)
      - [H4 Interaction Effect of Issue Ownership with Journalistic
        Control on Negative
        Appeals](#H4-Interaction-Effect-of-Issue-Ownership-with-Journalistic-Control-on-Negative-Appeals)

# Required Packages & Reproducibility

``` r
rm(list=ls())
source(here::here("src/lib/functions.R"))
```

# Analyses

To run a times-series Poisson model, the unit of analysis should be
`party_day`. Therefore, we use various ways to summarise our data to the
daily level.

``` r
load(here("data/intermediate/cleaned_data.RData"))
source(here("src/analysis/data-for-analyses.R"))
```

Next, we automatically extract a `.md` file for the online appendix, as
well as a latex table for the manuscript. We are using jinja2 template
[src/analysis/table\_descriptives.tex.j2](table.tex.j2) which is called
with a json string containing the data. To replicate, make sure
`env/bin/pip install -U j2cli` is installed via your command
line.

``` r
source(here("src/analysis/descriptive-information-overview.R"))
```

## H1 Direct Effect of Journalistic Control on Negative Appeals

``` r
source(here("src/analysis/mv-h1.R"))
```

## H2 Interaction Effect of Polls with Journalistic Control on Negative Appeals

``` r
source(here("src/analysis/mv-h2.R"))
```

## H3 Interaction Effect of Ideological Extremity with Journalistic Control on Negative Appeals

``` r
source(here("src/analysis/mv-h3.R"))
```

## H4 Interaction Effect of Issue Ownership with Journalistic Control on Negative Appeals

``` r
source(here("src/analysis/mv-h4.R"))
```
