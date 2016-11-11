if (!exists("NEI") || !exists("SCC")) {
    NEI <- readRDS("data/summarySCC_PM25.rds")
    SCC <- readRDS("data/Source_Classification_Code.rds")
}

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
