data <- NHANES::NHANES


ggplot(data, aes(Gender, Age)) +
  geom_boxplot()


ggplot(data, aes(Race1, fill = Education)) +
  geom_bar(position = "fill")

ggplot(data, aes(Race1, fill = Education)) +
  geom_bar(position = "dodge")


ggplot(CIACountries, aes(x = area, y = pop, color = net_users)) +
  geom_point() +
  facet_wrap(~net_users, scales = "free")


ggplot(data = SAT_2010, aes(pupil_teacher_ratio, salary)) +
  geom_point()

library(tidyverse)
summary(SAT_2010$pupil_teacher_ratio)
SAT_2010 %>% 
  mutate(ratio_level = cut(
    pupil_teacher_ratio,
    breaks = c(11,13,15,25),
    labels = c("low", "mid", "high")
  )) %>% 
  ggplot(aes(ratio_level, sat_pct)) +
  geom_boxplot() +
  theme_gray()
  