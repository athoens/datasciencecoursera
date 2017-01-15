## Statistical Inference - Final Project
## Part 2: Basic Inferential Data Analysis
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

# Load the ToothGrowth data and perform some basic exploratory data analyses
data(ToothGrowth)
ToothGrowth <- data.table(ToothGrowth) 
names(ToothGrowth) <- c("tooth.length", "supplement.type", "dose")
ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# Basic scatterplot
p1 <- ggplot(ToothGrowth, aes(x = dose, y = tooth.length, color=supplement.type))
p1 + geom_boxplot() + geom_point(size = 3, shape=1) +
      scale_color_manual(name   = "Supplement type", 
                         values = c("orange", "blue"), 
                         labels = c("orange juice", "ascorbic acid")) +
      labs(title="The Effect of Vitamin C on Tooth Growth in Guinea Pigs", 
           x="Dose in milligrams/day", y="Tooth length") 

## Provide a basic summary of the data.


## Use confidence intervals and/or hypothesis tests to compare tooth growth by supp and dose. 
## (Only use the techniques from class, even if there's other approaches worth considering)

g1 <- ToothGrowth$tooth.length[ToothGrowth$supplement.type=="VC"]
g2 <- ToothGrowth$tooth.length[ToothGrowth$supplement.type=="OJ"]
difference <- g2 - g1
mn <- mean(difference)
s <- sd(difference)
n <- 30

t.test(difference)

t.test(g2, g1, paired = FALSE)
t.test(tooth.length ~ supplement.type, paired = FALSE, data = ToothGrowth)

t.test(tooth.length ~ supplement.type, paired = FALSE, ar.equal = TRUE,  data = ToothGrowth)

# The H_0 hypothesis
# "OJ affects less or the same then VC", H_0 : mu  \leq 0, 
# H_1 : mu > 0
Z <- sqrt(n)*(mn - 0)/s
# The 95th percentile of a normal distribution
Z.alphy <- qnorm(0.95)

## State your conclusions and the assumptions needed for your conclusions.



