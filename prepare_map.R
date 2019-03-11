library(tidyverse)

# Load datasets
directory <- read.csv("data/directory.csv", stringsAsFactors = F)
abbr <- read.csv("data/wikipedia-iso-country-codes.csv", stringsAsFactors = F) %>% 
  rename("Country" = "Alpha.2.code",
         "country_name" = "English.short.name.lower.case")

# Joint the datasets
directory <- directory %>% 
  left_join(abbr, by = "Country")

# Create discrete values
select_values <- unique(directory$country_name)

# all types of ownerships
ownerships <- directory %>%
  select(Ownership.Type) %>%
  distinct() %>%
  pull(Ownership.Type)

# sanity check
directory %>%
  filter(Ownership.Type == "Licensed",
         Country == "US") %>%
  nrow()
