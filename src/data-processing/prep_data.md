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
source("../lib/functions.R")
```

## Tidy Data

Load manually annotated data - for a validation excercise see
[here](../../data/intermediate/Subset_data_intercoder_reliability.xlsx)
- and create variables for being in opposition (`in_opposition`) and
whether the party is a newly founded party (`new_party`).

``` r
d <- read_csv("../../data/raw/coded-data-NL-2017-campaign.csv") %>%
  mutate(in_opposition = ifelse(party == "VVD", 0,
                      ifelse(party == "PvdA", 0, 1)),
         new_party = ifelse(party == "FvD", 1, 0),
         journalistic_intervenience = ifelse(medium=="Facebook", 0,
                                      ifelse(medium=="Newspapers", 1, 0.5)))
```

### Ideological Extremity: CHES and Manifesto Project

We have four ways to measure ideological extremity. We look at party’s
deviation from (a) the median party, and (b) the mean party, as measured
by the [2017 Chapel Hill Expert
Survey](https://www.chesdata.eu/2017-chapel-hill-expert-survey) and the
[Manifesto Project](https://manifesto-project.wzb.eu/).

We first add the [2017 Chapel Hill Expert
Survey](https://www.chesdata.eu/s/CHES_means_2017.csv) to our manually
annotated data `d` to calculate party’s ideological extremity as well as
to add the seat share of the party in the national elections most prior
to 2017.

``` r
ches <- read_csv("https://www.chesdata.eu/s/CHES_means_2017.csv") %>%
  filter(country == "nl") %>%
  select(party = party, rile_ches = lrgen, seats = seat) %>%
  mutate(ideological_extremity_ches1 = abs(rile_ches - median(rile_ches)),
         ideological_extremity_ches2 = abs(rile_ches - mean(rile_ches))) %>%
  select(-rile_ches)

d <- left_join(d, ches, by = "party")
rm(ches)
```

Second, we added data from the [Manifesto
Project](https://manifesto-project.wzb.eu/down/data/2020b/datasets/MPDataset_MPDS2020b.csv)
to our manually annotated data `d` to calculate party’s ideological
extremity.

``` r
cmp <- read_csv("https://manifesto-project.wzb.eu/down/data/2020b/datasets/MPDataset_MPDS2020b.csv") %>%
  filter(countryname == "Netherlands", date == "201703") %>%
  mutate(ideological_extremity_cmp1 = abs(rile - median(rile)),
         ideological_extremity_cmp2 = abs(rile - mean(rile))) %>%
  select(cmp_code = party,ideological_extremity_cmp1,
         ideological_extremity_cmp2)

d <- left_join(d, cmp, by = "cmp_code")
rm(cmp)
```

### Standing in the Polls

Subsequently, we add [polling
data](https://nl.wikipedia.org/wiki/Tweede_Kamerverkiezingen_2017/Peilingen)
to our manually annotated data. We use the (a) mean and (b) median value
of the polls averaged over the different polling houses between February
15th 2017 and March 14th
2017.

``` r
polls <- "https://nl.wikipedia.org/wiki/Tweede_Kamerverkiezingen_2017/Peilingen#Peilingresultaten" %>%
  read_html() %>%
  html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[3]') %>% 
  html_table(fill = T) 

polls <- do.call(rbind.data.frame, polls) %>%
  tibble() %>%
  filter(Datum > "14 februari 2017") %>%
  pivot_longer(cols = c(VVD:FvD),
               names_to = "party",
               values_to = "polls") %>%
  select(party, polls) %>%
  filter(party != "Denk") %>%
  group_by(party) %>%
  summarise(mean_polls = mean(polls),
            median_polls = median(polls)) %>%
  ungroup()

d <- left_join(d, polls, by = "party") %>%
  mutate(polls_standing_mean = round(mean_polls/ seats,2),
         polls_standing_median = round(median_polls/seats, 2))
rm(polls)
```

### Associative and Competence Issue Ownership

We use the October 2016 panel wave of KiesKompas to measure associative
and competence issue ownership. We measure associative issue ownership
with the question *Which issue comes to your mind when you think about
<party>?*. We measure competence issue ownership with the question *do
you agree or disagree with <party> on the issue you associated with the
party?*. For each question, the respective issue ownership variables
will be measured by summation over the
respondents.

``` r
aio <- read_sav("../../data/raw/Netherlands+survey+October+2016.sav") %>%
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
d <- left_join(d, aio, by = "id") 
rm(aio, associate_io)
```

``` r
data <- read_sav("../../data/raw/Netherlands+survey+October+2016.sav") %>%
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
rm(sgp, data, io)

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

d <- left_join(d, cio, by = "id")
rm(cio)
```

## Save Data for Analysis

``` r
save(d, file = "../../data/intermediate/cleaned_data.RData")
```

## Visualization of Data
