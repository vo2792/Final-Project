library(shiny)
library(leaflet)

source("prepare_map.R")
source("prepare_table.R")
source("prepare_food_comparison.R")

# introduction
intro <- tabPanel(
  "Introduction",
  fluidPage(
    h1("The Starbucks Project"),
    fluidRow(
      HTML("<h2>Some insights about the map</h2>"),
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
      ),
      selectInput(
        "category",
        label = "Drink Category (for plot)",
        choices = colnames(drinks)[4:18],
        selected = colnames(drinks)[4]
      )
    ),
    mainPanel(
      dataTableOutput("table"),
      plotOutput("boxplot")
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

# fourth tab
tab_four <- tabPanel(
  # tab naming
  "Food comparison",
  
  # title of tab
  titlePanel("Which food contains more..?"),
  
  # sidebar layout
  sidebarLayout(
    # sidebar panel
    sidebarPanel(
      # inputs that we would like to implement (eg. selectInput, sliderInput)
      selectInput(
        inputId = "food_1",
        label = "Select food you want to try",
        choices = item,
        selected = "Chonga Bagel"
      ),
      
      selectInput(
        inputId = "food_2",
        label = "Select another food you want to try",
        choices = item,
        selected = "8-Grain Roll"
      ),
      
      radioButtons(
        inputId = "nutrition",
        label = "Compared by",
        choices = list("Calories","Fat","Carb","Fiber","Protein")
      )
    ),
    
    # give a name to be passed to the server(output)
    mainPanel(
      plotOutput("food")
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
  tab_three,
  
  # fourth tab
  tab_four
))

