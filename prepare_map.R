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

# total number of stores
totalnum <- directory %>%
  nrow()

# number of stores by world
rank_world <- rank_func("Country")

rank_world <- rank_world %>%
  left_join(abbr, by = "Country")
rank_world <- rank_world %>%
  select(country_name, totalstores)

rank_world[is.na(rank_world$country_name), 1] <- "Curaçao"

# number of countries
num_coun <- rank_world %>% nrow()

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

# HTML scripts
my_str <- paste0("<p>Starbucks is growing strong! As of 2017, it has 
             <strong>", totalnum, "</strong> recorded
locations worldwide, spreading across <strong>", num_coun,"</strong>
  countries. For the sake of tidiness,<br>
  the tables shown below are limited to only display the top
ten countries and cities that have the most Starbucks stores
respectively. <em>USA</em> stays on <br>
  top of the record for having <strong>13608</strong> stores,
followed by <em>China</em> where it has <strong>2734</strong>
  stores across the country. For what's not shown on the table, <br>
             <em>Andorra</em> has only <strong>1</strong> Starbucks location
             across the country. Another interesting side to look at is
             the number of stores each city has. <br>
             <em>Shanghai</em> tops the list by having <strong>542</strong>
             stores. In the meantime, there are <em>2653 cities</em>
             with only <strong>1</strong> Starbucks store.</p>")
