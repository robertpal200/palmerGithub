




## Clustering 

dat <- scale(df) # scales all the data

#function for plotting elbow chart to decide what number of clusters K to specify 
wss <- function(k) {
  kmeans(df, k, nstart = 10)$tot.withinss
}

k.values <- 1:15

wss_values <- map_dbl(k.values, wss)

#visualizing the elbow chart
plot(k.values, wss_values, type = "b", pch = 19, frame = FALSE, xlab = "Num of Clusters", ylab="Tot within-clust sum-of-squares")

# clusters using kmeans
k2 <- kmeans(dat, centers = 3, nstart = 25)

#visualiziation of the clusters
library(factoextra)
visual<- fviz_cluster(k2, data = dat)

#Read in dataset for clustering
df <- read.csv('gapminder.csv')

df <- data[df$Year == '2015',] # filter the data df for only one year data, 

df$population <- as.numeric(gsub(",", "", df$population)) #remove commas from the thousands indicator in numbers

df <- na.omit(df)#Remove missing values

rownames(df) <- df$Country #The industry name will be on the cluster plot instead of row numbers.

dfXindia <- subset(df, Country!="India") # remove india from dataset

dfXindia <- subset(dfXindia, Country!="China") # remove china from dataset

df <- df[, c(3,4,5)] #select only life, population, and income
dfXindia <- dfXindia[, c(3,4,5)] #select only life, population, and income

dat <- scale(df)
datXindia <- scale(dfXindia)

#function for plotting elbow
wss <- function(k) {
  kmeans(df, k, nstart = 10)$tot.withinss
}

k.values <- 1:15

wss_values <- map_dbl(k.values, wss)


#visualiziation of the clusters
k2 <- kmeans(dat, centers = 3, nstart = 25)
visual<- fviz_cluster(k2, data = dat)
visual
##Regression


# Simple Scatterplot with linear model

plot(life ~ income, data= income, col = 'black', pch = 20, xlab = 'Income', ylab = 'Life Expectancy')

#visualizing the elbow chart
plot(k.values, wss_values, type = "b", pch = 19, frame = FALSE, xlab = "Num of Clusters", ylab="Tot within-clust sum-of-squares")

fit = lm(life ~ income, data = income)
abline(fit, col = 'red', lwd = 3)

summary(fit)

#four diagnostic charts for the linear model
par(mfrow=c(2,2))
plot(fit)
