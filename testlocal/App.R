######### A Simple Test File #########
# A simple test file that you can search for the country you want and
# return the locations of Starbucks in that country

library(dplyr)
library(maps)
library(leaflet)
library(shiny)

directory <- read.csv("data/directory.csv", stringsAsFactors = F)

select_values <- directory %>%
  group_by(Country) %>%
  distinct(Country) %>%
  pull(Country)

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
        selected = ""
      )
    ),
    # give a name to be passed to the server(output)
    mainPanel(
      leafletOutput("map")
    )
  )
)

server <- function(input, output) {
  output$map <- renderLeaflet({
    filtered <- directory %>%
      filter(Country == input$search)
    leaflet(data = filtered) %>%
      addTiles() %>%
      addMarkers(lat = ~Latitude, lng = ~Longitude)
  })
}

shinyApp(ui, server)