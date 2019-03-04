library(shiny)

# first page
tab_one <- tabPanel(
  # tab naming
  
  # title of tab
  titlePanel(),
  
  # sidebar layout
  sidebarLayout(
    # sidebar panel
    sidebarPanel(
      # inputs that we would like to implement (eg. selectInput, sliderInput)
    ),
    # give a name to be passed to the server(output)
    mainPanel(
      # plotlyOutput("name")
    )
  )
)

# second page
tab_two <- tabPanel(
  # tab naming
  
  # title of tab
  titlePanel(),
  
  # sidebar layout
  sidebarLayout(
    # sidebar panel
    sidebarPanel(
      # inputs that we would like to implement (eg. selectInput, sliderInput)
    ),
    # give a name to be passed to the server(output)
    mainPanel(
      # plotlyOutput("name")
    )
  )
)

# third page
tab_three <- tabPanel(
  # tab naming
  
  # title of tab
  titlePanel(),
  
  # sidebar layout
  sidebarLayout(
    # sidebar panel
    sidebarPanel(
      # inputs that we would like to implement (eg. selectInput, sliderInput)
    ),
    # give a name to be passed to the server(output)
    mainPanel(
      # plotlyOutput("name")
    )
  )
)

# Final Project Shiny skeleton structure
shinyUI(navbar(
  # first tab
  tab_one,
  
  # second tab
  tab_two,
  
  # third tab
  tab_three
))