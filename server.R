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
  
  # render the second object defined in tab two
  ## todo:
  ## output$SOME_NAME_TWO <-
  filtered2 <- reactive({
    if(input$drink == "All") {
      drinks %>% 
        select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
    }
    else {
      drinks %>% 
        filter(Beverage_Category == input$drink) %>% 
        select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
    }
  })
  
  output$table <- renderDataTable({
    filtered2()
  })
  
  # render the third object defined in tab three
  ## todo:
  ##output$SOME_NAME_THREE <-
  filtered3 <- reactive({
    ifelse(
      input$choice == "All", 
      food,
      food %>% 
        filter(Food == input$choice) 
    )
    food %>% 
      select(Food, input$specify)
  })
  
  output$table2 <- renderDataTable({
    filtered3()
  })
  
  output$bargraph3 <- renderPlot({
    filtered_data <- filter(caffeine_data_num, Beverage_Category == input$drink_type)
    ggplot(data = filtered_data) +
      geom_col(mapping = aes(
        x = Beverage, y = num_expresso_shot,
        fill = Beverage
      )) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      labs(
        title = paste(
          "Amount of Caffeine Measured in Expresso Shots for", input$drink_type
        ), # plot title
        x = input$drink_type, # x-axis label
        y = "Amount of Caffeine Measured in Expresso Shots"
      )
    
  })
  output$table4 <- renderDataTable({
    select(caffeine_varies, Beverage_Category, Beverage)
  })
  
  output$bar_graph5 <- renderPlot({
    ggplot(data = avg_caffeine) +
      geom_col(mapping = aes(
        x = Beverage_Category, y = avg_expresso_shot,
        fill = Beverage_Category
      )) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      labs(
        title = paste(
          "Average Amount of Caffeine Measured in Shots for Each Beverage Category"
        ), # plot title
        x = "Beverage Categories", # x-axis label
        y = "Amount of Caffeine Measured in Shots " # y-axis label
      )
  })
})

