if (!exists("NEI") || !exists("SCC")) {
  NEI <- readRDS("data/summarySCC_PM25.rds")
  SCC <- readRDS("data/Source_Classification_Code.rds")
}

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases in emissions 
# from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.
library(ggplot2)

ind.Balt <- which(NEI$fips == "24510")

png(filename = "plot3.png", width = 480, height = 480)
ggplot(NEI[ind.Balt,], aes(year, Emissions ) ) + geom_point(size = 3) + 
  geom_smooth(method="lm",se=FALSE) + facet_wrap(~type, scales = "free") +
  ggtitle( "Emission across the US from different types of sources" ) + 
  theme(plot.title = element_text(hjust = 0.5))
dev.off()

