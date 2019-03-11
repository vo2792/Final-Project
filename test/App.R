######### A Simple Test File #########
# A simple test file that you can search for the country you want and
# return the locations of Starbucks in that country

library(tidyverse)
library(leaflet)
library(shiny)

directory <- read.csv("data/directory.csv", stringsAsFactors = F)
abbr <- read.csv("data/wikipedia-iso-country-codes.csv", stringsAsFactors = F) %>% 
  rename("Country" = "Alpha.2.code",
         "country_name" = "English.short.name.lower.case")

directory <- directory %>% 
  left_join(abbr, by = "Country")

select_values <- unique(directory$country_name)

checkbox_values <- unique(directory$Ownership.Type)

ui <- tabPanel(
  # tab naming
  "Map",
  
  # title of tab
  titlePanel("Location in Each Country"),
  
  # sidebar layout
  sidebarLayout(
    # sidebar panel
    sidebarPanel(
      # inputs that we would like to implement (eg. selectInput, sliderInput)
      selectInput(
        inputId = "search",
        label = "Find a Country",
        choices = select_values,
        selected = "United States Of America"
      ),
      
      checkboxGroupInput(
        inputId = "check",
        label = "Select Ownership Type",
        choices = list("Licensed" = checkbox_values[1],
                       "Joint Venture" = checkbox_values[2],
                       "Company Owned" = checkbox_values[3],
                       "Franchise" = checkbox_values[4]
                       ),
        selected = checkbox_values,
        inline = TRUE
      )
    ),
    # give a name to be passed to the server(output)
    mainPanel(
      leafletOutput("map")
    )
  )
)

server <- function(input, output) {
  filtered <- reactive({
    directory <- directory[directory$Ownership.Type %in% input$check, ]
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
}

shinyApp(ui, server)