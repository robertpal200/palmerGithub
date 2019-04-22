
# base R approach to view the structure of an object
str(flights)
# dplyr approach: better formatting, and adapts to your screen width
library(dplyr)
glimpse(flights)

data$population <- as.numeric(gsub(",", "", data$population)) #remove commas from the thousands in numbers
data$population <- na.locf(data$population) #last observation before NA or a string of NA is used to replace na
data$income <- na.mean(data$income) # replace missing incomes with means
dfXindia <- subset(df, Country!="India") # remove india rows from dataset
df <- select(filter(df, income <= 100000),c(income,population)) # select using filter, specigy output rows

#finding missing data (NAs) 
missing <- df[which(is.na(df[,5])),  ] # the row slice of df where the column 5 has rows with NAs
uniqueMissingCount <- length(unique(missing$Country)) 

#subsetting data: 

#This gives only rows that have a given value for a variable: 
subsetDF <- subset(df, ColName == "a Value--or col number", select = c("ColName","ColName","ColName"))
#and we selected three columns for the output dataframe

#same thing using dplr package
library("dplyr")
df %>%  #  %>%this is the pipeline indicator in dplr
  filter(Year == 2007)
  
df %>% 
 group_by(region) %>%  
  summarise(lifeExpectancy = median(lifeExpectancy))  %>%
  aggregate(life ~ region, data, median)

#filtering useing dplr--use comma or ampersand for AND
filter(df, Month==1 & DayofMonth==1)
# use pipe for OR condition
filter(df, UniqueCarrier=="AA" | UniqueCarrier=="UA")



#parse_number() **in readr library** ignores non-numeric characters before and after the number, e.g currencies

parse_number("$100")
#> [1] 100
parse_number("20%")
#> [1] 20
parse_number("It cost $123.45")
#> [1] 123

## arrange: Reorder rows using dplyr 
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay)

# use `desc` for descending
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(desc(DepDelay))

## mutate: Add new variables that are functions of existing variables

# base R approach to create a new variable Speed (in mph)
flights$Speed <- flights$Distance / flights$AirTime*60
flights[, c("Distance", "AirTime", "Speed")]

# dplyr approach (prints the new variable but does not store it)
flights %>%
  select(Distance, AirTime) %>%
  mutate(Speed = Distance/AirTime*60)
# store the new variable
flights <- flights %>% mutate(Speed = Distance/AirTime*60)

## summarise: Reduce variables to values

# use with data that has been grouped by one or more variables
# 'group_by` creates the groups that will be operated on
# `summarise` uses the provided aggregation function to summarise each group


# base R approaches to calculate the average arrival delay to each destination
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE)))
head(aggregate(ArrDelay ~ Dest, flights, mean))

# dplyr approach: create a table grouped by Dest, and then summarise each group 
#by taking the mean of ArrDelay

flights %>%
  group_by(Dest) %>%
  summarise(avg_delay = mean(ArrDelay, na.rm=TRUE))

# `summarise_each` allows you to apply the same summary function to multiple columns at once

# for each carrier, calculate the percentage of flights cancelled or diverted
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean), Cancelled, Diverted)
# for each carrier, calculate the minimum and maximum arrival and departure delays
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm=TRUE), max(., na.rm=TRUE)), matches("Delay"))

#`n()` counts the number of rows in a group
# `n_distinct(vector)` counts the number of unique items in that vector

# for each day of the year, count the total number of flights and sort in descending order
flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flight_count = n()) %>%
  arrange(desc(flight_count))
# rewrite more simply with the `tally` function
flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort = TRUE)
# for each destination, count the total number of flights and the number of distinct planes that flew there
flights %>%
  group_by(Dest) %>%
  summarise(flight_count = n(), plane_count = n_distinct(TailNum))

# for each destination, show the number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table() %>%
  head()

```{r results='hide'}
# for each carrier, calculate which two days of the year they had their longest departure delays
# note: smallest (not largest) value is ranked as 1, so you have to use `desc` to rank by largest value
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 2) %>%
  arrange(UniqueCarrier, desc(DepDelay))
```

```{r}
# rewrite more simply with the `top_n` function
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%
  arrange(UniqueCarrier, desc(DepDelay))
# for each month, calculate the number of flights and the change from the previous month
flights %>%
  group_by(Month) %>%
  summarise(flight_count = n()) %>%
  mutate(change = flight_count - lag(flight_count))
# rewrite more simply with the `tally` function
flights %>%
  group_by(Month) %>%
  tally() %>%
  mutate(change = n - lag(n))
```
# writing out a new csv file
write.csv(df, "data.csv")


