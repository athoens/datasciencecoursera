## Introduction

# It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a Fitbit, Nike Fuelband, or Jawbone Up. These type of devices are part of the "quantified self" movement - a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

# This assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

if (!file.exists("data")) {
  dir.create("data")
}

## downloading zipped data from the internet
if (!file.exists("data/activity.csv")) {
  temp <- tempfile()
  fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
  download.file(fileUrl, temp)
  unzip(temp, exdir = "./data")
  unlink(temp) 
}
# The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.
# Dataset: Activity monitoring data [52K]
path<-paste("./data/activity.csv", sep =",")
activity.data <- read.csv(path)

# The variables included in this dataset are:
#
#   steps:    Number of steps taking in a 5-minute interval (missing values are coded as NA)
#   date:     The date on which the measurement was taken in YYYY-MM-DD format
#   interval: Identifier for the 5-minute interval in which measurement was taken

#str(activitydata)
summary(activity.data)

## Commit containing full submission

# 1. Code for reading in the dataset and/or processing the data
# 2. Histogram of the total number of steps taken each day
# 3. Mean and median number of steps taken each day
# 4. Time series plot of the average number of steps taken
# 5. The 5-minute interval that, on average, contains the maximum number of steps
# 6. Code to describe and show a strategy for imputing missing data
# 7. Histogram of the total number of steps taken each day after missing values are imputed
# 8. Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends
# 9. All of the R code needed to reproduce the results (numbers, plots, etc.) in the report

## What is mean total number of steps taken per day?

# Find levels of factor 'date' to identify the dates
steps.day <- aggregate(steps ~ date, activity.data, sum)

# Calculate and report the mean and median of the total number of steps taken per day
mean.steps <- mean(steps.day$steps, na.rm = TRUE)
mean.steps
median.steps <- median(steps.day$steps)
median.steps

dev.new()
hist(steps.day$steps,breaks=15, xlab="steps", col="gray", main="Total number of steps taken each day")
lines(c(mean.steps,mean.steps),c(0,18), col="red",lwd=4)

## What is the average daily activity pattern?
# Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
steps.daily <- aggregate(steps ~ interval, activity.data, sum)
plot(steps.daily$interval, steps.daily$steps, type="l", col="blue", lwd=2, xlab="time interval", ylab="steps", main="Average number of steps in 5-minute interval during a day") 

# Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
steps.daily$interval[which.max(steps.daily$steps)]

## Imputing missing values

# Note that there are a number of days/intervals where there are missing values (coded as NA). The presence of missing days may introduce bias into some calculations or summaries of the data.

# 1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
sum(rowSums(is.na(activity.data))==1)

# 2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
steps.daily.mean <- aggregate(steps ~ interval, activity.data, mean)
ind.na = which(is.na(activity.data)==1)

# 3. Create a new dataset that is equal to the original dataset but with the missing data filled in.

activity.data.filled <- activity.data
for (i in 1 : length(ind.na)) {
  activity.data.filled[ind.na[i],1] <- steps.daily.mean[which(steps.daily.mean[,1]==activity.data.filled[ind.na[i],3]),2]
}

sum((is.na(activity.data.filled))==1)

# 4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
steps.day.filled <- aggregate(steps ~ date, activity.data.filled, sum)
mean.steps.filled <- mean(steps.day.filled$steps, na.rm = TRUE)
mean.steps.filled
median.steps.filled <- median(steps.day.filled$steps)
median.steps.filled

dev.new()
hist(steps.day.filled$steps,breaks=15, xlab="steps", col="gray", main="Total number of steps taken each day")
lines(c(mean.steps.filled,mean.steps.filled),c(0,18), col="red",lwd=4)

## Are there differences in activity patterns between weekdays and weekends?

# For this part the weekdays() function may be of some help here. Use the dataset with the filled-in missing values for this part.
#library(lubridate)
str(as.numeric(strftime(as.Date(activity.data[,2]),'%u')))

# 1. Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.
weekdays <- 1:length(activity.data[,1])
for (i in 1 : length(activity.data[,1])) {
  if (as.numeric(strftime(as.Date(activity.data[i,2]),'%u')) < 6) {
    weekdays[i] <- 0 #factor(x = "weekday")
  } else {
    weekdays[i] <- 1 #factor(x = "weekend")
  }
}
weekdays.f <- factor(weekdays, labels = c("weekday", "weekend"))
  
activity.data$weekdays <- weekdays.f

# 2. Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.
ind.weekday <- which(weekdays.f == "weekday")
ind.weekend <- which(weekdays.f == "weekend")

steps.weekday.mean <- aggregate(steps ~ interval, activity.data[ind.weekday,], mean)
steps.weekend.mean <- aggregate(steps ~ interval, activity.data[ind.weekend,], mean)
# 2 figures arranged in 2 rows and 1 column
dev.new()
par(mfrow=c(2,1)) 
plot(steps.weekday.mean$interval, steps.weekday.mean$steps, type="l", col="blue", lwd=2, xlab="time interval", ylab="Number of steps", main="Average number of steps in 5-minute interval during a weekday")
plot(steps.weekend.mean$interval, steps.weekend.mean$steps, type="l", col="blue", lwd=2, xlab="time interval", ylab="Number of steps", main="Average number of steps in 5-minute interval during a weekend day")


