## 03. Getting and Cleaning Data Course 
## Peer Graded Assignment: Course Project 2
##
## Getting and Cleaning Data Course Project
## data Human Activity Recognition Using Smartphones Dataset

if (!file.exists("data")) {
    dir.create("data")
}

## downloading zipped data from the internet
if (!file.exists("data/UCI HAR Dataset")) {
    temp <- tempfile()
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, temp)
    unzip(temp, exdir = "./data")
    unlink(temp) 
}

## reading test data (30% of all test subjects)
testfiles <- "./data/UCI HAR Dataset/test/X_test.txt"
testdataX = read.table(testfiles)
testfiles <- "./data/UCI HAR Dataset/test/subject_test.txt"
subject.test = read.table(testfiles)
testfiles <- "./data/UCI HAR Dataset/activity_labels.txt"
activity_labels = read.table(testfiles)
testfiles <- "./data/UCI HAR Dataset/features.txt"
features = read.table(testfiles)
testfiles <- "./data/UCI HAR Dataset/test/y_test.txt"
testdataY = read.table(testfiles)

## reading training data (70% of all test subjects)
trainfiles <- "./data/UCI HAR Dataset/train/X_train.txt"
traindataX = read.table(trainfiles)
trainfiles <- "./data/UCI HAR Dataset/train/subject_train.txt"
subject.train = read.table(trainfiles)
trainfiles <- "./data/UCI HAR Dataset/train/y_train.txt"
traindataY = read.table(trainfiles)

## 1. Merge the training and the test sets to create one data set.
## merge two test and training sets in one in the order test-train
dataX.full <- rbind2(testdataX, traindataX)
dataY.full <- rbind2(testdataY, traindataY)
test.subjects.all <- rbind2(subject.test, subject.train)

## 3. Use descriptive activity names to name the activities in the data set
## cleaning activity labels as.factor for each test case
for(i in 1:nrow(dataY.full)) {
    dataY.full$V1[i] <- as.character(activity_labels$V2[which(activity_labels$V1==dataY.full$V1[i])])
}
dataY.full$V1 <- as.factor(dataY.full$V1)

## 4. Appropriately label the data set with descriptive variable names.
## creating the full data frame and labeling the data set 
activity.dataset <- data.frame(c(test.subjects.all, dataY.full, dataX.full))
names(activity.dataset) <- c("testsubject", "activity",as.character(features$V2))

## 2. Extract only the measurements on the mean and standard deviation for each measurement.
## Note: here, does not iclude variable angle() for any mesurements or thier mean
ind.mean <- grep("mean\\(\\)", names(activity.dataset))
ind.std <- grep("std", names(activity.dataset))

extr.activity.data <- activity.dataset[c(1,2,ind.mean,ind.std)]

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
activity.data.average <- data.frame(matrix(vector(), 0, 81), stringsAsFactors=F)

for (i in 1:30) {
    for (j in 1:6) {
        ind.sub.j <- which(extr.activity.data$testsubject == i & 
                       extr.activity.data$activity==activity_labels$V2[j])
        mean.col <- colMeans(extr.activity.data[c(ind.sub.j), 3:ncol(extr.activity.data)])
        
        activity.data.average <- rbind2(activity.data.average,
                                        c(i, j, mean.col))
    }
}
names(activity.data.average) <- names(extr.activity.data)

for (i in 1:6) {
    ind.activity <- which(activity.data.average$activity==i)
    activity.data.average$activity[ind.activity] <-
        as.character(activity_labels$V2[i])
}
activity.data.average$activity <- as.factor(activity.data.average$activity)

library(reshape2)
tidy.average.activity <- melt(activity.data.average[,c(1,2,3:68)], 
                              id.vars=(names(activity.data.average)[1:2]),
                              measure.vars=(names(activity.data.average)[3:68]),
                              variable.name = "feature")
tidy.average.activity$feature <- as.character(tidy.average.activity$feature)
names(tidy.average.activity)[4] <- "meanvalue"

write.table(tidy.average.activity, "tidyHAR_USD.txt")
