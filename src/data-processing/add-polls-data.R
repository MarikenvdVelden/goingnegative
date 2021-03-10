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