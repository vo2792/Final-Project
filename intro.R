country <- read.csv("data/directory.csv", stringsAsFactors = F)

totalnum <- country %>%
  nrow()

intro1 <- "<h4>
We've pulled together data from multiple Starbucks datasets in order
to provide you with a <font color=#00b3b3> simple-to-use </font> and 
<font color=#00b3b3> simple-to-understand </font> application 
regarding <font color=#00b3b3> worldwide location distribution 
</font> and <font color=#00b3b3> nutritional information</font>. Our 
<font color=#009933><strong> goal </strong></font> is to provide 
you, the user, with new insights about Starbucks.
</h4>
<h4>
The following interactive pages will be providing you with 
widely <font color=#00b3b3> adjustable visualizations</font>.
We hope that our app is self-sufficient enough to satisfy any
questions you have regarding location and nutritional information
of Starbucks.
</h4>"

intro2 <- paste0("<h4>
                 This project is targeted towards <font color=#00b3b3>Starbucks
                 consumers/customers</font>. We believe that every consumer should
                 have a base level of awareness about the products he/she is using 
                 and the effects they have on the user's overall health. Since there
                 are <strong>", totalnum, "</strong> total recorded Starbucks stores
                 in the world, it can be difficult to keep track of each one. 
                 Interestingly, according to our datasets, some stores are <font
                 color=red> not licensed</font>, which can be a concern for some 
                 consumers. Our map is able to display <font color=#999900></font>, 
                 which can be a concern for some 
                 consumers. Our map is able to display <font color=#00b3b3>the 
                 number of Starbucks in each country, pinpoint the name and exact 
                 locations of every store, and filter out attributes of each store
                 </font> (e.g. whether they are licensed or not). While we understand 
                 that a daily intake of coffee (depending on the amount) can have<em><a href=https://www.aarp.org/health/healthy-living/info-10-2013/coffee-for-health.html>
                 negative effects </a></em> on one's body, especially if the 
                 particular coffee beverage contains <font color=red> 
                 sugar, artificial sweeteners, etc.</font>, we want to focus 
                 on how Starbucks consumers can rely on our application to provide 
                 the majority of information they need in <font color=#00b3b3>one 
                 source</font>. Through our app, the consumer can have a better basis 
                 of knowledge of the choices in Starbucks. And if already consumed, 
                 the user can reference our application to track their intake 
                 (e.g. for tracking macros or to generally avoid additional intakes
                 of a certain nutritional item). 
                 </h4>")

intro3 <- "<h4>
<font color=#00b3b3>Curious about the distributions of Starbucks
establishments from country to country?</font> With our map, you 
are able to <em>select</em> a country of your choice to 
view the number and distribution of Starbucks stores in that 
country. <em>Click</em> on the circle related to your 
region of preference or manually zoom into the map if you'd like 
to see more specified distributions. If you'd like to know the 
<font color=#00b3b3>total number of Starbucks</font> in that 
country, just zoom out until there remains one circle. 
</h4>
<h4>
We have provided a <em>filter</em> option that will allow you 
to narrow down the number of stores displayed on the map specific
to your interest.
</h4>"

intro4 <- "<h4>
We've implemented tables of the <font color=#00b3b3>entire food 
and drink menu</font>, including some general and specified plots,
<font color=#00b33c>all</font> of which are <em>interactive</em>.
Meaning, that you can <font color=#00b3b3>pick and choose</font> the 
nutritional category of your interest and the data will be 
filtered to display your choices. The tables also include multiple
seach bars and a filter, so you can really specify your search to 
find your drink and nutritional facts of interest.
</h4>
<h3><font color=#036635>Are there better alternatives?</h3></font>
<h4>
Perhaps your menu item of interest has <font color=red>too much
</font> of something than your desired amount, but you <em>still
</em> want an item within the same category. Our tables are able 
to help you. Just click the category of your choice, filter and 
arrange the data, and choose the next best option. The
<font color=#00b3b3>simplicity</font> of utilizing our tables 
and plots are what will ultimately save you, the consumer, time.
</h4>"

intro5 <- "<h4>
Knowing how much caffeine you consume is important. There are
many negative side effects for consuming too much caffeine, and
some of the side effects are fast blood pressure,
anxiety, addiction, death and more. This is why we provided
a caffeine information page for Starbucks consumers. 
We care about people's health and well being. Starbucks labels
their caffeine in milligrams, however, most people do not know
how much that is. This is why we displayed the caffeine in amounts
of expresso shots. Consumers have a better understanding of the side
affects of a single shot than 64 milligrams of caffeine. It will 
allow consumers to choose their drinks based on the amount of caffeine
in each drink such as selecting drinks that best fit
the situation they are in. If the consumer is going to sleep 
soon, they can choose drinks with low or no caffeine. If
they are running low on sleep and is just getting their day 
started, they can choose the drinks with higher caffeine. 
Some of the starbucks drinks do not have a set amount of
caffeine listed because it varies, but it is still
worth knowing if a drink has caffeine or not.
</h4>"