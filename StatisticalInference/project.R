## Statistical Inference - Final Project
## Part 1: Simulation Exercise Instructions


dev.new()
hist(rexp(1000, lambda),breaks=20)

lambda = 0.2
mns.exp = NULL
for (i in 1 : 1000) mns.exp = c(mns.exp, mean(rexp(40, lambda))) 
dev.new()
hist(mns.exp,breaks=20)

lines(c(1/lambda,1/lambda),c(0,300),col="red",lwd=4)


mns.var = NULL
for (i in 1 : 1000) mns.var = c(mns.var, mean(rexp(40, lambda))) 
dev.new()
hist(mns.var,breaks=20)

lines(c(1/lambda,1/lambda),c(0,300),col="red",lwd=4)

## Part 2: Basic Inferential Data Analysis Instructions
## The Effect of Vitamin C on Tooth Growth in Guinea Pigs
## A data frame with 60 observations on 3 variables.
## 
## [,1]	len 	numeric	Tooth length
## [,2]	supp	factor	Supplement type (VC or OJ).
## [,3]	dose	numeric	Dose in milligrams/day
##
## Source
## C. I. Bliss (1952) The Statistics of Bioassay. Academic Press.
## 
## References
##
## McNeil, D. R. (1977) Interactive Data Analysis. New York: Wiley.
library(datasets)
library(data.table)
library(ggplot2)
data(ToothGrowth)
ToothGrowth <- data.table(ToothGrowth) 
names(ToothGrowth) <- c("tooth.length", "supplement.type", "dose")

# Basic scatterplot
p1 <- ggplot(ToothGrowth, aes(x = dose, y = tooth.length, color=supplement.type))
# Print plot with default points
p1 + geom_point(size = 3, shape=1) +
    scale_color_manual(name   = "Supplement type", 
                       values = c("orange", "blue"), 
                       labels = c("orange juice", "ascorbic acid")) + 
    labs(x="Dose in milligrams/day", y="Tooth length") +
    geom_smooth(method = lm, se=FALSE, fullrange=TRUE)

## Provide a basic summary of the data.

## Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. 
## (Only use the techniques from class, even if there's other approaches worth considering)

## State your conclusions and the assumptions needed for your conclusions.
