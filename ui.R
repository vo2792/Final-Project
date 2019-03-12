library(shiny)
library(leaflet)

source("prepare_map.R")
source("prepare_table.R")

# introduction
intro <- tabPanel(
  "Introduction",
  fluidPage(
    h1("The Starbucks Project"),
    fluidRow(
      HTML("<h1>Some insights about the map</h1>"),
      HTML("<p>Starbucks has been expanding to <strong>73</strong>
           countries worldwide. For the sake of tidiness, the tables
           shown below are limited to only display the top ten countries and
           cities that have the most Starbucks stores respectively.
           <em>USA</em> stays on top of the record for
           having <strong>13608</strong> stores, followed by
           <em>China</em> where it has <strong>2734</strong>
           stores across the country. For what's not shown on the table,
           <em>Andorra</em> has only <strong>1</strong> Starbucks location"),
      column(6, tableOutput("rankworld")),
      column(6, tableOutput("rankcity"))
    )
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

