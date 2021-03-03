Prepare Data
================
Dirck de Kleer & Mariken A.C.G. van der Velden

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
source(here("src/lib/functions.R"))
```

## Tidy Data

Load manually annotated data - for a validation excercise see
[here](../../n) - and create variables for being in opposition
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
df <- expand_grid(date = seq(as.Date("2017/02/15"), 
                             as.Date("2017/03/14"), by = "day"),
                  party = c("50PLUS", "CDA", "CU", "D66", "FvD", "GL",
                            "PvdA", "PvdD", "PVV", "SGP", "SP", 
                            "VVD")) %>%
  mutate(id = paste(date, party, sep = "."))

d <- left_join(df, d, by = "id") %>%
  select(id, date = date.x, party = party.x, medium, source, cmp_code,
         text_appeal, issue, direction_appeal) %>%
  mutate(direction_appeal = replace_na(direction_appeal, "No Appeal"),
         medium = replace_na(medium, " "),
         source = replace_na(source, " "),
         text_appeal = replace_na(text_appeal, " "),
         issue = replace_na(issue, "None"),
         in_opposition = ifelse(party == "VVD", 0,
                         ifelse(party == "PvdA", 0, 1)),
         new_party = ifelse(party == "FvD", 1, 0),
         journalistic_intervenience = ifelse(medium=="TV-shows", .5,
                                      ifelse(medium=="Newspapers", 1,
                                             0)),
         cmp_code = ifelse(party == "50PLUS", 22953,
                    ifelse(party == "GL", 22110,
                    ifelse(party == "SP", 22220,
                    ifelse(party == "PvdA", 22320,
                    ifelse(party == "D66", 22330,
                    ifelse(party == "VVD", 22420,
                    ifelse(party == "CDA", 22521,
                    ifelse(party == "CU", 22526,
                    ifelse(party == "PVV", 22722,
                    ifelse(party == "PvdD", 22951,
                    ifelse(party == "SGP", 22952,
                    ifelse(party == "FvD", 22730, cmp_code)))))))))))))

rm(df)
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
ches <- read_csv("https://www.chesdata.eu/s/CHES_means_2017.csv") %>%
  filter(country == "nl") %>%
  select(party = party, rile_ches = lrgen) %>%
  mutate(ie_median_ches2017 = abs(rile_ches - median(rile_ches)),
         ie_mean_ches2017 = abs(rile_ches - mean(rile_ches))) %>%
  select(-rile_ches)

d <- left_join(d, ches, by = "party")
rm(ches)

ches <- read_csv("https://www.chesdata.eu/s/2014_CHES_dataset_means.csv") %>%
  filter(cname == "net") %>%
  select(party = party_name, rile_ches = lrgen) %>%
  mutate(ie_median_ches2014 = abs(rile_ches - median(rile_ches)),
         ie_mean_ches2014 = abs(rile_ches - mean(rile_ches))) %>%
  select(-rile_ches)

d <- left_join(d, ches, by = "party")
rm(ches)
```

