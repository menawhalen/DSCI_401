library(tidyverse)
library(infer)


batting <- read_csv("data/Batting.csv")
people <- read_csv("data/People.csv")

people %>% 
  select(playerID, birthDate, debut, finalGame) %>% 
  right_join(batting) %>% 
  mutate(bday_year = year(ymd(birthDate)),
         debut_year = year(ymd(debut)),
         final_year = year(ymd(finalGame))) %>% 
  mutate(current_age = case_when(
    yearID > final_year ~ NA,
    yearID >= debut_year & yearID <= final_year ~ yearID - bday_year,
    yearID < debut_year ~NA
  )) %>% 
  select(playerID, HR, current_age) %>% 
  mutate(old = factor(ifelse(current_age < 32, "young", "old"), level = c("young", "old"))) %>% 
  specify(HR ~ old) %>% 
  calculate(stat = "diff in means", order = c("young", "old"))
  
  
