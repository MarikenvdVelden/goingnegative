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