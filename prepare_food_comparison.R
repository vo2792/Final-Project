# Load in food menu dataset
foods <- read.csv(con <- file("data/starbucks-menu-nutrition-food.csv",
  encoding = "UCS-2LE"
),
stringsAsFactors = F
)

# Assign better column names
colnames(foods) <- c("Food", "Calories", "Fat", "Carb", "Fiber", "Protein")
item <- foods$Food

# Sixth introductory section
intro6 <-
  "<h4>
  You may not want to only to drink coffee or some other beverage, but also
  grab some food in Starbucks. However, most people do not know what 
  nutritional components are included in Starbucks foods. If you'd like to know
  which food option is better or worse compared with another option,
  we can help you out. Our <font color=#00b33c>food comparison tool</font> is 
  for those who want <em>quick</em> and <em>easy</em> access to that 
  information. All you have to do is <font color=#00b33c>select 2</font> menu 
  items from the list and <font color=#00b33c>filter</font> for the information 
  that you are interested in. If your situation is that you have two food items 
  that you want to try, but can not make up your mind on which is the better 
  option for your diet, this comparison tool will definitely be helpful.
  </h4>"
