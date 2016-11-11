# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999-2008 for Baltimore City? Which have seen increases in emissions 
# from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

ind.Balt <- which(NEI$fips == "24510")
NEI.Baltimore <- NEI[ind.Balt,]
types <- c("POINT","NONPOINT","NON-ROAD", "ON-ROAD")
years <- c(1999,2002,2005,2008)
NEI.Balt.sums <- data.frame(matrix(vector(), 0, 81), stringsAsFactors=F)
type <- as.character(c(1:16))
year <- c(1:16)
tot.emissions <- c(1:16)

for (i in types) {
    for (j in years) {
        #print(c(i, j))
        ind.sub.j <- which(NEI.Baltimore$type == i & 
                           NEI.Baltimore$year == j)
        sum.col <- sum(NEI.Baltimore[c(ind.sub.j), 4])
        
        NEI.Balt.sums <- rbind2(NEI.Balt.sums,
                                c(i, as.character(j), as.character(sum.col)))
    }
}

#library(ggplot2)
#qplot(year, Emissions, NEI[ind.Balt,], geom="bar")