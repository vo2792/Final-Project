library(tidyverse)

# Load datasets
directory <- read.csv("data/directory.csv", stringsAsFactors = F)
abbr <- read.csv("data/wikipedia-iso-country-codes.csv",
                 stringsAsFactors = F) %>%
  rename("Country" = "Alpha.2.code",
         "country_name" = "English.short.name.lower.case")

# Joint the datasets
directory <- directory %>%
  left_join(abbr, by = "Country")

# function to rank number of stores by country/city
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

##### Setup #####
# number of stores by world
rank_world <- rank_func("Country")
# number of stores by city
rank_city <- rank_func("City")

rank_world <- rank_world %>%
  left_join(abbr, by = "Country")
rank_world <- rank_world %>%
  select(country_name, totalstores)

rank_world[is.na(rank_world$country_name), 1] <- "Curaçao"

# function to select the country/city's number of stores
store_num <- function(attr, cname) {
  if (attr == "country") {
    res <- rank_world$totalstores[rank_world$country_name == cname]
  } else {
    res <- rank_city$totalstores[rank_city$City == cname]
  }
  res
}

# number of countries
num_coun <- rank_world %>% nrow()

# top country
top_country <- rank_world %>%
  top_n(1) %>%
  pull(country_name)

# top country number of stores
num_top_country <- store_num("country", top_country)

# second country
second_country <- rank_world$country_name[2]

# second country number of stores
num_second_country <- store_num("country", second_country)

# country with least Starbucks location
least_country <- rank_world %>%
  arrange(totalstores) %>%
  top_n(-1) %>%
  pull(country_name)

# number of country with least Starbucks location
num_least_country <- store_num("country", least_country)

# number of cities with just one Starbucks location
num_city_one_store <- rank_city %>%
  group_by(totalstores) %>%
  summarise(how_many = n()) %>%
  top_n(1) %>%
  pull(how_many)

# top city number of stores (can't select city name because it's in its
# own language)
num_top_city <- rank_city %>%
  top_n(1) %>%
  pull(totalstores)

# Australia
aus <- rank_world$country_name[rank_world$country_name == "Australia"]

# number of stores in Australia
num_aus <- store_num("country", aus)

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
my_str <-
  paste0("<div class=board>
         <p>
         Starbucks is growing strong! As of 2017, it has <strong>",
         totalnum, "</strong> recorded locations worldwide, spreading across
         <strong>", num_coun, "</strong>countries. For the sake of tidiness,
         <br>
         the tables shown below are limited to only display the top ten
         countries and cities that have the most Starbucks stores respectively.
         <br>
         <em>", top_country, "</em> stays on top of the record for having
         <strong>", num_top_country, "</strong> stores, followed by <em>",
         second_country, "</em> where it has <strong>", num_second_country,
         "</strong> stores across the country.
         <br>
         For what's not shown on the table, <em>", least_country, "</em> has
         only <strong>", num_least_country, "</strong> Starbucks location across
         the country. Another interesting side to look at is the number
         <br>
         of stores each city has. <em>Shanghai</em> tops the list by having
         <strong>", num_top_city, "</strong> stores. In the meantime, there are
         <em>", num_city_one_store, " cities </em> with only <strong>1</strong>
         Starbucks store.
         </p>
         <p>Another interesting fact observed from the dataset is that
         <em>", aus, "</em> despite spanning 2.97 millions square miles
         only has <strong>", num_aus, "</strong> Starbucks's locations,
         <br>
         which may be worth investigating why Starbucks is not expanding
         well in Australia.
         </p>
         <p>
         There are definitely many more things to be explored. Feel free
         to play around with the map and discover your own findings!
         </p>
         </div>")
