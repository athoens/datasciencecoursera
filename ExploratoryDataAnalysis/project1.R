## 04. Exploratory Analysis
## Peer Graded Assignment: Course Project 1
##
## Making Plots

## reding data from the unzipped file
data_full <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep=";")

subdata <- subset(data_full, data_full$Date=="1/2/2007" | data_full$Date=="2/2/2007")

## merge Data/Time columns
subdata <- transform(subdata, Time = strptime(paste(Date,Time), "%d/%m/%Y%H:%M:%S"))
names(subdata)[names(subdata)=="Time"] <- "DateTime"

keep_names <- names(subdata)[2:9]
subdata <- subdata[keep_names]

## Plot 1: Global Active Power
png(filename = "plot1.png", width = 480, height = 480)
hist(subdata$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

## Plot 2: Global Active Power
png(filename = "plot2.png", width = 480, height = 480)
plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

## Plot 3: Energy sub metering
png(filename = "plot3.png", width = 480, height = 480)
par(mar = c(2,4,1,1))
plot(subdata$DateTime, subdata$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(subdata$DateTime, subdata$Sub_metering_2, col="red")
lines(subdata$DateTime, subdata$Sub_metering_3, col="blue")
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  lty=c(1,1,1), col=c("black","red","blue"), cex = 0.75)
dev.off()

## Plot 3: Multiple Plots
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1))
# plot 1
plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
# plot 2
plot(subdata$DateTime, subdata$Voltage, type="l", xlab = "dateline", ylab = "Voltage")
# plot 3
plot(subdata$DateTime, subdata$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(subdata$DateTime, subdata$Sub_metering_2, col="red")
lines(subdata$DateTime, subdata$Sub_metering_3, col="blue")
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  lty=c(1,1,1), col=c("black","red","blue"), cex = 0.75)
# plot 4
plot(subdata$DateTime, subdata$Global_reactive_power, type="l", xlab = "dateline", ylab = "Global_reactive_power")
dev.off()
