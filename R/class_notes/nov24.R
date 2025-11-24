library(tidyverse)
library(sf)
library(tidygeocoder)

inspections <- read_csv("R/sf/food_inspections.csv") %>% 
  janitor::clean_names() %>% 
  filter(!is.na(longitude))
### read in shapefile
comm_areas <- st_read("R/sf/shapefiles/comm_areas.shp")
## make inspections spatial sf file
## read in crs as same as community areas
inspections_sf <- st_as_sf(inspections, 
                           coords = c("longitude", "latitude"),
                           crs = st_crs(comm_areas))

## join the inspection with the community areas
## spatial join

join <- st_join(inspections_sf, comm_areas, join =  st_within)

join %>% 
  tibble() %>% 
  mutate(results = case_when(
    results == "Fail" ~ "Fail",
    results == "Pass" ~ "Pass",
    results == "Pass w/ Conditions" ~ "Pass",
    .default = NA
  ),
         inspection_type = case_when(
           str_detect(inspection_type, "Canvass") ~ "Canvass",
           str_detect(inspection_type, "Complaint") ~ "Complaint",
           .default = "Other"
         )) %>% 
  group_by(community, year = year(mdy(inspection_date)), inspection_type, results) %>% 
  tally() %>% 
  pivot_wider(id_cols = c(community, year, inspection_type), names_from = results, values_from = n) %>% 
  mutate(perc_pass = Pass/(Fail+Pass+`NA`)) %>% 
  left_join(comm_areas) %>% 
  st_as_sf() %>% 
  ggplot() +
  geom_sf(aes(fill = perc_pass)) +
  facet_grid(inspection_type~year) +
  viridis::scale_fill_viridis()
         

######################
##################
house <-data.frame(address = "1110 W Loyola", city = "Chicago", state = "IL", zip = "60626")

house_sf <- geocode(house, street = address, city = city, state = state, postalcode = zip)


buffer_sf <- st_buffer(st_as_sf(house_sf, coords = c("long", "lat"), crs = st_crs(comm_areas)), dist = 500) 

join_nearby <- st_join(inspections_sf, buffer_sf, join = st_within)

join_nearby <- join_nearby %>% 
  filter(!is.na(address.y)) %>% 
  filter(results == "Fail")


library(tmap)

tm_shape(join_nearby) + 
  tm_basemap("OpenStreetMap") +   
  tm_dots(col = "blue") 
