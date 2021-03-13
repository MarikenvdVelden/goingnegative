Prepare Data
================

# Scripts

  - [Required Packages &
    Reproducibility](#required-packages-&-reproducibility)
  - [Tidy Data](#tidy-data)
  - [Save Data for Analysis](#save-data-for-analysis)
  - [Visualization of Data](#visualization-of-data)
      - [Dependent Variable](#dependent-variable)
      - [Independent Variable](#independent-variable)
      - [Control Variables](#control-variables)
      - [Correlations Matrix](#correlations-matrix)

## Required Packages & Reproducibility

``` r
rm(list=ls())
renv::snapshot()
```

    ## * The lockfile is already up to date.

``` r
source(here::here("src/lib/functions.R"))
```

## Tidy Data

Load manually annotated data - for a validation excercise see
[here](Calculate_ICR.R) for the code and
[here](../data/intermediate/Subset_data_intercode_reliability.csv) for
the data - and create variables for being in opposition
(`in_opposition`) and whether the party is a newly founded party
(`new_party`).

``` r
d <- read_csv(here("data/raw/coded-data-NL-2017-campaign.csv")) %>%
  mutate(id = paste(date, party, sep = "."))

table(d$date, d$party)
```

| /          | 50PLUS | CDA | CU | D66 | FvD | GL | PvdA | PvdD | PVV | SGP | SP | VVD |
| :--------- | -----: | --: | -: | --: | --: | -: | ---: | ---: | --: | --: | -: | --: |
| 2017-02-15 |      0 |   3 |  0 |  11 |   0 |  0 |    2 |    4 |   1 |   0 | 14 |   0 |
| 2017-02-16 |      0 |  28 |  3 |   5 |   7 |  2 |    0 |    6 |   0 |   0 | 15 |  21 |
| 2017-02-17 |      5 |  15 | 12 |  22 |   0 |  4 |   11 |   30 |   0 |   8 |  4 |   6 |
| 2017-02-18 |      0 |   2 |  1 |   0 |  10 | 12 |    0 |    0 |   7 |   0 |  1 |   1 |
| 2017-02-19 |      2 |   8 |  0 |   0 |   0 |  0 |   12 |    4 |   0 |   0 |  0 |   0 |
| 2017-02-20 |      0 |   0 |  0 |   6 |  18 |  0 |   10 |    6 |   1 |   0 |  5 |   6 |
| 2017-02-21 |      0 |   9 |  3 |   2 |   4 |  0 |    0 |    1 |   0 |   0 |  9 |   0 |
| 2017-02-22 |      4 |   0 |  0 |   3 |   0 |  4 |    4 |   18 |   0 |   1 |  0 |   0 |
| 2017-02-23 |      1 |   3 |  0 |  10 |   0 |  0 |    0 |    4 |   0 |   1 |  5 |   0 |
| 2017-02-24 |      0 |   2 |  0 |   6 |   4 |  0 |    4 |    8 |   0 |   7 | 15 |   0 |
| 2017-02-25 |      0 |   1 |  1 |   0 |   3 |  3 |    4 |    2 |   2 |   0 |  1 |   0 |
| 2017-02-26 |      0 |   8 |  0 |  10 |   0 |  0 |    0 |    2 |   1 |   1 | 10 |   1 |
| 2017-02-27 |      8 |   2 |  0 |   0 |   0 |  0 |    0 |    2 |   0 |   0 | 15 |   2 |
| 2017-02-28 |      6 |   6 |  0 |   6 |   9 |  5 |    0 |   16 |   0 |   1 |  8 |   0 |
| 2017-03-01 |      0 |  18 |  0 |   5 |   3 |  6 |    0 |    3 |   3 |   2 | 11 |   0 |
| 2017-03-02 |      4 |  14 |  2 |   1 |   7 |  3 |   30 |    4 |   0 |   6 |  8 |   8 |
| 2017-03-03 |      0 |   1 |  1 |   1 |   3 | 23 |    4 |    4 |   0 |   7 |  7 |  11 |
| 2017-03-04 |      2 |   6 |  1 |   3 |   2 |  0 |    0 |   18 |   0 |   5 |  5 |   0 |
| 2017-03-05 |      0 |   0 |  0 |   0 |   4 |  7 |    3 |    7 |   0 |   0 |  3 |   0 |
| 2017-03-06 |      3 |  26 |  4 |  13 |   0 |  9 |    0 |    4 |   3 |  17 |  1 |  13 |
| 2017-03-07 |      0 |   5 |  0 |   5 |   9 | 10 |    0 |    6 |   0 |   6 | 15 |   3 |
| 2017-03-08 |      2 |   4 |  1 |   4 |   1 |  2 |    3 |    6 |   0 |   3 | 11 |   0 |
| 2017-03-09 |      2 |  10 |  0 |   8 |   1 | 19 |    6 |    2 |   1 |   0 | 14 |  11 |
| 2017-03-10 |      2 |   3 |  4 |   0 |  13 |  0 |    1 |    3 |   2 |   0 |  6 |   4 |
| 2017-03-11 |      3 |   3 |  1 |   2 |  10 |  0 |   25 |    4 |   0 |   7 |  1 |  16 |
| 2017-03-12 |      3 |   0 |  0 |   5 |   1 |  2 |    0 |    3 |   6 |   0 |  2 |   5 |
| 2017-03-13 |      4 |  16 |  0 |  22 |   4 | 13 |    0 |    9 |   0 |   9 |  5 |   3 |
| 2017-03-14 |      4 |  10 | 10 |   7 |   4 | 11 |    7 |   16 |   1 |  11 | 24 |  15 |

Not all parties are present at all days of the month, indicated by value
`0` in the table. We ensure that all days in the 2017 campaign period
are present in our data, for the purpose of times-series cross-sectional
analyses.

``` r
source(here("src/data-processing/mutate-handcoded-data.R"))
```

### Ideological Extremity: CHES and Manifesto Project

We have four ways to measure ideological extremity. We look at party’s
deviation from (a) the median party, and (b) the mean party, as measured
by the [2017 Chapel Hill Expert
Survey](https://www.chesdata.eu/2017-chapel-hill-expert-survey) and the
[Manifesto Project](https://manifesto-project.wzb.eu/).

We first add the [2017 Chapel Hill Expert
Survey](https://www.chesdata.eu/s/CHES_means_2017.csv) to our manually
annotated data `d` to calculate party’s ideological extremity for the
2017 (`ie_mean_ches2017` and `ie_median_ches2017`), and 2012 election
campaigns (`ie_mean_ches2014` and `ie_median_ches2014`).

``` r
source(here("src/data-processing/add-ches-data.R"))
```

Second, we added data from the [Manifesto
Project](https://manifesto-project.wzb.eu) to our manually annotated
data `d` to calculate party’s ideological extremity based on the 2017
(`ie_mean_cmp2017` and `ie_median_cmp2017`), and 2012 election
manifesto’s (`ie_mean_cmp2012` and `ie_median_cmp2012`) as well as to
add the seat share of the party in the national elections most prior to
2017 (`seats`).

``` r
source(here("src/data-processing/add-mp-data.R"))
```

### Standing in the Polls

Subsequently, we add [polling
data](https://nl.wikipedia.org/wiki/Tweede_Kamerverkiezingen_2017/Peilingen)
to our manually annotated data. We calculate the relative gains (or
losses) based on: a) polled seats vis-a-vis parliamentary seats prior to
the 2017 elections (`poll_standing1`), b) lagged polled seats by 1 day
vis-a-vis parliamentary seats prior to the 2017 elections
(`poll_standing2`), c) lagged polled seats by 1 week vis-a-vis
parliamentary seats prior to the 2017 elections (`poll_standing3`), d)
polled seats vis-a-vis lagged polled seats by 1 day (`poll_standing4`),
e) polled seats vis-a-vis lagged polled seats by 1 week
(`poll_standing5`), f) lagged polled seats by 1 day vis-a-vis lagged
polled seats by 1 week (`poll_standing6`).

``` r
source(here("src/data-processing/add-polls-data.R"))
```

### Associative Issue Ownership

We use the October 2016 panel wave of KiesKompas to measure associative
and competence issue ownership. We measure associative issue ownership
with the question *Which issue comes to your mind when you think about
<party>?*. For each question, associative issue ownership variables will
be measured by summation over the respondents and calculating in
percentages how many of the respondents associate an issue with a party.

``` r
source(here("src/data-processing/add-KiesKompas-data1.R"))
```

# Competence Issue Ownership

We use the October 2016 panel wave of KiesKompas to measure competence
issue ownership. We measure competence issue ownership with the question
*do you agree or disagree with <party> on the issue you associated with
the party?*. For each question, the compentence issue ownership
variables will be measured by summation over the respondents. Negative
figures imply that more people disagree with the position of the party
than people have agreed with the position of the
party.

``` r
source(here("src/data-processing/add-KiesKompas-data2.R"))
```

## Save Data for Analysis

``` r
save(d, file = here("data/intermediate/cleaned_data.RData"))
```

## Visualization of Data

<img src="../../report/figures/Overview of Appeals per Medium-1.png" style="display: block; margin: auto;" />

### Dependent Variable

<img src="../../report/figures/Dependent Variable-1.png" style="display: block; margin: auto;" />

### Independent Variable

<img src="../../report/figures/Independent Variables - JI-1.png" style="display: block; margin: auto;" />

<img src="../../report/figures/Independent Variables - Polls-1.png" style="display: block; margin: auto;" />

<img src="../../report/figures/Independent Variables - IO-1.png" style="display: block; margin: auto;" />

<img src="../../report/figures/Independent Variables - IE-1.png" style="display: block; margin: auto;" />

### Correlations Matrix

<img src="../../report/figures/Correlations Matrix-1.png" style="display: block; margin: auto;" />
