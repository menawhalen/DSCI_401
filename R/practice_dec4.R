library(tidyverse)
library(sf)


rides <- read_csv("midterm/data/CTA_ridership.csv")
stops <- read_csv("midterm/data/CTA_stops.csv")

comm_area <- st_read("R/sf/shapefiles/comm_areas.shp")


### place each stop on the map

ggplot(comm_area) +
  geom_sf() +
  theme_void()

max_rides <- rides %>% 
  group_by(station_id) %>% 
  summarise(max_ride = max(rides))

stops %>% 
  mutate(lat = str_remove(str_split_i(Location, ",", 1), "\\("),
         long = str_remove(str_split_i(Location, ",", 2), "\\)")) %>% 
  st_as_sf(coords = c("long", "lat"), crs = st_crs(comm_area)) %>% 
  select(STATION_NAME, MAP_ID) %>% 
  distinct() %>% 
  left_join(max_rides, by = c("MAP_ID" = "station_id")) %>% 
  st_as_sf() %>% 
  ggplot() +
  geom_sf(data = comm_area, fill = NA) +
  geom_sf(aes(color = max_ride)) +
  viridis::scale_color_viridis() +
  theme_void()
######################################
## sql

q <- "SELECT t.title, t.production_year, cn.name
FROM cast_info ci
JOIN title t ON ci.movie_id = t.id
JOIN char_name cn ON cn.id = ci.person_role_id
WHERE ci.person_id = 2977372
  AND t.kind_id = 1
  AND ci.role_id = 2
ORDER BY production_year;"


q <- "SELECT cn.name, COUNT(cn.name) AS n, ROUND(t.production_year, -1) AS decade
FROM cast_info ci
JOIN title t ON ci.movie_id = t.id
JOIN char_name cn ON cn.id = ci.person_role_id
GROUP BY decade, cn.name
ORDER BY n DESC
LIMIT 10
;"

db %>% 
  dbGetQuery(q)
