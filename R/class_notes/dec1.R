library(tidyverse)
library(plotly)

rides <- read_csv("midterm/midterm/data/CTA_ridership.csv")

{rides %>% 
  group_by(month = month(mdy(date), label = T, abbr = F), year = year(mdy(date)), daytype) %>% 
  summarise(ave_rides = mean(rides)) %>% 
  mutate(time = ym(str_c(year, " ", month))) %>% 
  ggplot(aes(time, ave_rides, color = daytype)) +
  geom_line()} %>% ggplotly()


