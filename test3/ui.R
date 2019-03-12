foods <- read.csv(con <- file("starbucks-menu/starbucks-menu-nutrition-food.csv", encoding = "UCS-2LE"), stringsAsFactors = F)
colnames(foods) <- c('item','Calories','Fat','Carb','Fiber','Protein')
item <- foods$item

library(tidyverse)

tab_one <- tabPanel(
  # tab naming
  "Food",
  
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

shinyUI(navbarPage(
  strong("Starbucks"),
  # first tab
  tab_one
  
  # second tab
  # tab_two,
  
  # third tab
  # tab_three
))
