library(dplyr)

food <- read.csv(
  con <- file("../test3/starbucks-menu/starbucks-menu-nutrition-food.csv",
              encoding = "UCS-2LE"))
drinks <- read.csv("../data/starbucks_drinkMenu_expanded.csv")

colnames(food) <- c("Food", "Calories", "Fat(g)", "Carbohydrates(g)", 
                    "Dietary Fiber(g)", "Protein(g)")

colnames(drinks) <- c("Beverage_Category", "Beverage", "Beverage_Prep",
                    "Calories", "Total_Fat(g)", "Trans_Fat(g)",
                    "Saturated_Fat(g)", "Sodium(mg)", "Total_Carbohydrates(g)",
                    "Cholesterol(mg)", "Dietary_Fiber(g)", "Sugars(g)", 
                    "Protein(g)", "Vitamin_A(%DV)", "Vitamin_C(%DV)",
                    "Calcium(%DV)", "Iron(%DV)", "Caffeine(mg)")

type <- drinks %>% 
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
    choices = colnames(drinks)[4:18],
    selected = colnames(drinks)[4:18],
    inline = TRUE
  ),
  selectInput(
    "category",
    label = "Drink Category (for plot)",
    choices = colnames(drinks)[4:18],
    selected = colnames(drinks)[4]
  ),
  dataTableOutput("table"),
  plotOutput("boxplot")
)

server <- function(input, output) {
  filtered <- reactive({
    if(input$drink == "All") {
      drinks %>% 
        select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
    } else {
      drinks %>% 
        filter(Beverage_Category == input$drink) %>% 
        select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
    }
  })
  
  output$table <- renderDataTable({
    filtered()
  }) 
  
  output$boxplot <- renderPlot({
    plot <- ggplot(drinks) +
      geom_boxplot(mapping = aes(x = Beverage_Category, 
                                 y = Calories, 
                                 fill = Beverage_Category)) + 
      labs(title = "Trends in Each Drink Category", 
           x = "Beverage Category", y = input$category) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
    plot
  })
}

shinyApp(ui = ui, server = server)


# e
filtered2 <- reactive({
  if(input$drink == "All") {
    drinks %>% 
      select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
  }
  else {
    drinks %>% 
      filter(Beverage_Category == input$drink) %>% 
      select(Beverage_Category, Beverage, Beverage_Prep, input$filter)
  }
})

output$table <- renderDataTable({
  filtered2()
})

# render the third object defined in tab three
## todo:
##output$SOME_NAME_THREE <-
filtered3 <- reactive({
  if(input$choice == "All") {
    food %>% 
      select(Food, input$specify)
  } else {
    food %>% 
      filter(Food == input$choice) %>% 
      select(Food, input$specify)
  }
})

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