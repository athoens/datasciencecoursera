## Statistical Inference - Final Project
## Part 1: Simulation Exercise - Exponential Distribution with R
# Author: Anastasia Thoens

# Title (give an appropriate title) and Author Name
# Overview: In a few (2-3) sentences explain what is going to be reported on.

# In the presented the exponential distribution is investigated in R and compared with the Central Limit Theorem. 
# The exponential distribution is simulated with rexp(n, lambda) where lambda is the rate parameter. 
# The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda. 

# Set the value lambda for all of the simulations. 
lambda = 0.2

# The distribution of averages of 40 exponentials is investigated.
# In total 1000 simulations are perfomed.

# dev.new()
# hist(rexp(1000, lambda),breaks=20)


mns.exp = NULL
for (i in 1 : 1000) mns.exp = c(mns.exp, mean(rexp(40, lambda))) 
dev.new()
hist(mns.exp,breaks=20)

lines(c(1/lambda,1/lambda),c(0,300),col="red",lwd=4)


mns.var = NULL
for (i in 1 : 1000) mns.var = c(mns.var, sd(rexp(40, lambda))) 
dev.new()
hist(mns.var,breaks=20)

lines(c(1/lambda,1/lambda),c(0,300),col="red",lwd=4)

# Simulations: Include English explanations of the simulations you ran, with the accompanying R code. Your explanations should make clear what the R code accomplishes.
# Sample Mean versus Theoretical Mean: Include figures with titles. In the figures, highlight the means you are comparing. Include text that explains the figures and what is shown on them, and provides appropriate numbers.
# Sample Variance versus Theoretical Variance: Include figures (output from R) with titles. Highlight the variances you are comparing. Include text that explains your understanding of the differences of the variances.
# Distribution: Via figures and text, explain how one can tell the distribution is approximately normal.