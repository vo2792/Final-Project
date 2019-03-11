library(shiny)
library(dplyr)

menu <- read.csv("../data/starbucks_drinkMenu_expanded.csv")

colnames(menu) <- c("Beverage_Category", "Beverage", "Beverage_Prep",
                    "Calories", "Total_Fat(g)", "Trans_Fat(g)",
                    "Saturated_Fat(g)", "Sodium(mg)", "Total_Carbohydrates(g)",
                    "Cholesterol(mg)", "Dietary_Fiber(g)", "Sugars(g)", 
                    "Protein(g)", "Vitamin_A(%DV)", "Vitamin_C(%DV)",
                    "Calcium(%DV)", "Iron(%DV)", "Caffeine(mg)")

type <- menu %>% 
  group_by(Beverage_Category) %>% 
  count()


types <- as.character(type$Beverage_Category)
types[10] <- "All"
types <- sort(types)

ui <- fluidPage(
  titlePanel("Nutritional Visualizations"),
  selectInput(
    "drink",
    label = "Drink Category",
    choices = types,
    selected = types[1]
  ),
  checkboxGroupInput(
    "filter",
    label = "Filter:",
    choices = colnames(menu)[4:18],
    selected = colnames(menu)[4:18],
    inline = TRUE
  ),
  dataTableOutput("table")
)

server <- function(input, output) {
  filtered <- reactive({
    ifelse(
      input$drink == "All", 
      menu,
      menu %>% 
        filter(Beverage_Category == input$drink) %>% 
        select(-Beverage_Category)
    )
    menu %>% 
      select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
  })
  output$table <- renderDataTable({
    filtered()
  }) 
}

shinyApp(ui = ui, server = server)
