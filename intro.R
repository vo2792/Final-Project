# Load in location data
country <- read.csv("data/directory.csv", stringsAsFactors = F)

# Calculate total number of starbucks stores in dataset
totalnum <- country %>%
  nrow()

# First introductory section
intro1 <-
  "<h4>
  We've pulled together data from multiple Starbucks datasets in order
  to provide you with a <font color=#009933> simple-to-use </font> and
  <font color=#009933> simple-to-understand </font> application
  regarding <font color=#009933> worldwide location distribution
  </font> and <font color=#009933> nutritional information</font>. Our
  <font color=#009933><strong> goal </strong></font> is to provide
  you, the user, with new insights about Starbucks.
  </h4>
  <h4>
  The following interactive pages will be providing you with
  widely <font color=#009933> adjustable visualizations</font>.
  We hope that our app is self-sufficient enough to satisfy any
  questions you have regarding location and nutritional information
  of Starbucks.
  </h4>"

# Second introductory section
#### Unable to break line because url hyperlink will not work ####
intro2 <- paste0(
  "<h4>
  This project is targeted towards <font color=#009933>Starbucks
  consumers/customers</font>. We believe that every consumer should
  have a base level of awareness about the products he/she is using
  and the effects they have on the user's overall health. Since there
  are <strong>", totalnum, "</strong> total recorded Starbucks stores
  in the world, it can be difficult to keep track of each one.
  Interestingly, according to our datasets, some stores are <font
  color=#009933> not licensed</font>, which can be a concern for some
  consumers. Our map is able to display <font color=#009933></font>,
  which can be a concern for some
  consumers. Our map is able to display <font color=#009933>the
  number of Starbucks in each country, pinpoint the name and exact
  locations of every store, and filter out attributes of each store
  </font> (e.g. whether they are licensed or not). While we understand
  that a daily intake of coffee (depending on the amount) can have<em><a href=https://www.aarp.org/health/healthy-living/info-10-2013/coffee-for-health.html>
  negative effects </a></em> on one's body, especially if the
  particular coffee beverage contains <font color=#009933>
  sugar, artificial sweeteners, etc.</font>, we want to focus
  on how Starbucks consumers can rely on our application to provide
  the majority of information they need in <font color=#009933>one
  source</font>. Through our app, the consumer can have a better basis
  of knowledge of the choices in Starbucks. And if already consumed,
  the user can reference our application to track their intake
  (e.g. for tracking macros or to generally avoid additional intakes
  of a certain nutritional item).
  </h4>"
)

# Third introductory section
intro3 <-
  "<h4>
  <font color=#009933>Curious about the distributions of Starbucks
  establishments from country to country?</font> With our map, you
  are able to <em>select</em> a country of your choice to
  view the number and distribution of Starbucks stores in that
  country. <em>Click</em> on the circle related to your
  region of preference or manually zoom into the map if you'd like
  to see more specified distributions. If you'd like to know the
  <font color=#009933>total number of Starbucks</font> in that
  country, just zoom out until there remains one circle.
  </h4>
  <h4>
  We have provided a <em>filter</em> option that will allow you
  to narrow down the number of stores displayed on the map specified by
  the type of ownership.
  </h4>"

# Fourth introductory section
intro4 <-
  "<h4>
  We've implemented tables of the <font color=#009933>entire food
  and drink menu</font>, including some general and specified plots,
  <font color=#00b33c>all</font> of which are <em>interactive</em>.
  Meaning, that you can <font color=#009933>pick and choose</font> the
  nutritional category of your interest and the data will be
  filtered to display your choices. The tables also include multiple
  seach bars and a filter, so you can really specify your search to
  find your drink and nutritional facts of interest.
  </h4>
  <h2><font color=#036635>Are there better alternatives?</h2></font>
  <h4>
  Perhaps your menu item of interest has <font color=#009933>too much
  </font> of something than your desired amount, but you <em>still
  </em> want an item within the same category. Our tables are able
  to help you. Just click the category of your choice, filter and
  arrange the data, and choose the next best option. The
  <font color=#009933>simplicity</font> of utilizing our tables
  and plots are what will ultimately save you, the consumer, time.
  </h4>"

# Fifth introductory section
intro5 <-
  "<h4>
  Knowing how much caffeine you consume is important. There are
  many negative side effects for consuming too much caffeine, and
  some side effects are <font color=#00b33c>fast blood pressure,
  anxiety, and addiction</font>. This is why we provided
  a caffeine informational page for Starbucks consumers.
  We care about people's health and well being. Starbucks labels
  their caffeine in milligrams, however, most people do not know
  how much that is. This is why we displayed the caffeine in amounts
  of <font color=#00b33c>expresso shots</font>. Consumers can have a better 
  understanding of the side affects of a single shot (64 milligrams of 
  caffeine). It allows consumers to choose their drinks based on the 
  amount of caffeine in each drink such as selecting drinks that best fit
  the situation they are in. If the consumer is working on an assignment during
  the evening and needs a small boost that won't keep them up all night, they 
  can choose drinks with low or no caffeine. If they are running low on sleep 
  and are just getting their day started, they can choose the drinks with 
  higher caffeine. Although some of the starbucks drinks have an undetermined 
  amount of caffeine (varies), it is still worth knowing the amount of caffeine
  a specific drink contains.
  </h4>"

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