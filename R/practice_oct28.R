library(tidyverse)

tibble(sentences) %>% 
  mutate(len = str_length(sentences)) %>% 
  summary(len)

tibble(sentences) %>% 
  mutate(comma = str_detect(sentences, "\\,")) %>% 
  summarise(sum(comma))

tibble(sentences) %>% 
  mutate(ts = str_extract_all(sentences, "t")) %>%
  unnest(ts) %>% 
  group_by(sentences) %>% 
  summarise(total_t = n()) %>% 
  arrange(-total_t)
  


tibble(sentences) %>% 
  mutate(ts = str_extract_all(sentences, "t"),
         len = map_dbl(ts, ~ length(.))) %>% 
  filter(len == 0)


library(babynames)


babynames %>% 
  mutate(periods = cut(year, 7)) %>% 
  group_by(periods) %>% 
  mutate(periods = str_c(min(year), "-", max(year))) %>% 
  group_by(periods, sex, name) %>% 
  summarise(total_use = sum(n)) %>% 
  slice_max(order_by = total_use, n = 20) %>% 
  mutate(first_letter = str_sub(name, end = 1)) %>% 
  ggplot(aes(first_letter, fill = sex)) +
  geom_bar(position = "dodge") +
  facet_wrap(~ periods)

babynames %>% 
  mutate(first_letter = str_to_lower(str_sub(name, end = 1)),
         second_letter = str_sub(name, start = 2, end =2)) %>% 
  mutate(vowels1 = str_detect(first_letter, "[aeiou]"),
         vowels2 = str_detect(second_letter, "[aeiou]")) %>% 
  filter(vowels1 == T & vowels2 == T) %>% 
  group_by(name) %>% 
  count() %>% view()
