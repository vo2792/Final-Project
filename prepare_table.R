library(dplyr)

# Load in food menu dataset
food <- read.csv(
  con <- file("data/starbucks-menu-nutrition-food.csv",
    encoding = "UCS-2LE"
  ),
  stringsAsFactors = FALSE
)

# Load in drink menu dataset
drinks <- read.csv("data/starbucks_drinkMenu_expanded.csv",
  stringsAsFactors = FALSE
)

# Load in separate drink menu dataset for boxplot
categories <- read.csv("data/starbucks_drinkMenu_expanded.csv",
  stringsAsFactors = FALSE
)

# Assign better column names
colnames(food) <- c(
  "Food", "Calories", "Fat(g)", "Carbohydrates(g)",
  "Dietary Fiber(g)", "Protein(g)"
)

# Assign better column names
colnames(drinks) <- c(
  "Beverage_Category", "Beverage", "Beverage_Prep",
  "Calories", "Total_Fat(g)", "Trans_Fat(g)",
  "Saturated_Fat(g)", "Sodium(mg)", "Total_Carbohydrates(g)",
  "Cholesterol(mg)", "Dietary_Fiber(g)", "Sugars(g)",
  "Protein(g)", "Vitamin_A(%DV)", "Vitamin_C(%DV)",
  "Calcium(%DV)", "Iron(%DV)", "Caffeine(mg)"
)

# Assign readable column names for boxplot
colnames(categories) <- c(
  "Beverage_Category", "Beverage", "Beverage_Prep",
  "Calories", "Total_Fat_g", "Trans_Fat_g",
  "Saturated_Fat_g", "Sodium_mg", "Total_Carbohydrates_g",
  "Cholesterol_mg", "Dietary_Fiber_g", "Sugars_g",
  "Protein_g", "Vitamin_A_DV", "Vitamin_C_DV",
  "Calcium_DV", "Iron_DV", "Caffeine_mg"
)

# Assign better names for the choices of the y-axis of the boxplot
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

# Extract and organize foods as string units into a vector 
items <- as.character(food$Food)
items <- sort(items)
items <- c("All", items)

# Group drinks by beverage category
type <- drinks %>%
  group_by(Beverage_Category) %>%
  count()

# Create and organize vector of all beverage categories
types <- as.character(type$Beverage_Category)
types[10] <- "All"
types <- sort(types)

# Filtered dataset for caffeine page
caffeine_data <- drinks %>%
  select(Beverage_Category, Beverage, Beverage_Prep, `Caffeine(mg)`)
# There are 64mg of caffeine in each shot of expresso.

# Changing column name of caffeine to be more processable code
colnames(caffeine_data)[colnames(caffeine_data) ==
  "Caffeine(mg)"] <- "Caffeine_mg"

# Filter out 'varies' values and calculate caffeine in units of espresso shots
caffeine_varies <- filter(caffeine_data, tolower(Caffeine_mg) == "varies")
caffeine_data_num <- filter(caffeine_data, tolower(Caffeine_mg) != "varies")
caffeine_data_num$num_expresso_shot <-
  round(as.numeric(caffeine_data_num$Caffeine_mg) / 64, digits = 2)

# Vector of beverage categories for caffeine page
beverage_type <- caffeine_data$Beverage_Category

# Calculate average amount of caffeine by beverage category
avg_caffeine <- caffeine_data_num %>%
  group_by(Beverage_Category) %>%
  select(Beverage_Category, Caffeine_mg) %>%
  summarise(Avg_Caffeine_mg = round(mean(as.numeric(Caffeine_mg)), digits = 2))

# Create column for average amount of caffeine in espresso shots
avg_caffeine$avg_expresso_shot <- round(avg_caffeine$Avg_Caffeine_mg / 64,
  digits = 2
)

# Vector of beverage categories and preparations
caffeine_data_num$Beverage_name <-
  paste0(
    caffeine_data_num$Beverage_Category, " ",
    caffeine_data_num$Beverage_Prep
  )

# Filtered vector of beverages and preparations with value 'varies'
caffeine_varies$Beverage_name <- paste0(
  caffeine_varies$Beverage, " ",
  caffeine_varies$Beverage_Prep
)
