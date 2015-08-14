setwd("~/R")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- "data.zip"
download.file(url, dest, method = "curl", mode = "wb")

unzip(dest)
temp <- "household_power_consumption.txt"
data <- read.table(temp, header=TRUE, sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")
data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
days <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
data <- subset(data, Date %in% days)

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))	
plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(data$Time, data$Voltage, type = "l", xlab = "datetime", ylab = "Global Active Power")
plot(data$Time, data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(data$Time, data$Sub_metering_2, type = "l", col = "red")
lines(data$Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "red", "blue"), bty = "n")
plot(data$Time, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Active Power")
dev.off()