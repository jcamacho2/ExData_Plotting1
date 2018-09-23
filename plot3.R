#process data
library(dplyr)
library(lubridate)
mydata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
mydata <- filter(mydata, Date == "1/2/2007" | Date == "2/2/2007")
mydata[mydata == '?'] <- NA

mydata$Date <- dmy(mydata$Date)
mydata[, 3:9] <- sapply(mydata[,3:9], as.character)
mydata[, 3:9] <- sapply(mydata[,3:9], as.numeric)

mydata <- mutate(mydata, Time = paste(mydata$Date, mydata$Time))
mydata$Time <- strptime(mydata$Time, format = "%Y-%m-%d %H:%M:%S")

#plot data
png(filename = "plot3.png", width = 480, height = 480)

plot(mydata$Time, mydata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(mydata$Time, mydata$Sub_metering_1, type = "l")
lines(mydata$Time, mydata$Sub_metering_2, type = "l", col = "red")
lines(mydata$Time, mydata$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

dev.off()