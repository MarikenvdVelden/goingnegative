descr <- df %>%
  select(negative_appeals:l_negative_appeal) %>%
  pivot_longer(cols = everything()) %>%
  group_by(name) %>%
  summarise(means = mean(value, na.rm = T),
            stdev = sd(value, na.rm = T),
            minvalue = min(value, na.rm = T),
            maxvalue = max(value, na.rm = T)) %>%
  ungroup() %>%
  mutate(name = recode(name,
                       `negative_appeals` = "Negative Appeals",
                       `l_negative_appeal` = "Negative Appeals (First lag)",
                       `ji1` = "Journalistic Intervenience (Daily Average)",
                       `ji2` = "Journalistic Intervenience (Daily Sum)",
                       `ji3` = "Journalistic Intervenience (Deviation from Daily Average)",
                       `polls1`  = "Polls/Seats",
                       `polls2`  = "Polls (First Lag)/Seats",
                       `polls3`  = "Polls (Weekly Average)/Seats",
                       `polls4`  = "Polls (Rolling Mean)/Seats",
                       `polls5`  = "Polls/ Polls (First Lag)",
                       `polls6`  = "Polls/ Polls (Weekly Average)",
                       `polls7`  = "Polls/ Polls (Rolling Mean)",
                       `polls8`  = "Polls (First Lag)/(Weekly Average)",
                       `polls9`  = "Polls (First Lag)/(Rolling Mean)",
                       `io1` = "Associative Issue Ownership",
                       `io2` = "Competence Issue Ownership (Mean)",
                       `io3` = "Competence Issue Ownership (Median)",
                       `io4` = "Competence Issue Ownership (Standard Deviation)",
                       `ie1` = "Ideological Extremity: Mean (CHES 2017)",
                       `ie2` = "Ideological Extremity: Median (CHES 2017)",
                       `ie3` = "Ideological Extremity: Mean (CHES 2014)",
                       `ie4` = "Ideological Extremity: Median (CHES 2014)",
                       `ie5` = "Ideological Extremity: Mean (MP 2017)",
                       `ie6` = "Ideological Extremity: Median (MP 2017)",
                       `ie7` = "Ideological Extremity: Mean (MP 2012)",
                       `ie8` = "Ideological Extremity: Median (MP 2012)"))

