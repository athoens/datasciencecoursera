if (!exists("NEI") || !exists("SCC")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
library(ggplot2)

# find SCC code for Vehicle sources from SCC data frame
ind.SCC.motor <- grep("Vehicle", SCC$EI.Sector)
EI.Sector.motor <- SCC$SCC[ind.SCC.motor]
NEI.motor <- NEI[(NEI$SCC %in% EI.Sector.motor) & (NEI$fips == "24510"),c(4,6)]
NEI.motor$year <- as.factor(NEI.motor$year)

png(filename = "plot5.png", width = 480, height = 480)
ggplot(NEI.motor, aes(year,Emissions) ) + geom_bar(stat = "identity", position="dodge" ) +
  ggtitle( "Emissions from motor vehicle sources in Baltimore City" ) + 
  theme(plot.title = element_text(hjust = 0.5))
dev.off()
