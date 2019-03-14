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
    HTML(intro4),
    HTML("<h2><font color=#036635>How much caffeine are you consuming
         in each drink?</h2></font>"),
    HTML(intro5)
  )
)

# string for background (R reads the url wrongly when separated into two lines)
#background <- "image/wood-background.jpeg"

# first page
tab_one <- tabPanel(
  # tab naming
  "Map",

  #setBackgroundImage(background),
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
  HTML("<h1>Comparison of Drink Categories</h1>"),
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

# third page
tab_three <- tabPanel(
  "Caffeine", # label for the tab in the navbar
  headerPanel("Measurement of Caffeine in Expresso Shots"), # show with a displayed title
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
 
# fourth page
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

# fifth tab
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

