df <- d %>%
  mutate(negative_appeal = ifelse(direction_appeal=="Negative Appeal",
                                  1,0)) %>%
  group_by(party, date) %>%
  summarise(negative_appeals = n(),
            polls1 = mean(poll_standing1, na.rm = T),
            polls2 = mean(poll_standing2, na.rm = T),
            polls3 = mean(poll_standing3, na.rm = T),
            polls4 = mean(poll_standing4, na.rm = T),
            polls5 = mean(poll_standing5, na.rm = T),
            polls6 = mean(poll_standing6, na.rm = T),
            polls7 = mean(poll_standing7, na.rm = T),
            polls8 = mean(poll_standing8, na.rm = T),
            polls9 = mean(poll_standing9, na.rm = T),
            io1 = mean(aio_percentage, na.rm = T),
            io2 = mean(cio_mean, na.rm = T),
            io3 = mean(cio_median, na.rm = T),
            io4 = mean(cio_sd, na.rm = T),
            ie1 = mean(ie_median_ches2017, na.rm = T),
            ie2 = mean(ie_mean_ches2017, na.rm = T),
            ie3 = mean(ie_median_ches2014, na.rm = T),
            ie4 = mean(ie_mean_ches2014, na.rm = T),
            ie5 = mean(ie_median_cmp2017, na.rm = T),
            ie6 = mean(ie_mean_cmp2017, na.rm = T),
            ie7 = mean(ie_median_cmp2012, na.rm = T),
            ie8 = mean(ie_mean_cmp2012, na.rm = T),
            ji1  = mean(journalistic_intervenience, na.rm = T),
            ji2 = sum(journalistic_intervenience),
            ji3 = ji2-ji1
  ) %>%
  mutate(opposition = ifelse(party == "VVD", 0,
                             ifelse(party == "PvdA", 0, 1)),
         new_party = ifelse(party == "FvD", 1, 0),
         ie3 = ifelse(party == "FvD", 0, ie3),
         ie4 = ifelse(party == "FvD", 0, ie4),
         ie7 = ifelse(party == "FvD", 0, ie7),
         ie8 = ifelse(party == "FvD", 0, ie8),
         group1 = ifelse(ji1<=.2, 0,
                         ifelse(ji1>.2 & ji1<=.5, 1, 2)),
         group2 = ifelse(ji2<=.5, 0,
                         ifelse(ji2>.5 & ji2<=3, 1, 2)),
         group3 = ifelse(ji3<=.5, 0,
                         ifelse(ji3>.5 & ji3<=3, 1, 2))) %>%
  ungroup()

df <- slide(data = df, Var = "negative_appeals", TimeVar = "date",
            GroupVar = "party", NewVar = "l_negative_appeal", 
            slideBy = -1)