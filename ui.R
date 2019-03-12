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
    HTML("<h1> Write a story!!!</h1>"),
    HTML("<p>Consumerism</p>")
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
      HTML("<h1>A Map To Play</h1>"),
      leafletOutput("map"),
      fluidRow(
        HTML("<h1>Some insights about the map</h1>"),
        HTML("<p>Starbucks is growing strong! As of 2017, it has 
             <strong>25600</strong> recorded 
             locations worldwide, spreading across <strong>73</strong>
             countries. For the sake of tidiness,<br>
             the tables shown below are limited to only display the top
             ten countries and cities that have the most Starbucks stores
             respectively. <em>USA</em> stays on <br>
             top of the record for having <strong>13608</strong> stores,
             followed by <em>China</em> where it has <strong>2734</strong>
             stores across the country. For what's not shown on the table, <br>
             <em>Andorra</em> has only <strong>1</strong> Starbucks location
             across the country. Another interesting side to look at is
             the number of stores each city has. <br>
             <em>Shanghai</em> tops the list by having <strong>542</strong>
             stores. In the meantime, there are <em>2653 cities</em>
             with only <strong>1</strong> Starbucks store."),
        column(6, tableOutput("rankworld")),
        column(6, tableOutput("rankcity"))
        )
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

