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
png(filename = "plot2.png", width = 480, height = 480)
plot(mydata$Time, mydata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(mydata$Time, mydata$Global_active_power, type = 'l')
dev.off()