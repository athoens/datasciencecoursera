## 04. Exploratory Data Analysis
## Peer Graded Assignment: Course Project 2
##
## Fine particulate matter (PM2.5) air pollutantion

if (!file.exists("data")) {
    dir.create("data")
}

## downloading zipped data from the internet
if (!file.exists("data/summarySCC_PM25.rds")) {
    temp <- tempfile()
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileUrl, temp)
    unzip(temp, exdir = "./data")
    unlink(temp) 
}

if (!exists("NEI") || !exists("SCC")) {
    NEI <- readRDS("data/summarySCC_PM25.rds")
    SCC <- readRDS("data/Source_Classification_Code.rds")
}

## Questions
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# indices for each year 
ind.1999 <- which(NEI$year==1999)
ind.2002 <- which(NEI$year==2002)
ind.2005 <- which(NEI$year==2005)
ind.2008 <- which(NEI$year==2008)

# take total emissions per year
total.PM25.US <- c(sum(NEI$Emissions[ind.1999]), sum(NEI$Emissions[ind.2002]),
                              sum(NEI$Emissions[ind.2005]), sum(NEI$Emissions[ind.2008]))

## Plot 1: total emissions in the US
png(filename = "plot1.png", width = 480, height = 480)
barplot(total.PM25.US, 
        main="total emissions from PM2.5 in the United States",
        xlab="year", ylab = "Emissions (in total)",
        names.arg=c(1999,2002,2005,2008))
dev.off()


# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.
ind.1999.Balt <- which(NEI$fips == "24510" & NEI$year==1999)
ind.2002.Balt <- which(NEI$fips == "24510" & NEI$year==2002)
ind.2005.Balt <- which(NEI$fips == "24510" & NEI$year==2005)
ind.2008.Balt <- which(NEI$fips == "24510" & NEI$year==2008)
# take total emossions per year
total.PM25.Balt <- c(sum(NEI$Emissions[ind.1999.Balt]), sum(NEI$Emissions[ind.2002.Balt]),
                   sum(NEI$Emissions[ind.2005.Balt]), sum(NEI$Emissions[ind.2008.Balt]))
## Plot 2: total emossions in Baltimore City
png(filename = "plot2.png", width = 480, height = 480)
barplot(total.PM25.Balt, 
        main="total emissions from PM2.5 in Baltimore City",
        xlab="year", ylab = "Emissions (in total)",
        names.arg=c(1999,2002,2005,2008))
dev.off()

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases in emissions 
# from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
ind.Balt <- which(NEI$fips == "24510")
# NEI[ind.Balt,]
library(ggplot2)
png(filename = "plot3.png", width = 480, height = 480)
ggplot(NEI[ind.Balt,], aes(year, Emissions ) ) + geom_point(size = 3) + 
       geom_smooth(method="lm",se=FALSE) + facet_wrap(~type, scales = "free") +
       ggtitle( "Emission across the US from different types of sources" ) + 
       theme(plot.title = element_text(hjust = 0.5))
dev.off()

# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
ind.SCC.coal <- grep("Coal", SCC$EI.Sector)
EI.Sector.Coal <- SCC$SCC[ind.SCC.coal]

NEI.coal <- NEI[NEI$SCC %in% EI.Sector.Coal,c(4,6)]
NEI.coal$year <- as.factor(NEI.coal$year)

png(filename = "plot4.png", width = 480, height = 480)
ggplot(NEI.coal, aes(year, Emissions) ) + geom_bar(stat = "identity", position="dodge") +
  ggtitle( "total emissions from coal combustion-related source across the US" ) + 
  theme(plot.title = element_text(hjust = 0.5))
dev.off()


# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
ind.SCC.motor <- grep("Vehicle", SCC$EI.Sector)
EI.Sector.motor <- SCC$SCC[ind.SCC.motor]
NEI.motor <- NEI[(NEI$SCC %in% EI.Sector.motor) & (NEI$fips == "24510"),c(4,6)]
NEI.motor$year <- as.factor(NEI.motor$year)
png(filename = "plot5.png", width = 480, height = 480)
ggplot(NEI.motor, aes(year,Emissions) ) + geom_bar(stat = "identity", position="dodge" ) +
  ggtitle( "Emissions from motor vehicle sources in Baltimore City" ) + 
  theme(plot.title = element_text(hjust = 0.5))
dev.off()

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
NEI.motor <- NEI[(NEI$SCC %in% EI.Sector.motor) & (NEI$fips == "24510" | NEI$fips == "06037" ),c(1,4,6)]
NEI.motor$year <- as.factor(NEI.motor$year)
png(filename = "plot6.png", width = 480, height = 480)
ggplot(NEI.motor, aes(year, Emissions, fill=fips ) ) + geom_bar(stat = "identity", position="dodge") +
  ggtitle( "Emissions from motor vehicle sources in Baltimore City and California" ) + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_discrete( labels = c("California", "Baltimore City") ) +
  theme(legend.title = element_text(face="bold")) +
  guides(fill = guide_legend(title = "City", label.vjust = 0.5))
dev.off()

