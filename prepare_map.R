library(tidyverse)

# Load datasets
directory <- read.csv("data/directory.csv", stringsAsFactors = F)
abbr <- read.csv("data/wikipedia-iso-country-codes.csv", stringsAsFactors = F) %>%
  rename("Country" = "Alpha.2.code",
         "country_name" = "English.short.name.lower.case")

# Joint the datasets
directory <- directory %>%
  left_join(abbr, by = "Country")

rank_func <- function(select_col) {
  target_col <- rlang::sym(select_col)
  ranking <- directory %>%
    group_by(!!target_col) %>%
    summarise(totalstores = n()) %>%
    select(select_col, totalstores) %>%
    arrange(-totalstores)
}

# number of stores by world
rank_world <- rank_func("Country")

rank_world <- rank_world %>%
  left_join(abbr, by = "Country")
rank_world <- rank_world %>%
  select(country_name, totalstores)

rank_world[is.na(rank_world$country_name), 1] <- "Curaçao"

# number of stores by city
rank_city <- rank_func("City")

total_for_each_num <- rank_city %>%
  group_by(totalstores) %>%
  summarise(how_many = n())

city_with_one_store <-
  total_for_each_num[total_for_each_num$totalstores == "1", "how_many"]

# Create discrete values
select_values <- unique(directory$country_name)

# all types of ownerships
ownerships <- unique(directory$Ownership.Type)

# sanity check
# directory %>%
#   filter(Ownership.Type == "Licensed",
#          Country == "US") %>%
#   nrow()
