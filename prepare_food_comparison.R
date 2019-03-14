foods <- read.csv(con <- file("data/starbucks-menu-nutrition-food.csv",
  encoding = "UCS-2LE"
),
stringsAsFactors = F
)

colnames(foods) <- c("Food", "Calories", "Fat", "Carb", "Fiber", "Protein")
item <- foods$Food

intro6 <-
  "<h4>
  You may want not only to drink coffee or something but also
  grab some food in Starbucks. However, most people do not know how much a
  particular nutrition is included in Starbucks foods
  and which food is better or worse compared with another
  food in terms of a specific ingredients.
  Our comparison tool is for those who want to know that.
  Only you have to do is select 2 menus from the list
  and check the nutrition you are interested in. When you
  have two foods that you want to try and can not make up your mind which
  to buy, this comparison tool definitely helps you know which food
  you should order for your health.
  </h4>"
