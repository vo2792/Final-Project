library(shiny)
library(leaflet)

source("prepare_map.R")

# first page
tab_one <- tabPanel(
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
        label = "Ownership Type",
        choices = list("Licensed" = ownerships[1],
                       "Joint Venture" = ownerships[2],
                       "Company Owned" = ownerships[3],
                       "Franchise" = ownerships[4]),
        selected = ownerships
      )
    ),
    # give a name to be passed to the server(output)
    mainPanel(
      leafletOutput("map")
    )
  )
)

# # second page
# tab_two <- tabPanel(
#   # tab naming
#   
#   # title of tab
#   titlePanel(),
#   
#   # sidebar layout
#   sidebarLayout(
#     # sidebar panel
#     sidebarPanel(
#       # inputs that we would like to implement (eg. selectInput, sliderInput)
#     ),
#     # give a name to be passed to the server(output)
#     mainPanel(
#       # plotlyOutput("name")
#     )
#   )
# )
# 
# # third page
# tab_three <- tabPanel(
#   # tab naming
#   
#   # title of tab
#   titlePanel(),
#   
#   # sidebar layout
#   sidebarLayout(
#     # sidebar panel
#     sidebarPanel(
#       # inputs that we would like to implement (eg. selectInput, sliderInput)
#     ),
#     # give a name to be passed to the server(output)
#     mainPanel(
#       # plotlyOutput("name")
#     )
#   )
# )

# Final Project Shiny structure
shinyUI(navbarPage(
  strong("Starbucks"),
  # first tab
  tab_one
  
  # second tab
  # tab_two,
  
  # third tab
  # tab_three
))