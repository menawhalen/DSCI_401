# Load necessary libraries
library(library)
library(mdsr)

# 1. What are the top 5 most populous countries?
# Breakdown: 
# - Arrange the countries in descending order of population.
# - Use `slice_head` to select the top 5 rows.
# - Select only the relevant columns (country, population) for a cleaner output.

CIACountries %>%
  arrange(desc(pop)) %>%          # Sort countries by population in descending order
  slice(1:5) %>%           # Select the top 5 rows
  select(country, pop)            # Select only the country and population columns

# 2. What is the total GDP for countries with more than 1 million population?
# Breakdown: 
# - Filter countries with a population greater than 1 million.
# - Summarize the total GDP for these countries.

CIACountries %>%
  filter(pop > 1e6) %>%           # Filter for countries with population greater than 1 million
  summarize(total_gdp = sum(gdp, na.rm = TRUE))  # Sum the GDP while ignoring missing values

# 3. Which country has the highest GDP per capita (GDP/pop)?
# Breakdown:
# - Use `mutate` to create a new column for GDP per capita.
# - Arrange the data by this new column in descending order.
# - Select the top row for the country with the highest GDP per capita.

CIACountries %>%
  mutate(gdp_per_capita = gdp / pop) %>%  # Create a new column for GDP per capita
  arrange(desc(gdp_per_capita)) %>%       # Sort by GDP per capita in descending order
  slice(1) %>%                   # Select the top country
  select(country, gdp_per_capita)         # Select only country and gdp_per_capita columns


# 4. Find the average education spending (educ) for countries with internet users > 35%.
# Breakdown:
# - Filter countries based on `net_users` being greater than 35%.
# - Use `summarize` to calculate the average education spending, excluding missing values.

CIACountries %>%
  filter(net_users == ">35%") %>%  # Filter for countries with internet users > 35%
  summarize(avg_educ = mean(educ, na.rm = TRUE))  # Calculate the average education spending

CIACountries %>% 
  group_by(net_users) %>% 
  summarise(ave_edu = mean(educ, na.rm = T))

# 5. Add a new column for population density (Population / Area).
# Breakdown:
# - Use `mutate` to create a new column called `pop_density` as the ratio of population to area.
# - Filter out rows with area equal to 0 to avoid division by zero errors.

CIACountries %>%
  filter(area > 0) %>%                  # Filter out countries with 0 area to avoid division by zero
  mutate(pop_density = pop / area) %>%  # Create a new column for population density
  select(country, pop_density)          # Select the country and population density columns

# 6. What is the total oil production for countries with GDP greater than 10,000?
# Breakdown:
# - Filter countries with GDP greater than 10,000.
# - Use `summarize` to calculate the total oil production for these countries.

CIACountries %>%
  filter(gdp > 10000) %>%           # Filter for countries with GDP greater than 10,000
  summarize(total_oil_prod = sum(oil_prod, na.rm = TRUE))  # Sum oil production, ignoring missing values

# 7. How many countries have more than 60% internet users?
# Breakdown:
# - Use `filter` to select countries where `net_users` is ">60%".
# - Use `n()` in `summarize` to count how many countries meet this condition.

CIACountries %>%
  filter(net_users == ">60%") %>%    # Filter for countries with internet users > 60%
  summarize(num_countries = n())     # Count the number of countries

