library(dplyr)

food <- read.csv(
  con <- file("data/starbucks-menu-nutrition-food.csv",
    encoding = "UCS-2LE"
  ),
  stringsAsFactors = FALSE
)

drinks <- read.csv("data/starbucks_drinkMenu_expanded.csv",
  stringsAsFactors = FALSE
)

categories <- read.csv("data/starbucks_drinkMenu_expanded.csv",
  stringsAsFactors = FALSE
)

colnames(food) <- c(
  "Food", "Calories", "Fat(g)", "Carbohydrates(g)",
  "Dietary Fiber(g)", "Protein(g)"
)

colnames(drinks) <- c(
  "Beverage_Category", "Beverage", "Beverage_Prep",
  "Calories", "Total_Fat(g)", "Trans_Fat(g)",
  "Saturated_Fat(g)", "Sodium(mg)", "Total_Carbohydrates(g)",
  "Cholesterol(mg)", "Dietary_Fiber(g)", "Sugars(g)",
  "Protein(g)", "Vitamin_A(%DV)", "Vitamin_C(%DV)",
  "Calcium(%DV)", "Iron(%DV)", "Caffeine(mg)"
)

colnames(categories) <- c(
  "Beverage_Category", "Beverage", "Beverage_Prep",
  "Calories", "Total_Fat_g", "Trans_Fat_g",
  "Saturated_Fat_g", "Sodium_mg", "Total_Carbohydrates_g",
  "Cholesterol_mg", "Dietary_Fiber_g", "Sugars_g",
  "Protein_g", "Vitamin_A_DV", "Vitamin_C_DV",
  "Calcium_DV", "Iron_DV", "Caffeine_mg"
)

readable <- list(
  "Calories", 
  "Total Fat(g)" = "Total_Fat_g",
  "Trans Fat(g)" = "Trans_Fat_g",
  "Saturated Fat(g)" = "Saturated_Fat_g", 
  "Sodium(mg)" = "Sodium_mg", 
  "Total Carbohydrates(g)" = "Total_Carbohydrates_g",
  "Cholesterol(mg)" = "Cholesterol_mg", 
  "Dietary Fiber(g)" = "Dietary_Fiber_g", 
  "Sugars(g)" = "Sugars_g",
  "Protein(g)" = "Protein_g"
)

items <- as.character(food$Food)
items <- sort(items)
items <- c("All", items)

type <- drinks %>%
  group_by(Beverage_Category) %>%
  count()

types <- as.character(type$Beverage_Category)
types[10] <- "All"
types <- sort(types)

caffeine_data <- drinks %>%
  select(Beverage_Category, Beverage, Beverage_Prep, `Caffeine(mg)`)
# There are 64mg of caffeine in each shot of expresso.

colnames(caffeine_data)[colnames(caffeine_data) ==
  "Caffeine(mg)"] <- "Caffeine_mg"

caffeine_varies <- filter(caffeine_data, tolower(Caffeine_mg) == "varies")
caffeine_data_num <- filter(caffeine_data, tolower(Caffeine_mg) != "varies")
caffeine_data_num$num_expresso_shot <-
  round(as.numeric(caffeine_data_num$Caffeine_mg) / 64, digits = 2)

beverage_type <- caffeine_data$Beverage_Category

avg_caffeine <- caffeine_data_num %>%
  group_by(Beverage_Category) %>%
  select(Beverage_Category, Caffeine_mg) %>%
  summarise(Avg_Caffeine_mg = round(mean(as.numeric(Caffeine_mg)), digits = 2))

avg_caffeine$avg_expresso_shot <- round(avg_caffeine$Avg_Caffeine_mg / 64,
  digits = 2
)

caffeine_data_num$Beverage_name <-
  paste0(
    caffeine_data_num$Beverage_Category, " ",
    caffeine_data_num$Beverage_Prep
  )

caffeine_varies$Beverage_name <- paste0(
  caffeine_varies$Beverage, " ",
  caffeine_varies$Beverage_Prep
)
