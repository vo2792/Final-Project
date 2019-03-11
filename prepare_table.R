library(dplyr)
menu <- read.csv("data/starbucks_drinkMenu_expanded.csv", stringsAsFactors = F)

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