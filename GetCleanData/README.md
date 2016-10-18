# Getting and Cleaning Data Course Project
### Description
Peer Graded Assignment - 2nd Project to *Getting and Cleaning Data* course of *Data Science* specialization. The task is to create an independent tidy data set based on the raw data collected from the accelerometers from the Samsung Galaxy S smartphone.

### Obtaining the data set from Git repo
To get the tidy data set from Git repository run the following code line in R.
```
download.file("https://raw.githubusercontent.com/athoens/datasciencecoursera/master/GetCleanData/averageHAR_USD.txt", "datagit.txt")

data <- read.table("datagit.txt", header = TRUE)
```

### Steps performed
The code `run_analysis.R` first creates a directory `data`, downloads and unzips the *Human Activity Recognition Using Smartphones Dataset* raw data set from `cloudfront.net`  (if not existant already).
The steps creating the tidy data set are described in the Codebook.

* The training and the test sets were merged to create one data set by use of `read.table(filename)` for each file involved and `rbind2` function.
* The activity labels were substituted by descriptive activity names (`factor` class) to name the activities in the data set with a loop through the number of rows.
* List of all features from `features.txt` file was used to appropriately label the data set with descriptive variable names.
* Only the measurements on the mean and standard deviation for each measurement were extracted. _Note_: my choise of mean values is limited by mean values of the measured variables excluding averaged signals in `angle()` variable and a mean frequency `meanFreq()`.
* From the data set of the mean and standard deviation an independent data set was created with the average of each variable for each activity and each subject (30x6 loop creates the entries for each variable).


The generated tidy data text file meets the principles of [Tidy Data by H. Wickham](http://vita.had.co.nz/papers/tidy-data.pdf):

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.
