foods <- read.csv(con <- file("data/starbucks-menu-nutrition-food.csv", encoding = "UCS-2LE"), stringsAsFactors = F)
colnames(foods) <- c('item','Calories','Fat','Carb','Fiber','Protein')
item <- foods$item