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