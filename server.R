# Load Libraries
library(tidyverse)
library(leaflet)
library(shiny)

source("prepare_map.R")
source("prepare_table.R")
source("prepare_food_comparison.R")

shinyServer(function(input, output) {
  # render the first object defined in tab_one
  filtered <- reactive({
    directory <- directory[(directory$Ownership.Type %in% input$check), ]
    directory %>%
      filter(country_name == input$search) %>%
      mutate(description = paste("City:<b>", City, "</b><br>",
                                 "Store Name:<b>", Store.Name, "</b><br>"))
  })

  # visualization of map
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

  # visualization of rank-by-world table
  output$rankworld <- renderTable({
    rank_world %>%
      top_n(10) %>%
      rename("Country" = country_name, "Num of Stores" = totalstores)
    }, caption = "Rank by Country")

  # visualization of rank-by-city table
  output$rankcity <- renderTable({
    rank_city %>%
      top_n(10) %>%
      rename("City" = City, "Num of Stores" = totalstores)
  }, caption = "Rank by City")

  # render the second object defined in tab two
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
  filtered3 <- reactive({
    if(input$choice == "All") {
      food %>%
        select(Food, input$specify)
    } else {
      food %>%
        filter(Food == input$choice) %>%
        select(Food, input$specify)
    }
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
      labs(
        title = paste(
          "Amount of Caffeine Measured in Expresso Shots for", input$drink_type
        ), # plot title
        x = input$drink_type, # x-axis label
        y = "Amount of Caffeine Measured in Expresso Shots"
      ) +
      ggthemes::theme_solarized() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) 

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
      labs(
        title = paste(
          "Average Amount of Caffeine Measured in Shots for Each Beverage Category"
        ), # plot title
        x = "Beverage Categories", # x-axis label
        y = "Amount of Caffeine Measured in Shots " # y-axis label
      ) +
      ggthemes::theme_solarized() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
  
  # render the fourth object defined in tab three
  filtered4 <- reactive({
    foods <- foods %>% filter(Food == input$food_1 | Food == input$food_2)
    foods
  })

  output$food <- renderPlot({
    filtered4() %>%
      ggplot(aes_string(x = "Food", y = input$nutrition)) +
      geom_col(fill = "dark green", width = 0.3) +
      ggthemes::theme_solarized() +
      labs(x = "")
  })

  output$boxplot <- renderPlot({
    plot <- ggplot(drinks) +
      geom_boxplot(mapping = aes(x = Beverage_Category,
                                 y = Calories,
                                 fill = Beverage_Category)) +
      labs(title = "Trends in Each Drink Category",
           x = "Beverage Category", y = input$category) +
      ggthemes::theme_solarized() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
    plot
  })
})