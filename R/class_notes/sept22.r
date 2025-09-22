library(tidyverse)
library(mdsr)

cia <- CIACountries
data("CIACountries")

cia %>% 
  glimpse()

cia %>% 
  select(country, pop, oil_prod) %>% 
  head()

cia %>% 
  select(-country)

cia %>% 
  filter(pop > 1000000000) %>% 
  select(country, pop, gdp)
## how to select everything
cia %>% 
  select(everything())
## how to select everything
cia %>% 
  select_all()

## how many missing oil prod countries with their gdp
cia %>% 
  filter(is.na(oil_prod)) %>% 
  select(country, oil_prod, gdp)

cia %>% 
  select(-educ)


cia <- cia %>% 
  mutate(dens = pop/area)


### create new variable for categorizing oil production
summary(cia$oil_prod)

cia <- cia %>% 
  mutate(oil_level = case_when(
    oil_prod == 0 ~ "none",
    oil_prod > 0 & oil_prod < 50000 ~ "small",
    oil_prod >= 50000 ~ "large",
    .default = "missing"
  ))

cia %>% 
  group_by(oil_level) %>% 
  summarise(n = n(),
            mean_gdp = mean(gdp, na.rm = TRUE),
            mean_area = mean(area, na.rm = TRUE))

cia %>% 
  group_by(oil_level) %>% 
  count()

#What proportion of countries produce 
## any oil stratified by net users class?
cia %>% 
  tibble() %>% 
  mutate(any_oil = ifelse(oil_prod != 0, 1, 0)) %>% 
  group_by(any_oil, net_users) %>% 
  count()
