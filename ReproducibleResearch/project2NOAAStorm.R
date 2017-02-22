## Peer-graded Assignment: Course Project 2
# Code for the report

# downloading zipped data from the internet
if (!file.exists("data/StormData.csv.bz2")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
  download.file(fileUrl, "data/StormData.csv.bz2")
}

path<-paste("./data/StormData.csv.bz2", sep =",")
storm.data <- read.csv(path)

#str(storm.data$EVTYPE)


# in the following I will analyse the number of fatalities adn injuries due to the listed weather events
# For that let's create a reduced data frame with EVTYPE (types of events), FATALITIES and INJURIES collumns
ind.names <- c(which(names(storm.data)=="EVTYPE"), 
               which(names(storm.data)=="FATALITIES"), 
               which(names(storm.data)=="INJURIES"))
storm.harm <- storm.data[ind.names]

aggdata <-aggregate(. ~ EVTYPE, storm.harm, sum)
sort.inj <- aggdata[order(-aggdata$INJURIES),] 
sort.fatal <- aggdata[order(-aggdata$FATALITIES),] 

# show the first entries of both ordered data frames
head(sort.inj[,c(1,3)])
head(sort.fatal[,c(1,2)])

