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

png("plot2.png", width = 480, height = 480)
plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
