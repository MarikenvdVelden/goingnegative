
data <- read_sav(here("data/raw-private/KiesKompas-data-Oct-2016.sav")) %>%
  zap_labels()

for(i in 1:19){
  if(i==1){cda <- get_cio(data = data, var1= "Q14", var2 = "Q15", 
                          var3 = "Q13_1_1", var4 = "Q13_2_1",
                          issue = i, party = "CDA")}
  else{cda <- rbind(cda, get_cio(data = data, var1= "Q14", var2 = "Q15", 
                                 var3 = "Q13_1_1", var4 = "Q13_2_1",
                                 issue = i, party = "CDA"))}
}

for(i in 1:19){
  if(i==1){pvda <- get_cio(data = data, var1= "Q16", var2 = "Q17", 
                           var3 = "Q13_1_2", var4 = "Q13_2_2",
                           issue = i, party = "PvdA")}
  else{pvda <- rbind(pvda, get_cio(data = data, var1= "Q16", var2 = "Q17", 
                                   var3 = "Q13_1_2", var4 = "Q13_2_2",
                                   issue = i, party = "PvdA"))}
}

cio <- rbind(cda, pvda)
rm(cda, pvda)

for(i in 1:19){
  if(i==1){sp <- get_cio(data = data, var1= "Q18", var2 = "Q19", 
                         var3 = "Q13_1_3", var4 = "Q13_2_3",
                         issue = i, party = "SP")}
  else{sp <- rbind(sp, get_cio(data = data, var1= "Q18", var2 = "Q19", 
                               var3 = "Q13_1_3", var4 = "Q13_2_3",
                               issue = i, party = "SP"))}
}
cio <- rbind(cio, sp)
rm(sp)

for(i in 1:19){
  if(i==1){vvd <- get_cio(data = data, var1= "Q20", var2 = "Q21", 
                          var3 = "Q13_1_4", var4 = "Q13_2_4",
                          issue = i, party = "VVD")}
  else{vvd <- rbind(vvd, get_cio(data = data, var1= "Q20", var2 = "Q21", 
                                 var3 = "Q13_1_4", var4 = "Q13_2_4",
                                 issue = i, party = "VVD"))}
}
cio <- rbind(cio, vvd)
rm(vvd)

for(i in 1:19){
  if(i==1){pvv <- get_cio(data = data, var1= "Q22", var2 = "Q23", 
                          var3 = "Q13_1_5", var4 = "Q13_2_5",
                          issue = i, party = "PVV")}
  else{pvv <- rbind(pvv, get_cio(data = data, var1= "Q22", var2 = "Q23", 
                                 var3 = "Q13_1_5", var4 = "Q13_2_5",
                                 issue = i, party = "PVV"))}
}
cio <- rbind(cio, pvv)
rm(pvv)

for(i in 1:19){
  if(i==1){gl <- get_cio(data = data, var1= "Q24", var2 = "Q25", 
                         var3 = "Q13_1_6", var4 = "Q13_2_6",
                         issue = i, party = "GL")}
  else{gl <- rbind(gl, get_cio(data = data, var1= "Q24", var2 = "Q25", 
                               var3 = "Q13_1_6", var4 = "Q13_2_6",
                               issue = i, party = "GL"))}
}
cio <- rbind(cio, gl)
rm(gl)

for(i in 1:19){
  if(i==1){cu <- get_cio(data = data, var1= "Q26", var2 = "Q27", 
                         var3 = "Q13_1_7", var4 = "Q13_2_7",
                         issue = i, party = "CU")}
  else{cu <- rbind(cu, get_cio(data = data, var1= "Q26", var2 = "Q27", 
                               var3 = "Q13_1_7", var4 = "Q13_2_7",
                               issue = i, party = "CU"))}
}
cio <- rbind(cio, cu)
rm(cu)

for(i in 1:19){
  if(i==1){d66 <- get_cio(data = data, var1= "Q28", var2 = "Q29", 
                          var3 = "Q13_1_8", var4 = "Q13_2_8",
                          issue = i, party = "D66")}
  else{d66 <- rbind(d66, get_cio(data = data, var1= "Q28", var2 = "Q29", 
                                 var3 = "Q13_1_8", var4 = "Q13_2_8",
                                 issue = i, party = "D66"))}
}
cio <- rbind(cio, d66)
rm(d66)

for(i in 1:19){
  if(i==1){pvdd <- get_cio(data = data, var1= "Q30", var2 = "Q31", 
                           var3 = "Q13_1_9", var4 = "Q13_2_9",
                           issue = i, party = "PvdD")}
  else{pvdd <- rbind(pvdd, get_cio(data = data, var1= "Q30", var2 = "Q31", 
                                   var3 = "Q13_1_9", var4 = "Q13_2_9",
                                   issue = i, party = "PvdD"))}
}
cio <- rbind(cio, pvdd)
rm(pvdd)

for(i in 1:19){
  if(i==1){sgp <- get_cio(data = data, var1= "Q32", var2 = "Q33", 
                          var3 = "Q13_1_10", var4 = "Q13_2_10",
                          issue = i, party = "SGP")}
  else{sgp <- rbind(sgp, get_cio(data = data, var1= "Q32", var2 = "Q33", 
                                 var3 = "Q13_1_10", var4 = "Q13_2_10",
                                 issue = i, party = "SGP"))}
}
cio <- rbind(cio, sgp)
rm(sgp, data, i)

cio <- cio %>%
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
                        `21` = "Different"),
         id = paste(party, issue, sep ="-")) %>%
  select(-party, -issue)

d <- left_join(d, cio, by = "id") %>%
  mutate(cio_mean = replace_na(cio_mean, 0),
         cio_median = replace_na(cio_median, 0),
         cio_sd = replace_na(cio_sd, 0))

rm(cio)