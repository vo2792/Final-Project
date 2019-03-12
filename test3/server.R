foods <- read.csv(con <- file("starbucks-menu/starbucks-menu-nutrition-food.csv", encoding = "UCS-2LE"), stringsAsFactors = F)
colnames(foods) <- c('item','Calories','Fat','Carb','Fiber','Protein')
item <- foods$item

shinyServer(function(input, output) {
  filtered <- reactive({
    foods <- foods %>% filter(item == input$food_1 | item == input$food_2) 
    foods
  })
  
  output$food <- renderPlot({
    filtered() %>% 
      ggplot(aes_string(x = "item", y = input$nutrition)) +
      geom_col(fill = "lightblue", width = 0.3) +
      theme_bw() +
      labs(x = "")
  })
})