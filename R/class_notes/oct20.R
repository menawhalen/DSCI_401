### coding stops and rides 
## to ask join questions
library(tidyverse)


station_stops <- stops %>% 
  select(-stop_id) %>% ## remove these they are just duplicating
  distinct() %>% ## removed those duplication by direction
  filter(value) ### returns only the true ones


station_stops %>% 
  group_by(line) %>% 
  count() %>% 
  ggplot(aes(line, n, fill = line)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("red" = "red",
                                "blue" = "blue",
                                "brn" = "brown",
                                "pnk" = "pink",
                                "g" = "green",
                                "p"= "purple",
                                "o" = "orange",
                                "y" = "yellow",
                                "pexp" = "mediumorchid")) 

rides %>% 
  left_join(station_stops, by = c("stationname" = "station_name")) %>% 
  filter(is.na(line)) %>% 
  group_by(stationname) %>% 
  count()
## those that aren't matching are directions like north south lines

## another way
rides %>% 
  anti_join(station_stops, by = c("stationname" = "station_name")) %>% 
  group_by(stationname) %>% 
  count()
### same
