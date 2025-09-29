cubs_data <- read.csv("data/cubs_all_time.csv")
## how many team names
unique(cubs_data$Tm)
table(cubs_data$Tm)
## chicago orphans ???
cubs_data[cubs_data$Tm == "Chicago Orphans", c("Year", "Tm")]
## goes from when to when?
cubs_data[cubs_data$Tm == "Chicago Orphans", ]$Year #1897 - 1902
### chicago colts??
cubs_data[cubs_data$Tm == "Chicago Colts", c("Year", "Tm")]
cubs_data[cubs_data$Tm == "Chicago Colts", ]$Year
#so 1890 to 1897

## how many leagues are they in?
unique(cubs_data$Lg)
## 3 leagues
###old league
min(cubs_data[cubs_data$Lg == "NL", ]$Year)
max(cubs_data[cubs_data$Lg == "NL", ]$Year)
## modern league
min(cubs_data[cubs_data$Lg == "NL Central", ]$Year)
max(cubs_data[cubs_data$Lg == "NL Central", ]$Year)
##
min(cubs_data[cubs_data$Lg == "NL East", ]$Year)
max(cubs_data[cubs_data$Lg == "NL East", ]$Year)
