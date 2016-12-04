if (!exists("NEI") || !exists("SCC")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
library(ggplot2)

# find SCC code for Vehicle sources from SCC data frame
ind.SCC.motor <- grep("Vehicle", SCC$EI.Sector)
EI.Sector.motor <- SCC$SCC[ind.SCC.motor]

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

