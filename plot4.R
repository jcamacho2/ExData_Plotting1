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
png(filename = "plot4.png", width = 480, height = 480)
#change mfrow to allow 2 rows and 2 columns of plots
par(mfrow = c(2,2))

plot(mydata$Time, mydata$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
lines(mydata$Time, mydata$Global_active_power, type = 'l')

plot(mydata$Time, mydata$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

plot(mydata$Time, mydata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(mydata$Time, mydata$Sub_metering_1, type = "l")
lines(mydata$Time, mydata$Sub_metering_2, type = "l", col = "red")
lines(mydata$Time, mydata$Sub_metering_3, type = "l", col = "blue")
#bty = "n" means no  box drawn around legend.
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty = "n", col = c("black", "red", "blue"), lty = 1)

plot(mydata$Time, mydata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()