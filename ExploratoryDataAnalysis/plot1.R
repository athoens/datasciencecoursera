if (!exists("NEI") || !exists("SCC")) {
    NEI <- readRDS("data/summarySCC_PM25.rds")
    SCC <- readRDS("data/Source_Classification_Code.rds")
}

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# indices for each year 
ind.1999 <- which(NEI$year==1999)
ind.2002 <- which(NEI$year==2002)
ind.2005 <- which(NEI$year==2005)
ind.2008 <- which(NEI$year==2008)

# take total emossions per year
total.PM25.US <- c(sum(NEI$Emissions[ind.1999]), sum(NEI$Emissions[ind.2002]),
                   sum(NEI$Emissions[ind.2005]), sum(NEI$Emissions[ind.2008]))

## Plot 1: total emossions in the US
png(filename = "plot1.png", width = 480, height = 480)
barplot(total.PM25.US, 
        main="total emissions from PM2.5 in the United States",
        xlab="year", ylab = "Emissions (in total)",
        names.arg=c(1999,2002,2005,2008))
dev.off()
