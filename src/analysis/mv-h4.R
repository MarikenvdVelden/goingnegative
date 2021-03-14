h4_1 <- run_specs(df = df,
                  y = c("negative_appeals"),
                  x = c("io1","io2","io3","io4"),
                  controls = c("polls1", "polls2", "polls3", "polls4",
                               "ie1","ie2","ie3","ie4","ie5","ie6",
                               "ie7","ie8"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group1))) 

h4_2 <- run_specs(df = df,
                  y = c("negative_appeals"),
                  x = c("io1","io2","io3","io4"),
                  controls = c("polls1", "polls2", "polls3", "polls4",
                               "ie1","ie2","ie3","ie4","ie5","ie6",
                               "ie7","ie8"),                  
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group2))) 

h4_3 <- run_specs(df = df,
                  y = c("negative_appeals"),
                  x = c("io1","io2","io3","io4"),
                  controls = c("polls1", "polls2", "polls3", "polls4",
                               "ie1","ie2","ie3","ie4","ie5","ie6",
                               "ie7","ie8"),
                  model = "glmer_mv",
                  subsets = list(group1 = unique(df$group3))) 

h4_1 <- h4_1 %>% 
  mutate(id = "Daily Average",
         id2 = 1:dim(h4_1)[1]) %>%
  filter(subsets != "all")
h4_2 <- h4_2 %>% 
  mutate(id = "Daily Sum ",
         id2 = 1:dim(h4_2)[1]) %>%
  filter(subsets != "all")
h4_3 <- h4_3 %>% 
  mutate(id = "Deviation from Daily Average",
         id2 = 1:dim(h4_3)[1]) %>%
  filter(subsets != "all")

h4 <- h4_1 %>% 
  add_row(h4_2) %>% 
  add_row(h4_3) %>%
  mutate(subsets = recode(subsets,
                          `group1 = 0` = "Journalistic Intervention: Low",
                          `group1 = 1` = "Journalistic Intervention: Medium",
                          `group1 = 2` = "Journalistic Intervention: High"),
         subsets = factor(subsets,
                          levels = c("Journalistic Intervention: Low", "Journalistic Intervention: Medium", "Journalistic Intervention: High")),
         x = recode(x,
                    `io1` = "Associative Issue Ownership",
                    `io2` = "Competence Issue Ownership (Mean)",
                    `io3` = "Competence Issue Ownership (Median)",
                    `io4` = "Competence Issue Ownership (St.Dev.)"))
