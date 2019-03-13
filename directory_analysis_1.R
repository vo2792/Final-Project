library(dplyr)
library(maps)
library(leaflet)
library(shiny)

source("read_data.R")

# most Starbucks in the world
most_location <- directory %>%
  group_by(Country) %>%
  summarise(num_stores = n()) %>%
  arrange(-num_stores)

# secure the top list
found_top <- most_location %>% top_n(1)

# the country that has the most Starbucks store
max_location <- found_top %>% pull(Country)

# the number of Starbucks locations in the country found above
max_stores_num <- found_top %>% pull(num_stores)

###### TEST CASE ######
# observe each country's number of starbucks
# and provide the informations of each store
by_country <- function(country) {
  selected <- directory %>%
    filter(Country == country)
}

# test country
Msia <- by_country("MY")
Korea <- by_country("KR")

###### Shiny Version ######
## try shiny version -- SORRY I DID IT IN testlocal directory
filtered <- directory %>%
  filter(Country == input$search)
leaflet(data = filtered) %>%
  addTiles() %>%
  addMarkers(lat = ~Latitude, lng = ~Longitude)
