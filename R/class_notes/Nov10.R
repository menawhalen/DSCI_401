library(tidyverse)
library(broom)
people <- read_csv("data/People.csv")
#teams <- read_csv("data/Teams.csv")
batting <- read_csv("data/Batting.csv")


full_joined <- batting %>% 
  left_join(people, by = c("playerID")) %>% 
  mutate(age = yearID- birthYear)

mod <- full_joined %>% 
  group_by(teamID, birthState) %>% 
  nest() %>%
  mutate(people_count = map_dbl(data, \(x) nrow(x))) %>% 
  filter(people_count > 100) %>% 
  mutate(model = map(data, \(x) lm(HR ~ R + age + SB, data = x)),
         output = map(model, tidy)) 

mod %>% 
  unnest(cols = output) %>% 
  filter(term == "age") %>% 
  group_by( birthState) %>% 
  summarise(min = min(estimate),
            max = max(estimate),
            count = n()) %>% view()


### 
teams <- read_csv("data/Teams.csv")

team_change_ballpark <- teams %>% 
  filter(yearID > 1999 & yearID < 2020) %>% 
  group_by(franchID) %>% 
  filter(n_distinct(park) > 1) %>% 
  group_by(franchID) %>% 
  nest()

team_change_ballpark %>% 
  mutate(change_park = map(data, \(x) x %>% 
                             group_by(park) %>%
                             tally())) %>% 
  #unnest(cols = change_park) %>% 
  #filter(n != 1) %>% 
  mutate(diff = map(data, \(x) x %>% 
                      group_by(park) %>% 
                      summarise(mean = mean(attendance),
                                min = min(yearID),
                                max = max(yearID)))) %>% 
  unnest(cols = diff) %>% view()
