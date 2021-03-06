library("shiny")
library("leaflet")
library("plotly")
library("shinyWidgets")

source("intro.R")
source("prepare_map.R")
source("prepare_table.R")
source("prepare_food_comparison.R")

# introduction
intro <- tabPanel(
  # tab name - introduction
  "Introduction",

  class = "layer",
  fluidPage(
    HTML("<img src = starbucks-copy.png>"),
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
    HTML(intro5),
    HTML("<h2><font color=#036635>Which food has more/less nutritions?</h2>
         </font>"),
    HTML(intro6)
  )
)

# string for background (R reads the url wrongly when separated into two lines)
background <- "wood.png"

# first page
tab_one <- tabPanel(
  # tab naming
  "Map",

  # set background image
  setBackgroundImage(background),

  # title of tab
  includeCSS("styles.css"),
  headerPanel("Location in Each Country"),

  # sidebar layout
  sidebarLayout(

    # sidebar panel
    sidebarPanel(

      # inputs that we would like to implement (eg. selectInput, sliderInput)
      # select input
      selectInput(
        inputId = "search",
        label = "Find a Country",
        choices = select_values,
        selected = "United States Of America"
      ),

      checkboxGroupInput(
        inputId = "check",
        label = "Ownership Type",
        choices = list(
          "Licensed" = ownerships[1],
          "Joint Venture" = ownerships[2],
          "Company Owned" = ownerships[3],
          "Franchise" = ownerships[4]
        ),
        selected = ownerships
      )
    ),

    # give a name to be passed to the server(output)
    mainPanel(
      HTML("<h1>Interactive Map</h1>"),
      leafletOutput("map"),
      fluidRow(
        HTML("<h1>Some Insights</h1>"),
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

  # sidebar layout 1
  sidebarLayout(

    # sidebar panel 1
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
        selected = colnames(drinks)[c(4, 5, 9, 13)]
      )
    ),

    mainPanel(
      dataTableOutput("table")
    )
  ),

  HTML("<h1>Comparison of Drink Categories</h1>"),

  # sidebar layout 2
  sidebarLayout(

    # sidebar panel 2
    sidebarPanel(
      selectInput(
        "category",
        label = "Drink Category",
        choices = readable,
        selected = readable[1]
      )
    ),

    mainPanel(
      plotOutput("boxplot")
    )
  )
)

# third page
tab_three <- tabPanel(
  # label for the tab in the navbar
  "Caffeine",

  # show with a displayed title
  headerPanel("Measurement of Caffeine in Expresso Shots"),

  # This content uses a sidebar layout
  sidebarLayout(

    # sidebar panel
    sidebarPanel(
      selectInput(
        inputId = "drink_type",
        label = "Beverage Category",
        selected = "Coffee Short",
        choices = caffeine_data_num$Beverage_name
      )
    ),

    # main panel
    mainPanel(
      plotOutput("bargraph3"),
      plotOutput("bar_graph5"),
      p("This bar graph just gives an estimated comparison between
         which type of Starbucks drink typically have more caffeine.
         It does not include data on drinks that do not have a set
         amount of caffeine because it varies."),
      HTML("<h1>Caffeine Varies in These Drinks</h1>"),
      dataTableOutput("table4")
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
        choices = list("Calories", "Fat", "Carb", "Fiber", "Protein")
      )
    ),

    # give a name to be passed to the server(output)
    mainPanel(
      plotlyOutput("food")
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
