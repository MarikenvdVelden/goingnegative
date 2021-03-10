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