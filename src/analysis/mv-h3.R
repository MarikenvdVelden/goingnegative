h3_1 <- run_specs(df = df,
                  y = c("negative_appeals"), 
                  x = c("ie1","ie2","ie3","ie4","ie5","ie6",
                        "ie7","ie8"),
                  controls = c("polls1","polls2","polls3","polls4",
                               "polls5","polls6","polls7","polls8",
                               "polls9",
                               "io1","io2","io3","io4"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group1))) 

h3_2 <- run_specs(df = df,
                  y = c("negative_appeals"), 
                  x = c("ie1","ie2","ie3","ie4","ie5","ie6",
                        "ie7","ie8"),
                  controls = c("polls1","polls2","polls3","polls4",
                               "polls5","polls6","polls7","polls8",
                               "polls9",
                               "io1","io2","io3","io4"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group2))) 

h3_3 <- run_specs(df = df,
                  y = c("negative_appeals"),
                  x = c("ie1","ie2","ie3","ie4","ie5","ie6",
                        "ie7","ie8"),
                  controls = c("polls1","polls2","polls3","polls4",
                               "polls5","polls6","polls7","polls8",
                               "polls9",
                               "io1","io2","io3","io4"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group3))) 


h3_1 <- h3_1 %>% 
  mutate(id = "Daily Average",
         id2 = 1:dim(h3_1)[1]) %>%
  filter(subsets != "all")
h3_2 <- h3_2 %>% 
  mutate(id = "Daily Sum ",
         id2 = 1:dim(h3_2)[1]) %>%
  filter(subsets != "all")
h3_3 <- h3_3 %>% 
  mutate(id = "Deviation from Daily Average",
         id2 = 1:dim(h3_3)[1]) %>%
  filter(subsets != "all")

h3 <- h3_1 %>% 
  add_row(h3_2) %>% 
  add_row(h3_3) %>%
  mutate(subsets = recode(subsets,
                          `group1 = 0` = "Journalistic Intervention: Low",
                          `group1 = 1` = "Journalistic Intervention: Medium",
                          `group1 = 2` = "Journalistic Intervention: High"),
         subsets = factor(subsets,
                          levels = c("Journalistic Intervention: Low", "Journalistic Intervention: Medium", "Journalistic Intervention: High")),
         x = recode(x,
                    `ie1` = "Mean (CHES 2017)",
                    `ie2` = "Median (CHES 2017)",
                    `ie3` = "Mean (CHES 2014)",
                    `ie4` = "Median (CHES 2014)",
                    `ie5` = "Mean (MP 2017)",
                    `ie6` = "Median (MP 2017)",
                    `ie7` = "Mean (MP 2012)",
                    `ie8` = "Median (MP 2012)"))
