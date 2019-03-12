library(dplyr)
food <- read.csv(
  con <- file("test3/starbucks-menu/starbucks-menu-nutrition-food.csv",
              encoding = "UCS-2LE"))
drinks <- read.csv("data/starbucks_drinkMenu_expanded.csv")


colnames(food) <- c("Food", "Calories", "Fat(g)", "Carbohydrates(g)", 
                    "Dietary Fiber(g)", "Protein(g)")

colnames(drinks) <- c("Beverage_Category", "Beverage", "Beverage_Prep",
                    "Calories", "Total_Fat(g)", "Trans_Fat(g)",
                    "Saturated_Fat(g)", "Sodium(mg)", "Total_Carbohydrates(g)",
                    "Cholesterol(mg)", "Dietary_Fiber(g)", "Sugars(g)", 
                    "Protein(g)", "Vitamin_A(%DV)", "Vitamin_C(%DV)",
                    "Calcium(%DV)", "Iron(%DV)", "Caffeine(mg)")

items <- as.character(food$Food)
items <- sort(items)
items <- c("All", items)

type <- drinks %>% 
  group_by(Beverage_Category) %>% 
  count()

types <- as.character(type$Beverage_Category)
types[10] <- "All"
types <- sort(types)