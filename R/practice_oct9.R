library(tidyverse)
library(nycflights13)
## Q1
flights %>% 
  group_by(carrier) %>% 
  summarise(tot_delay_dep = sum(dep_delay, na.rm = T),
            tot_delay_arr = sum(arr_delay, na.rm = T),
            mean_dep = mean(dep_delay, na.rm = T),
            mean_arr = mean(arr_delay, na.rm = T)) %>% 
  left_join(airlines) %>% 
  select(-carrier) %>% 
  arrange(mean_arr)
## Q2

flights %>% 
  group_by(origin, dest) %>% 
  count() %>% 
  left_join(airports, by = c("dest" = "faa")) %>% 
  select(origin, name, n) %>% 
  arrange(-n)

library(spData)
library(sf)

flights %>% 
  group_by(origin, dest) %>% 
  count() %>% 
  left_join(airports, by = c("dest" = "faa")) %>%
  filter(!is.na(lat)) %>% ## remove cause can't be spatial with missin
  st_as_sf(coords = c("lon", "lat"), crs = st_crs(us_states)) %>% ## makes long and lat into info
  ggplot() +
  geom_sf(data = us_states, fill = NA) +
  geom_sf(aes(color = n)) +
  viridis::scale_color_viridis() +
  xlim(c(-130, -60)) +
  theme_void() +
  labs(title = "NYC Flight Destimation by Volume",
       color = "Total Flights to Location")
