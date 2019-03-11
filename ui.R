library(shiny)
library(leaflet)

source("prepare_map.R")
source("prepare_table.R")

# introduction
intro <- tabPanel(
  "Introduction",
  fluidPage(
    h1("The Starbucks Project"),
    
  )
)

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

# second page
tab_two <- tabPanel(
# tab naming
  "Nutrition Facts",
# title of tab
  titlePanel("Nutritional Facts Chart"),
# sidebar layout
  sidebarLayout(
     # sidebar panel
    sidebarPanel(
      selectInput(
        inputId = "drink",
        label = "Drink Category",
        choices = types,
        selected = types[1]
      ),
      checkboxGroupInput(
        inputId = "filter",
        label = "Filter:",
        choices = colnames(menu)[4:18],
        selected = colnames(menu)[4:18]
      )
    ),
    mainPanel(
      dataTableOutput("table")
    )
  )
)
 
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
  # introduction
  intro,
  
  # first tab
  tab_one,
  
  # second tab
  tab_two
  
  # third tab
  # tab_three
))