Second, we added data from the [Manifesto
Project](https://manifesto-project.wzb.eu) to our manually annotated
data `d` to calculate party’s ideological extremity based on the 2017
(`ie_mean_cmp2017` and `ie_median_cmp2017`), and 2012 election
manifesto’s (`ie_mean_cmp2012` and `ie_median_cmp2012`) as well as to
add the seat share of the party in the national elections most prior to
2017
(`seats`).

``` r
cmp <- read_csv("https://manifesto-project.wzb.eu/down/data/2020b/datasets/MPDataset_MPDS2020b.csv") %>%
  filter(countryname == "Netherlands", date == "201703") %>%
  mutate(ie_mean_cmp2017 = abs(rile - median(rile)),
         ie_median_cmp2017 = abs(rile - mean(rile))) %>%
  select(cmp_code = party,ie_mean_cmp2017,
         ie_median_cmp2017)
d <- left_join(d, cmp, by = "cmp_code")
rm(cmp)

cmp <- read_csv("https://manifesto-project.wzb.eu/down/data/2020b/datasets/MPDataset_MPDS2020b.csv") %>%
  filter(countryname == "Netherlands", date == "201209") %>%
  mutate(ie_mean_cmp2012 = abs(rile - median(rile)),
         ie_median_cmp2012 = abs(rile - mean(rile))) %>%
  select(cmp_code = party, ie_mean_cmp2012,
         ie_median_cmp2012, seats = absseat)

d <- left_join(d, cmp, by = "cmp_code") %>%
  drop_na(date)
rm(cmp)
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
polled seats by 1 week
(`poll_standing6`).

``` r
polls <- "https://nl.wikipedia.org/wiki/Tweede_Kamerverkiezingen_2017/Peilingen#Peilingresultaten" %>%
  read_html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>% 
  html_table(fill = T) 

polls <- do.call(rbind.data.frame, polls) %>%
  tibble() %>%
  filter(Datum > "14 februari 2017") %>%
  mutate(Datum = recode(Datum,
                        `14 maart 2017` = "14-03-2017",
                        `15 februari 2017` = "15-02-2017",
                        `15 maart 2017` = "15-03-2017",
                        `16 februari 2017` = "16-02-2017",
                        `17 februari 2017` = "17-02-2017",
                        `18 februari 2017` = "18-02-2017",
                        `19 februari 2017` = "19-02-2017",
                        `2 februari 2017` = "02-02-2017",
                        `2 maart 2017` = "02-03-2017",
                        `20 februari 2017` = "20-02-2017",
                        `21 februari 2017` = "21-02-2017",
                        `22 februari 2017` = "22-02-2017",
                        `23 februari 2017` = "23-02-2017",
                        `24 februari 2017` = "24-02-2017",
                        `25 februari 2017` = "25-02-2017",
                        `26 februari 2017` = "26-02-2017",
                        `27 februari 2017` = "27-02-2017",
                        `28 februari 2017` = "28-02-2017",
                        `3 februari 2017` = "03-02-2017",
                        `3 maart 2017` = "03-03-2017",
                        `4 februari 2017` = "04-02-2017",
                        `4 maart 2017` = "04-03-2017",
                        `5 februari 2017` = "05-02-2017",
                        `5 maart 2017` = "05-03-2017",
                        `6 februari 2017` = "06-02-2017",
                        `6 maart 2017` = "06-03-2017",
                        `7 februari 2017` = "07-02-2017",
                        `7 maart 2017` = "07-03-2017",
                        `8 februari 2017` = "08-02-2017",
                        `8 maart 2017` = "08-03-2017",
                        `9 februari 2017` = "03-02-2017",
                        `9 maart 2017` = "03-03-2017"),
         Datum = as.Date(Datum, format = "%d-%m-%Y")) %>%
  filter(Datum > "2017-02-14",
         Datum < "2017-03-15") %>%
  select(-PPNL, -Andere, -Denk, -VNL) %>%
  pivot_longer(cols = c(VVD:FvD),
               names_to = "party",
               values_to = "polls") %>%
  group_by(Datum, party) %>%
  summarise(polls = sum(polls)) %>%
  select(date = Datum, party, polls) %>%
  mutate(party = recode(party,
                        `50+` = "50PLUS")) %>%
  ungroup()

polls <- polls %>%
  add_case(date = rep(as.Date("2017-03-01"), 12),
           party = c("VVD", "PvdA", "PVV", "SP", "CDA", "D66", 
                     "CU", "GL", "SGP", "PvdD", "50PLUS", "FvD"),
           polls = c(26, 13, 22, 16, 16, 18, 6, 17, 2, 6, 6, 0))  %>%
  add_case(date = rep(as.Date("2017-03-09"), 12),
           party = c("VVD", "PvdA", "PVV", "SP", "CDA", "D66", 
                     "CU", "GL", "SGP", "PvdD", "50PLUS", "FvD"),
           polls = c(27, 13, 22, 17, 16, 18, 6, 16, 2, 5, 6, 1)) %>%
  add_case(date = rep(as.Date("2017-03-10"), 12),
           party = c("VVD", "PvdA", "PVV", "SP", "CDA", "D66", 
                     "CU", "GL", "SGP", "PvdD", "50PLUS", "FvD"),
           polls = c(27, 13, 22, 17, 16, 18, 6, 16, 2, 5, 6, 1)) %>%
  add_case(date = rep(as.Date("2017-03-11"), 12),
           party = c("VVD", "PvdA", "PVV", "SP", "CDA", "D66", 
                     "CU", "GL", "SGP", "PvdD", "50PLUS", "FvD"),
           polls = c(27, 13, 22, 17, 16, 18, 6, 16, 2, 5, 6, 1)) %>%
  add_case(date = rep(as.Date("2017-03-12"), 12),
           party = c("VVD", "PvdA", "PVV", "SP", "CDA", "D66", 
                     "CU", "GL", "SGP", "PvdD", "50PLUS", "FvD"),
           polls = c(27, 13, 22, 17, 16, 18, 6, 16, 2, 5, 6, 1)) %>%
  add_case(date = rep(as.Date("2017-03-13"), 12),
           party = c("VVD", "PvdA", "PVV", "SP", "CDA", "D66", 
                     "CU", "GL", "SGP", "PvdD", "50PLUS", "FvD"),
           polls = c(27, 13, 22, 17, 16, 18, 6, 16, 2, 5, 6, 1))  %>%
  mutate(id = paste(date, party, sep = "."))

polls <-slide(data = polls, Var = "polls", TimeVar = "date",
               GroupVar = "party", NewVar = "l_polls1", slideBy = -1) 
polls <- slide(data = polls, Var = "polls", TimeVar = "date",
               GroupVar = "party", NewVar = "l_polls2", slideBy = -2) 
polls <- slide(data = polls, Var = "polls", TimeVar = "date",
               GroupVar = "party", NewVar = "l_polls3", slideBy = -3) 
polls <- slide(data = polls, Var = "polls", TimeVar = "date",
               GroupVar = "party", NewVar = "l_polls4", slideBy = -4)  
polls <- slide(data = polls, Var = "polls", TimeVar = "date",
               GroupVar = "party", NewVar = "l_polls5", slideBy = -5) 
polls <- slide(data = polls, Var = "polls", TimeVar = "date",
               GroupVar = "party", NewVar = "l_polls6", slideBy = -6) 
polls <- slide(data = polls, Var = "polls", TimeVar = "date",
               GroupVar = "party", NewVar = "l_polls7", slideBy = -7) 
polls <- polls %>%
  mutate(l_polls_mean = ifelse(is.na(l_polls1), NA,
                      ifelse(is.na(l_polls2), l_polls1,
                      ifelse(is.na(l_polls3), (l_polls1 + l_polls2)/2,
                      ifelse(is.na(l_polls4), 
                             (l_polls1 + l_polls2 + l_polls3)/3,
                      ifelse(is.na(l_polls5), 
                             (l_polls1 + l_polls2 + l_polls3 +
                                l_polls4)/4,
                      ifelse(is.na(l_polls6), 
                             (l_polls1 + l_polls2 + l_polls3 +
                                l_polls4 + l_polls5)/5,
                      ifelse(is.na(l_polls7), 
                             (l_polls1 + l_polls2 + l_polls3 +
                                l_polls4 + l_polls5 + l_polls6)/6,
                             (l_polls1 + l_polls2 + l_polls3 +
                                l_polls4 + l_polls5 + l_polls6 +
                                l_polls7)/7)))))))) %>%
  select(id, polls, l_polls1, l_polls7,  l_polls_mean)

d <- left_join(d, polls, by = "id") %>%
  mutate(seats = ifelse(party=="FvD", 0, seats),
         polls = ifelse(party=="FvD" & date=="2017-02-15", 0,
                 ifelse(party=="FvD" & date=="2017-02-16", 0, polls)),
         poll_standing1 = ifelse(party=="FvD", polls,
                                 round(polls/seats,2)),
         poll_standing2 = ifelse(party=="FvD",
                                 polls,round(l_polls1/seats,2)),
         poll_standing3 = ifelse(party=="FvD", polls,
                                 round(l_polls7/seats,2)),
         poll_standing4 = ifelse(party=="FvD", polls,
                                 round(l_polls_mean/seats,2)),
         poll_standing5 = ifelse(party=="FvD", polls, 
                                 round(polls/l_polls1, 2)),
         poll_standing6 = ifelse(party=="FvD", polls, 
                                 round(polls/l_polls7, 2)),
         poll_standing7 = ifelse(party=="FvD", polls,  
                                 round(polls/l_polls_mean, 2)),
         poll_standing8 = ifelse(party=="FvD", polls, 
                                 round(l_polls1/l_polls7, 2)),
         poll_standing9 = ifelse(party=="FvD", polls,
                                 round(l_polls1/l_polls_mean, 2)))

rm(polls)
```

### Associative Issue Ownership

We use the October 2016 panel wave of KiesKompas to measure associative
and competence issue ownership. We measure associative issue ownership
with the question *Which issue comes to your mind when you think about
<party>?*. For each question, associative issue ownership variables will
be measured by summation over the respondents and calculating in
percentages how many of the respondents associate an issue with a
party.

``` r
aio <- read_sav(here("data/raw/Netherlands+survey+October+2016.sav")) %>%
  select(`1_CDA` = Q13_1_1, `2_CDA` = Q13_2_1, 
         `1_PvdA` = Q13_1_2, `2_PvdA` = Q13_2_2,
         `1_SP` = Q13_1_3, `2_SP` = Q13_2_3,
         `1_VVD` = Q13_1_4, `2_VVD` = Q13_2_4,
         `1_PVV` = Q13_1_5, `2_PVV` = Q13_2_5,
         `1_GL` = Q13_1_6, `2_GL` = Q13_2_6,
         `1_CU` = Q13_1_7, `2_CU` = Q13_2_7,
         `1_D66` = Q13_1_8, `2_D66` = Q13_2_8,
         `1_PvdD` = Q13_1_9, `2_PvdD` = Q13_2_9,
         `1_SGP` = Q13_1_10, `2_SGP` = Q13_2_10) %>%
  zap_labels() %>%
  pivot_longer(cols = everything(),
                    names_to = "party",
                    values_to = "issue") %>%
  separate(party, c("choice", "party"), "_", extra = "merge") %>%
  mutate(issue = recode(issue,
    `1` = "Immigration",
    `2` = "Mobility Network",
    `3` = "Institutional Reform",
    `4` = "Crime Fighting",
    `5` = "European Union",
    `6` = "Health Care",
    `7` = "Housing",
    `8` = "Military Interventions",
    `9` = "Agriculture",
    `10` = "Environment & Climate",
    `11` = "Norms and Values",
    `12` = "Entrepreneurship",
    `13` = "Education",
    `14` = "Foreign Aid",
    `15` = "Taxes, Budget & Economy",
    `16` = "Social Security",
    `17` = "Counter-Terrorism",
    `18` = "Labour Market",
    `19` = "Efficient Government",
    `20` = "None",
    `21` = "Different"
  )) %>%
  group_by(party, issue) %>%
  summarise(n= n(),
            percentage = n/50580) %>%
  ungroup() %>%
  filter(issue != "None",
         issue != "Different") %>%
  drop_na() 

associate_io <- aio %>%
  group_by(party) %>% 
  top_n(1, percentage) %>%
  ungroup() %>%
  select(party, associated_issue = issue) 

d <- left_join(d, associate_io, by = "party") 

aio <- aio %>%
  mutate(id = paste(party, issue, sep = "-"),
         percentage = round(percentage, 2)) %>%
  select(id, aio_n = n, aio_percentage = percentage)

d <- d %>%
  mutate(associate_io = ifelse(issue==associated_issue,1,0),
         id = paste(party, issue, sep = "-"))
d <- left_join(d, aio, by = "id") %>%
  mutate(aio_percentage = replace_na(aio_percentage, 0))
rm(aio, associate_io)
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
data <- read_sav(here("data/raw/Netherlands+survey+October+2016.sav")) %>%
  zap_labels()

for(i in 1:19){
  if(i==1){cda <- get_cio(data = data, var1= "Q14", var2 = "Q15", 
                        var3 = "Q13_1_1", var4 = "Q13_2_1",
                        issue = i, party = "CDA")}
  else{cda <- rbind(cda, get_cio(data = data, var1= "Q14", var2 = "Q15", 
                        var3 = "Q13_1_1", var4 = "Q13_2_1",
                        issue = i, party = "CDA"))}
}

for(i in 1:19){
  if(i==1){pvda <- get_cio(data = data, var1= "Q16", var2 = "Q17", 
                        var3 = "Q13_1_2", var4 = "Q13_2_2",
                        issue = i, party = "PvdA")}
  else{pvda <- rbind(pvda, get_cio(data = data, var1= "Q16", var2 = "Q17", 
                        var3 = "Q13_1_2", var4 = "Q13_2_2",
                        issue = i, party = "PvdA"))}
}

cio <- rbind(cda, pvda)
rm(cda, pvda)

for(i in 1:19){
  if(i==1){sp <- get_cio(data = data, var1= "Q18", var2 = "Q19", 
                        var3 = "Q13_1_3", var4 = "Q13_2_3",
                        issue = i, party = "SP")}
  else{sp <- rbind(sp, get_cio(data = data, var1= "Q18", var2 = "Q19", 
                        var3 = "Q13_1_3", var4 = "Q13_2_3",
                        issue = i, party = "SP"))}
}
cio <- rbind(cio, sp)
rm(sp)

for(i in 1:19){
  if(i==1){vvd <- get_cio(data = data, var1= "Q20", var2 = "Q21", 
                        var3 = "Q13_1_4", var4 = "Q13_2_4",
                        issue = i, party = "VVD")}
  else{vvd <- rbind(vvd, get_cio(data = data, var1= "Q20", var2 = "Q21", 
                        var3 = "Q13_1_4", var4 = "Q13_2_4",
                        issue = i, party = "VVD"))}
}
cio <- rbind(cio, vvd)
rm(vvd)

for(i in 1:19){
  if(i==1){pvv <- get_cio(data = data, var1= "Q22", var2 = "Q23", 
                        var3 = "Q13_1_5", var4 = "Q13_2_5",
                        issue = i, party = "PVV")}
  else{pvv <- rbind(pvv, get_cio(data = data, var1= "Q22", var2 = "Q23", 
                        var3 = "Q13_1_5", var4 = "Q13_2_5",
                        issue = i, party = "PVV"))}
}
cio <- rbind(cio, pvv)
rm(pvv)

for(i in 1:19){
  if(i==1){gl <- get_cio(data = data, var1= "Q24", var2 = "Q25", 
                        var3 = "Q13_1_6", var4 = "Q13_2_6",
                        issue = i, party = "GL")}
  else{gl <- rbind(gl, get_cio(data = data, var1= "Q24", var2 = "Q25", 
                        var3 = "Q13_1_6", var4 = "Q13_2_6",
                        issue = i, party = "GL"))}
}
cio <- rbind(cio, gl)
rm(gl)

for(i in 1:19){
  if(i==1){cu <- get_cio(data = data, var1= "Q26", var2 = "Q27", 
                        var3 = "Q13_1_7", var4 = "Q13_2_7",
                        issue = i, party = "CU")}
  else{cu <- rbind(cu, get_cio(data = data, var1= "Q26", var2 = "Q27", 
                        var3 = "Q13_1_7", var4 = "Q13_2_7",
                        issue = i, party = "CU"))}
}
cio <- rbind(cio, cu)
rm(cu)

for(i in 1:19){
  if(i==1){d66 <- get_cio(data = data, var1= "Q28", var2 = "Q29", 
                        var3 = "Q13_1_8", var4 = "Q13_2_8",
                        issue = i, party = "D66")}
  else{d66 <- rbind(d66, get_cio(data = data, var1= "Q28", var2 = "Q29", 
                        var3 = "Q13_1_8", var4 = "Q13_2_8",
                        issue = i, party = "D66"))}
}
cio <- rbind(cio, d66)
rm(d66)

for(i in 1:19){
  if(i==1){pvdd <- get_cio(data = data, var1= "Q30", var2 = "Q31", 
                        var3 = "Q13_1_9", var4 = "Q13_2_9",
                        issue = i, party = "PvdD")}
  else{pvdd <- rbind(pvdd, get_cio(data = data, var1= "Q30", var2 = "Q31", 
                        var3 = "Q13_1_9", var4 = "Q13_2_9",
                        issue = i, party = "PvdD"))}
}
cio <- rbind(cio, pvdd)
rm(pvdd)

for(i in 1:19){
  if(i==1){sgp <- get_cio(data = data, var1= "Q32", var2 = "Q33", 
                        var3 = "Q13_1_10", var4 = "Q13_2_10",
                        issue = i, party = "SGP")}
  else{sgp <- rbind(sgp, get_cio(data = data, var1= "Q32", var2 = "Q33", 
                        var3 = "Q13_1_10", var4 = "Q13_2_10",
                        issue = i, party = "SGP"))}
}
cio <- rbind(cio, sgp)
rm(sgp, data, i)

cio <- cio %>%
  mutate(issue = recode(issue,
    `1` = "Immigration",
    `2` = "Mobility Network",
    `3` = "Institutional Reform",
    `4` = "Crime Fighting",
    `5` = "European Union",
    `6` = "Health Care",
    `7` = "Housing",
    `8` = "Military Interventions",
    `9` = "Agriculture",
    `10` = "Environment & Climate",
    `11` = "Norms and Values",
    `12` = "Entrepreneurship",
    `13` = "Education",
    `14` = "Foreign Aid",
    `15` = "Taxes, Budget & Economy",
    `16` = "Social Security",
    `17` = "Counter-Terrorism",
    `18` = "Labour Market",
    `19` = "Efficient Government",
    `20` = "None",
    `21` = "Different"),
    id = paste(party, issue, sep ="-")) %>%
  select(-party, -issue)

d <- left_join(d, cio, by = "id") %>%
  mutate(cio_mean = replace_na(cio_mean, 0),
         cio_median = replace_na(cio_median, 0),
         cio_sd = replace_na(cio_sd, 0))
  
rm(cio)
```

## Save Data for Analysis

``` r
save(d, file = here("data/intermediate/cleaned_data.RData"))
```

## Visualization of Data

![](/Users/marikenvandervelden/Dropbox/Papers/goingnegative/report/figures/Overview%20of%20Appeals%20per%20Medium-1.png)<!-- -->

### Dependent Variable

![](/Users/marikenvandervelden/Dropbox/Papers/goingnegative/report/figures/Dependent%20Variable-1.png)<!-- -->

### Independent Variable

![](/Users/marikenvandervelden/Dropbox/Papers/goingnegative/report/figures/Independent%20Variables%20-%20JI-1.png)<!-- -->

![](/Users/marikenvandervelden/Dropbox/Papers/goingnegative/report/figures/Independent%20Variables%20-%20Polls-1.png)<!-- -->

![](/Users/marikenvandervelden/Dropbox/Papers/goingnegative/report/figures/Independent%20Variables%20-%20IO-1.png)<!-- -->

![](/Users/marikenvandervelden/Dropbox/Papers/goingnegative/report/figures/Independent%20Variables%20-%20IE-1.png)<!-- -->

### Correlations Matrix

![](/Users/marikenvandervelden/Dropbox/Papers/goingnegative/report/figures/Correlations%20Matrix-1.png)<!-- -->
