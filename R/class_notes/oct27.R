library(tidyverse)
library(babynames)


data("babynames")
names(babynames)


babynames %>% 
  group_by(name, sex) %>% 
  summarise(total_name = sum(n)) %>% 
  pivot_wider(names_from = sex, values_from = total_name, values_fill = 0) %>% 
  filter(abs(M-F) < 0.5) %>% 
  arrange(-F)

babynames %>% 
  group_by(name, sex) %>% 
  summarise(total_name = sum(n)) %>% 
  pivot_wider(names_from = sex, values_from = total_name, values_fill = 0) %>% 
  mutate(total = M+F,
         perc = F/total) %>% 
  filter(perc == 0.5) %>% 
  arrange(-total)
  
babynames %>% 
  group_by(name, sex) %>% 
  summarise(total_name = sum(n)) %>% 
  pivot_wider(names_from = sex, values_from = total_name, values_fill = 0) %>% 
  mutate(total = M+F,
         perc = F/total) %>% 
  filter(perc == 1) %>% 
  arrange(-total)

babynames %>% 
  filter(name == "Adolf") %>% 
  group_by(name, year) %>% 
  summarise(total_name = sum(n)) %>% 
  ggplot(aes(year, total_name)) +
  geom_line()

rides <- read_csv("midterm/midterm/data/CTA_ridership.csv")
stops <- read_csv("data/CTA_stops.csv") %>% 
  janitor::clean_names()
glimpse(stops)

stops %>% 
  pivot_longer(cols = red:o, names_to = "line", values_to = "correct") %>% 
  filter(correct) %>% 
  select(direction_id, station_name, map_id, ada, line) %>% ### omg i can join it on rides now
  left_join(rides, by = c("map_id" = "station_id")) %>% 
  mutate(year = year(mdy(date))) %>% 
  group_by(line, year, daytype) %>% 
  summarise(m = mean(rides)) %>% 
  pivot_wider(names_from = year, values_from = m)

stops %>% 
  pivot_longer(cols = red:o, names_to = "line", values_to = "correct") %>% 
  filter(correct) %>% 
  select(direction_id, station_name, map_id, ada, line) %>% ### omg i can join it on rides now
  left_join(rides, by = c("map_id" = "station_id")) %>% 
  mutate(year = year(mdy(date))) %>% 
  group_by(line, year, daytype) %>% 
  summarise(m = mean(rides)) %>% 
  ggplot(aes(year, m, color = line, linetype = daytype)) +
  geom_line() +
  scale_color_manual(values = c("red" = "red",
                                "blue" = "blue",
                                "brn" = "brown",
                                "pnk" = "pink",
                                "g" = "green",
                                "p"= "purple",
                                "o" = "orange",
                                "pexp" = "mediumorchid")) +
  facet_wrap(~daytype)


stops %>% 
  pivot_longer(cols = red:o, names_to = "line", values_to = "correct") %>% 
  filter(correct) %>% 
  select(direction_id, station_name, map_id, ada, line) %>% 
  group_by(map_id, line) %>% 
  summarise(lines = n()) %>% 
  filter(lines <3) %>%  left_join(rides, by = c("map_id" = "station_id")) %>% 
  mutate(year = year(mdy(date))) %>% 
  group_by(line, year, daytype) %>% 
  summarise(m = mean(rides)) %>% 
  ggplot(aes(year, m, color = line, linetype = daytype)) +
  geom_line() +
  scale_color_manual(values = c("red" = "red",
                                "blue" = "blue",
                                "brn" = "brown",
                                "pnk" = "pink",
                                "g" = "green",
                                "p"= "purple",
                                "o" = "orange",
                                "pexp" = "mediumorchid")) +
  facet_wrap(~daytype)
