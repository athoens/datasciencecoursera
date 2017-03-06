## Peer-graded Assignment: Course Project 2
# Code for the report

# downloading zipped data from the internet
if (!file.exists("data/StormData.csv.bz2")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
  download.file(fileUrl, "data/StormData.csv.bz2")
}


## read the data with read.csv from zipped file and check processing time
path.bz<-paste("./data/StormData.csv.bz2", sep =",")
ptm.bz2 <- Sys.time()
dt <- read.csv(path.bz)
ptm.bz2 <- Sys.time() - ptm.bz2
# display
ptm.bz2
## Here Time difference of 3.340411 mins

library(data.table)
## read the data with fread from zipped file and check processing time
ptm.fread <- Sys.time()
dt <- fread(sprintf("bzcat %s", path.bz))
ptm.fread <- Sys.time() - ptm.fread
# display
ptm.fread
## Here Time difference of 53.99299 secs, much faster then read.csv

## read the data with 'read.table from zipped file and check processing time
ptm.table <- Sys.time()
dt <- read.table(path.bz, header = TRUE, sep = ",")
ptm.table <- Sys.time() - ptm.table
# display
ptm.table
## Time difference of 3.244764 mins

library(R.utils)
## unziip with bunzip2 and measure the processing time
ptm.unzip <- Sys.time()
if (!file.exists("data/StormData.csv")) {
  bunzip2(path, "data/StormData.csv", remove = FALSE, skip = TRUE)
}
ptm.unzip <- Sys.time() - ptm.unzip
# display
ptm.unzip
## here Time difference of 39.98529 secs

## read the data from csv file and measure processing time
path<-paste("./data/StormData.csv", sep =",")
ptm.csv <- Sys.time()
dt <- read.csv(path)
ptm.csv <- Sys.time() - ptm.csv
# display
ptm.csv
## Here Time difference of 1.930342 mins
## However, unzipped data take 11.4 times more space
path<-paste("./data/StormData.csv", sep =",")
ptm.fread <- Sys.time()
dt <- fread(path)
ptm.fread <- Sys.time() - ptm.fread
# display
ptm.fread

path<-paste("./data/StormData.csv", sep =",")
ptm.table <- Sys.time()
dt <- read.table(path)
ptm.table <- Sys.time() - ptm.table
# display
ptm.table



### Cleaning data
library(reshape2)
library(lubridate)
dt$BGN_DATE <- mdy(colsplit(string = dt$BGN_DATE, pattern=" ", 
                        names = c("Part1", "Part2"))$Part1)

# untill 1992 data
dt1992 <- dt[dt$BGN_DATE <= ymd(19921231),]
evtype1992 <- table(dt1992$EVTYPE)
head(evtype1992)


# since 1996 data
dt1996 <- dt[dt$BGN_DATE >= ymd(19960101),]
evtype1996 <- table(dt1996$EVTYPE)
length(evtype1996)

# reducing the size of the data frame: drop columns
keeps <- c("STATE__", "BGN_DATE", "STATE", "EVTYPE", "LENGTH", "WIDTH", "F", "MAG", 
           "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP", "WFO")
dt.sm <- subset(dt, select = keeps)



# in the following I will analyse the number of fatalities and injuries due to the listed weather events
# For that let's create a reduced data frame with EVTYPE (types of events), FATALITIES and INJURIES collumns
ind.names <- c(which(names(dt)=="EVTYPE"), 
               which(names(dt)=="FATALITIES"), 
               which(names(dt)=="INJURIES"))
storm.harm <- dt[ind.names]

aggdata <-aggregate(. ~ EVTYPE, storm.harm, sum)
sort.inj <- aggdata[order(-aggdata$INJURIES),] 
sort.fatal <- aggdata[order(-aggdata$FATALITIES),] 

# show the first entries of both ordered data frames
head(sort.inj[,c(1,3)])
head(sort.fatal[,c(1,2)])


