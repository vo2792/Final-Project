library(shiny)
library(leaflet)

source("prepare_map.R")
source("prepare_table.R")

# introduction
intro <- tabPanel(
  "Introduction",
  fluidPage(
    h1("The Starbucks Project")
    
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
  "Drinks",
# title of tab
  titlePanel("Drink Nutritional Facts"),
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
        choices = colnames(drinks)[4:18],
        selected = colnames(drinks)[4:18]
      )
    ),
    mainPanel(
      dataTableOutput("table")
    )
  ),
"Measuring Caffeine", # label for the tab in the navbar
h2("Measuing Caffeine in Expresso Shots"), # show with a displayed title
# This content uses a sidebar layout
sidebarLayout(
  sidebarPanel(
    selectInput(
      inputId = "drink_type",
      label = "Beverage Category",
      selected = types[1],
      choices = types[2:10]
    )
  ),
  mainPanel(
    plotOutput("bargraph3"),
    h3("Caffeine Varies in These Drinks"),
    dataTableOutput("table4"),
    plotOutput("bar_graph5"),
    p("This bar graph just gives an estimated comparison between
           which type of Starbucks drink typically have more caffeine.
           It does not include data on drinks that do not have a set 
           amount of caffeine because it varies.")
  )
)

)
 
# third page
tab_three <- tabPanel(
  # tab naming
  "Food",
  # title of tab
  titlePanel("Food Nutritional Facts"),
  
  # sidebar layout
  sidebarLayout(
    # sidebar panel
    sidebarPanel(
      # inputs that we would like to implement (eg. selectInput, sliderInput)
      selectInput(
        inputId = "choice",
        label = "Food Category",
        choices = items,
        selected = items[1]
      ),
      checkboxGroupInput(
        inputId = "specify",
        label = "Filter:",
        choices = colnames(food)[2:6],
        selected = colnames(food)[2:6]
      )
    ),
    # give a name to be passed to the server(output)
    mainPanel(
      # plotlyOutput("name")
      dataTableOutput("table2")
    )
  )
)

# Final Project Shiny structure
shinyUI(navbarPage(
  strong("Starbucks"),
  # introduction
  intro,
  
  # first tab
  tab_one,
  
  # second tab
  tab_two,
  
  # third tab
  tab_three
))

