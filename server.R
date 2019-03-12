# Load Libraries
library(tidyverse)
library(leaflet)
library(shiny)

source("prepare_map.R")
source("prepare_table.R")

shinyServer(function(input, output) {
  # render the first object defined in tab_one
  ## todo:
  ## output$SOME_NAME_ONE <-
  filtered <- reactive({
    directory <- directory[(directory$Ownership.Type %in% input$check), ]
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
  
  output$rankworld <- renderTable({
    rank_world %>%
      top_n(10) %>%
      rename("Country" = country_name, "Num of Stores" = totalstores)
    }, caption = "Rank by Country")
  
  output$rankcity <- renderTable({
    rank_city %>%
      rename("City" = City, "Num of Stores" = totalstores)
  }, caption = "Rank by City")
  
  # render the second object defined in tab two
  ## todo:
  ## output$SOME_NAME_TWO <-
  filtered2 <- reactive({
    ifelse(
      input$drink == "All", 
      menu,
      menu %>% 
        filter(Beverage_Category == input$drink) %>% 
        select(-Beverage_Category)
    )
    menu %>% 
      select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
  })
  
  output$table <- renderDataTable({
    filtered2()
  })
  
  # render the third object defined in tab three
  ## todo:
  ##output$SOME_NAME_THREE <-
})
