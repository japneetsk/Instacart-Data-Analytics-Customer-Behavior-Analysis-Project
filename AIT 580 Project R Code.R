

# set your working directory to the location data files
setwd("instacart_2017_05_01")

# read and save data in an R object, a dataset

# aisles
aisles <- read.csv("aisles.csv")

# departments
departments <- read.csv("departments.csv")

# order_products_prior
order_products_prior <- read.csv("order_products__prior.csv")

# orders
orders <- read.csv("orders.csv")

# Products
products <- read.csv("products.csv")

# the above files may be used for analysis as required.
# however, data was exported from Oracle SQL Developer, which we intend to use in this project.
# need to import this data in R
# set working directory to location where exported file is saved
setwd("Data Analysis Project")

order_details <- read.csv("export.csv")

# get structure of data
str(order_details)

summary(order_details)

# select only numeric columns for finding correlation
order_details_numeric <- order_details[,sapply(order_details,is.numeric)]
# find pairwise correlation between all numeric columns
cor(order_details_numeric, use = "complete.obs")

# create scatter plot with regression line for REORDERED and ORDER_NUMBER

x <- order_details_numeric$REORDERED
y <- order_details_numeric$ORDER_NUMBER

plot(x, y, main = "Scatterplot Between Reordered Items and Order Number",
     xlab = "Reordered", ylab = "Order Number",
     pch = 19, frame = FALSE)


boxplot(x~y, data=order_details_numeric,
        xlab = "Order Number", ylab = "Reordered", main = "Boxplot Between Reordered Items and Order Number")

#abline(lm(y ~ x, data = order_details_numeric), col = "blue")

lregression <- lm(x ~ y, data = order_details_numeric)
summary(lregression)
