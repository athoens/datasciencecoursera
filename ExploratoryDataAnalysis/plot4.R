if (!exists("NEI") || !exists("SCC")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
library(ggplot2)

# find SCC code for coal sources from SCC data frame
ind.SCC.coal <- grep("Coal", SCC$EI.Sector)
EI.Sector.Coal <- SCC$SCC[ind.SCC.coal]

NEI.coal <- NEI[NEI$SCC %in% EI.Sector.Coal,c(4,6)]
NEI.coal$year <- as.factor(NEI.coal$year)

png(filename = "plot4.png", width = 480, height = 480)
ggplot(NEI.coal, aes(year, Emissions) ) + geom_bar(stat = "identity", position="dodge") +
  ggtitle( "total emissions from coal combustion-related source across the US" ) + 
  theme(plot.title = element_text(hjust = 0.5))
dev.off()

