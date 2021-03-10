aio <- read_sav(here("data/raw-private/KiesKompas-data-Oct-2016.sav")) %>%
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