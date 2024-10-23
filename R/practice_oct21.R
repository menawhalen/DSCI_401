library(tidyverse)
library(palmerpenguins)

penguins %>% 
  pivot_longer(cols = c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g), names_to = "measurement", values_to = "value")

penguins %>% 
  pivot_longer(cols = c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g), names_to = "measurement", values_to = "value") %>% 
  group_by(species, measurement) %>% 
  summarise(mean(value, na.rm = T))

penguins %>% 
  pivot_longer(cols = c(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g), names_to = "measurement", values_to = "value") %>% 
  ggplot(aes(species, value)) +
  geom_boxplot() +
  facet_wrap(~measurement, scales = "free_y")


library(babynames)
babynames %>% 
  filter(name == "Micah" | name == "Maya" | name == "Mena") %>% 
  group_by(name, sex) %>% 
  summarise(min = min(year),
            max = max(year),
            ave = mean(n))

babynames %>% 
  filter(name == "Micah" | name == "Maya" ) %>%
  ggplot(aes(year, n, color = name)) +
  geom_line(aes(linetype = sex))

babynames %>% 
  group_by(name, sex) %>% 
  summarise(total = sum(n)) %>% 
  pivot_wider(id_cols = name, names_from = sex, values_from = total, values_fill = 0) %>% 
  mutate(total_use = M+F,
         prop = M/total_use) %>% 
  filter(prop == 0.5) %>% 
  arrange(-total_use) %>% view()


babynames %>% 
  group_by(name, sex) %>% 
  summarise(total = sum(n)) %>% 
  pivot_wider(id_cols = name, names_from = sex, values_from = total, values_fill = 0) %>% 
  mutate(total = M+F,
         prop = M/total) %>% 
  filter(prop == 0.5) %>% 
  arrange(-total) %>% view()

babynames %>% 
  filter(name %in% c("Amelia", "Benjamin", "Colin")) %>% 
  ggplot(aes(year, n, color = name)) +
  geom_line(aes(linetype = sex))


babynames %>% 
  filter(year %in% 1880:1915) %>% 
  group_by(name, sex) %>% 
  summarise(total = sum(n)) %>% 
  arrange(-total) %>% view()

babynames %>% 
  filter(name == "Ximena") %>% 
  ggplot(aes(year, n, group = sex, color = sex)) +
  geom_line()
