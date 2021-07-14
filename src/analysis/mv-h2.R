h2_1 <- run_specs(df = df,
                  y = c("negative_appeals"),
                  x = c("polls1","polls2","polls3","polls4",
                        "polls5","polls6","polls7","polls8",
                        "polls9"),
                  controls = c("ie1","ie2","ie3","ie4","ie5","ie6",
                               "ie7","ie8",
                               "io1","io2","io3","io4"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group1)))

h2_2 <- run_specs(df = df, 
                  y = c("negative_appeals"),
                  x = c("polls1","polls2","polls3","polls4",
                        "polls5","polls6","polls7","polls8",
                        "polls9"),
                  controls = c("ie1","ie2","ie3","ie4","ie5","ie6",
                               "ie7","ie8",
                               "io1","io2","io3","io4"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group2)))

h2_3 <- run_specs(df = df,
                  y = c("negative_appeals"),
                  x = c("polls1","polls2","polls3","polls4",
                        "polls5","polls6","polls7","polls8",
                        "polls9"),
                  controls = c("ie1","ie2","ie3","ie4","ie5","ie6",
                               "ie7","ie8",
                               "io1","io2","io3","io4"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group3)))

h2_1 <- h2_1 %>% 
  mutate(id = "Daily Average",
         id2 = 1:dim(h2_1)[1]) %>%
  filter(subsets != "all")
h2_2 <- h2_2 %>% 
  mutate(id = "Daily Sum ",
         id2 = 1:dim(h2_2)[1]) %>%
  filter(subsets != "all")
h2_3 <- h2_3 %>% 
  mutate(id = "Deviation from Daily Average",
         id2 = 1:dim(h2_3)[1]) %>%
  filter(subsets != "all")

h2 <- h2_1 %>% 
  add_row(h2_2) %>% 
  add_row(h2_3) %>%
  mutate(subsets = recode(subsets,
                          `group1 = 0` = "Journalistic Intervention: Absent",
                          `group1 = 1` = "Journalistic Intervention: Moderate",
                          `group1 = 2` = "Journalistic Intervention: High"),
         x = recode(x,
                    `polls1` = "Polls/Seats",
                    `polls2` = "Polls (First Lag)/Seats", 
                    `polls3` = "Polls (Weekly Average)/Seats",
                    `polls4` = "Polls (Rolling Mean)/Seats",
                    `polls5` = "Polls/Polls (First Lag)",
                    `polls6` = "Polls/Polls (Weekly Average)",
                    `polls7` = "Polls/Polls (Rolling Mean)",
                    `polls8` = "Polls (First Lag)/Polls (Weekly Average)",
                    `polls9` = "Polls (First Lag)/Polls (Rolling Mean)"),
         p = if_else(p.value < 0.05, "p<.05", "p>.05"),
         subsets = factor(subsets,
                          levels = c("Journalistic Intervention: Absent", 
                                     "Journalistic Intervention: Moderate", 
                                     "Journalistic Intervention: High")))

