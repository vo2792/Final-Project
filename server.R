# Load Libraries
library(tidyverse)
library(leaflet)
library(shiny)

source("prepare_map.R")

shinyServer(function(input, output) {
  # render the first object defined in tab_one
  ## todo:
  ## output$SOME_NAME_ONE <-
  filtered <- reactive({
    directory %>% 
      filter(country_name == input$search) %>% 
      mutate(description = paste("City:<b>", City, "</b><br>",
                                 "Store Name:<b>", Store.Name, "</b><br>"))
  })
  
  output$map <- renderLeaflet({
    starbucks_icon <- makeIcon(iconUrl = "starbucks.png",
                               iconWidth = 30,
                               iconHeight = 30)
    
    leaflet(data = filtered()) %>%
      addTiles() %>%
      addMarkers(lat = ~Latitude, 
                 lng = ~Longitude,
                 icon = starbucks_icon,
                 label = ~lapply(description, HTML),
                 clusterOptions = markerClusterOptions()) 
  })
  
  # render the second object defined in tab two
  ## todo:
  ## output$SOME_NAME_TWO <-
  
  # render the third object defined in tab three
  ## todo:
  ##output$SOME_NAME_THREE <-
})