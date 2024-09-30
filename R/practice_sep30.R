# Load necessary libraries
library(library)
library(mdsr)

# 1. What are the top 5 most populous countries?
# Breakdown: 
# - Arrange the countries in descending order of population.
# - Use `slice_head` to select the top 5 rows.
# - Select only the relevant columns (country, population) for a cleaner output.



# 2. What is the total GDP for countries with more than 1 million population?
# Breakdown: 
# - Filter countries with a population greater than 1 million.
# - Summarize the total GDP for these countries.



# 3. Which country has the highest GDP per capita (GDP/pop)?
# Breakdown:
# - Use `mutate` to create a new column for GDP per capita.
# - Arrange the data by this new column in descending order.
# - Select the top row for the country with the highest GDP per capita.



# 4. Find the average education spending (educ) for countries with internet users > 35%.
# Breakdown:
# - Filter countries based on `net_users` being greater than 35%.
# - Use `summarize` to calculate the average education spending, excluding missing values.


# 5. Add a new column for population density (Population / Area).
# Breakdown:
# - Use `mutate` to create a new column called `pop_density` as the ratio of population to area.
# - Filter out rows with area equal to 0 to avoid division by zero errors.


# 6. What is the total oil production for countries with GDP greater than 10,000?
# Breakdown:
# - Filter countries with GDP greater than 10,000.
# - Use `summarize` to calculate the total oil production for these countries.



# 7. How many countries have more than 60% internet users?
# Breakdown:
# - Use `filter` to select countries where `net_users` is ">60%".
# - Use `n()` in `summarize` to count how many countries meet this condition.



