library(shiny)
library(leaflet)
library(shinyWidgets)

source("prepare_map.R")
source("prepare_table.R")
source("prepare_food_comparison.R")

# introduction
intro <- tabPanel(
  "Introduction",
  fluidPage(
    HTML("<h1>The Starbucks Project</h1>"),
    HTML("<h2><font color=#036635>Welcome to our Site!</font></h2>"),
    HTML(intro1),
    HTML("<h2><font color=#036635>Who is our audience?</font></h2>"),
    HTML(intro2),
    HTML("<h2><font color=#036635>How many Starbucks are in each country?
         </font></h2>"),
    HTML(intro3),
    HTML("<h2><font color=#036635>What exactly are you consuming?</h2></font>"),
    HTML(intro4)
  )
)

# string for background (R reads the url wrongly when separated into two lines)
background <- "data:image/jpeg;base64,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"

# first page
tab_one <- tabPanel(
  # tab naming
  "Map",

  setBackgroundImage(background),
  # title of tab
  includeCSS("styles.css"),
  headerPanel("Location in Each Country"),
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
      includeCSS("styles.css"),
      HTML("<h1>Interactive Map</h1>"),
      leafletOutput("map"),
      fluidRow(
        HTML("<h1><font =>Some Insights</font></h1>"),
        HTML(my_str),
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
  headerPanel("Drink Nutritional Facts"),
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
  h2("Comparison of Drink Categories"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "category",
        label = "Drink Category (for plot)",
        choices = colnames(drinks)[4:18],
        selected = colnames(drinks)[4]
      )
    ),
    mainPanel(
      plotOutput("boxplot")
    )
  )
)

tab_three <- tabPanel(
  "Caffeine", # label for the tab in the navbar
  h2("Measurement of Caffeine in Expresso Shots"), # show with a displayed title
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
tab_four <- tabPanel(
  # tab naming
  "Food",
  # title of tab
  headerPanel("Food Nutritional Facts"),
  
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
tab_five <- tabPanel(
  # tab naming
  "Food comparison",
  
  # title of tab
  headerPanel("Which food contains more..?"),
  
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
  tab_four,
  
  # fifth tab
  tab_five
))

