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

intro1 <- "<h4>
We've pulled together data from multiple Starbucks datasets in order
to provide you with a <font color=#00b3b3> simple-to-use </font> and 
<font color=#00b3b3> simple-to-understand </font> application 
regarding <font color=#999900> worldwide location distribution 
</font> and <font color=#999900> nutritional information</font>. Our 
<font color=#009933><strong> goal </strong></font> is to provide 
you, the user, with new insights about Starbucks.
</h4>
<h4>
The following interactive pages will be providing you with 
widely <font color=#00b3b3> adjustable visualizations</font>.
We hope that our app is self-sufficient enough to satisfy any
questions you have regarding location and nutritional information
of Starbucks.
</h4>"

intro2 <- paste0("<h4>
                 This project is targeted towards <font color=#009933>Starbucks
                 consumers/customers</font>. We believe that every consumer should
                 have a base level of awareness about the products he/she is using 
                 and the effects they have on the user's overall health. Since there
                 are <strong>", totalnum, "</strong> total recorded Starbucks stores
                 in the world, it can be difficult to keep track of each one. 
                 Interestingly, according to our datasets, some stores are <font
                 color=red> not licensed </font>, which can be a concern for some 
                 consumers. Our map is able to display <font color=#999900> the 
                 number of Starbucks in each country, pinpoint the name and exact 
                 locations of every store, and filter out attributes of each store 
                 </font> (e.g. whether they are licensed or not). While we understand 
                 that a daily intake of coffee (depending on the amount) can have <em><a href=https://www.aarp.org/health/healthy-living/info-10-2013/coffee-for-health.html>
                 negative effects </a></em> on one's body, especially if the 
                 particular coffee beverage contains <strong><font color=#992600> 
                 sugar, artificial sweeteners, etc.</strong></font>, we want to focus 
                 on how Starbucks consumers can rely on our application to provide 
                 the majority of information they need in <font color=#00cca3> one 
                 source</font>. Through our app, the consumer can have a better basis 
                 of knowledge of the choices in Starbucks. And if already consumed, 
                 the user can reference our application to track their intake 
                 (e.g. for tracking macros or to generally avoid additional intakes
                 of a certain nutritional item). 
                 </h4>")

intro3 <- "<h4>
<font color=#e6b800> Curious about the distributions of Starbucks
establishments from country to country? </font> With our map, you 
are able to <em> select </em> a country of your choice to 
view the number and distribution of Starbucks stores in that 
country. <em> Click </em> on the circle related to your 
region of preference or manually zoom into the map if you'd like 
to see more specified distributions. If you'd like to know the 
<font color=#999900 >total number of Starbucks </font> in that 
country, just zoom out until there remains one circle. 
</h4>
<h4>
We have provided a <em> filter </em> option that will allow you 
to narrow down the number of stores displayed on the map specific
to your interest.
</h4>"

intro4 <- "<h4>
We've implemented tables of the <font color=#00b3b3> entire food 
and drink menu</font>, including some general and specified plots,
<font color=#00b33c> all </font> of which are <em>interactive</em>.
Meaning, that you can <strong>pick and choose</strong> the 
nutritional category of your interest and the data will be 
filtered to display your choices. The tables also include multiple
seach bars and a filter, so you can really specify your search to 
find your drink and nutritional facts of interest.
</h4>
<h3><font color=#036635>Are there better alternatives?</h3></font>
<h4>
Perhaps your menu item of interest has <font color=red>too much
</font> of something than your desired amount, but you <em>still
</em> want an item within the same category. Our tables are able 
to help you. Just click the category of your choice, filter and 
arrange the data, and choose the next best option. The
<font color=#b3b3ff>simplicity</font> of utilizing our tables 
and plots are what will ultimately save you, the consumer, time.
</h4>"
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
