

plot(hist.data, col = 'blue' )  # simple histogram

#to see the life expectancy over time across different regions using ggplot
library(ggplot2)
ggplot(data) + 
  geom_point(aes(x=Year, y=life), alpha = 1/10) +
  xlab('Year') +
  ylab('Life Expectancy') +
  theme(axis.title.x=element_text(angle=0, color='black', size = 14), axis.title.y=element_text(angle=90, color='black', face='bold', size=14)) +
  facet_wrap(~region) + # this creates separate graphs for each region of the six different regions in the region column
  theme(strip.text.x = element_text(size = 12, colour = "blue"), axis.text=element_text(size=12), axis.title=element_text(size=12,face="bold")) 

mpg

#Creating a ggplot
#To plot mpg, run this code to put displ on the x-axis and hwy on the y-axis:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#    Let's turn this code into a reusable template for making graphs with ggplot2. 
# To make a graph, replace the bracketed sections in the code below with a dataset, 
# a geom function, or a collection of mappings.

#ggplot(data = <DATA>) + 
#  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

#you can also put two different geometric functions on one plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#If you place mappings in a geom function, ggplot2 will treat them as local mappings
#for the layer. It will use these mappings to extend or overwrite the global
#mappings for that layer only. This makes it possible to display different 
#aesthetics in different layers.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()


#You can  pass a set of mappings to ggplot(). ggplot2 will treat these mappings as 
#global mappings that apply to each geom in the graph. 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# position = "dodge" places overlapping objects directly beside one another. This makes it easier to compare individual values.

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")  


#coord_flip() switches the x and y axes. This is useful (for example), 
#if you want horizontal boxplots. It's also useful for long labels: it's hard to 
#get them to fit without overlapping on the x-axis.

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

# One way to add additional variables is with aesthetics. Another way, particularly
#useful for categorical variables, is to split your plot into facets, subplots 
#that each display one subset of the data.

#To facet your plot by a single variable, use facet_wrap(). 
#The first argument of facet_wrap() should be a formula, which you create 
#with ~ followed by a variable name (here "formula" is the name of a data 
#structure in R, not a synonym for "equation"). The variable that you pass 
#to facet_wrap() should be discrete.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)