foods <- read.csv(con <- file("data/starbucks-menu-nutrition-food.csv", encoding = "UCS-2LE"), stringsAsFactors = F)
colnames(foods) <- c('Food','Calories','Fat','Carb','Fiber','Protein')
item <- foods$Food

