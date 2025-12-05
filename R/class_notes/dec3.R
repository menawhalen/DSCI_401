library(tidyverse)
library(Lahman)
people <- read_csv("data/People.csv")
batting <- read_csv("data/Batting.csv")


ggp <- people %>% 
  mutate(birthDate = ymd(birthDate),
         day = wday(birthDate, label = T)) %>% 
  left_join(batting, by = "playerID") %>% 
  group_by(teamID) %>% 
  nest() %>% 
  mutate(plot_day = map(data, ~ ggplot(data = .x, aes(x = day)) +
                         geom_bar(stat = "count")))

ggp[1,3][[1]]




people %>% 
  mutate(birthDate = ymd(birthDate),
         day = wday(birthDate, label = T)) %>% 
  left_join(batting, by = "playerID") %>% 
  group_by(teamID,day) %>% 
  count()
