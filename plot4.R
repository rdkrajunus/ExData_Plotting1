# Extract the dataset in the HW description to the same directory as this R
# script.  This script is dependent on the lubridate and dplyr packages, which
# should be installed prior to running this script.  Install lubridate and
# dplyr with:
#
# install.packages("dplyr")
# install.packages("lubridate")

library(dplyr)
library(lubridate)

generateColTypes <- function() {
    types <- rep("NULL", 9)
    types[1:2] <- "character"
    types[c(3:5, 7:9)] <- "numeric"
    types
}

colTypes <- generateColTypes()

ssv <- ssv <- read.table(file = "household_power_consumption.txt",
                         header = TRUE, sep = ";", na.strings = c("?"),
                         colClasses = colTypes, nrows=75000)

graphData <- ssv %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(dateTime = dmy_hms(paste(Date, Time, sep = " ")))

png("plot4.png", 480, 480)
par(mfrow=c(2, 2))

#upper left
plot(graphData$dateTime,
     graphData$Global_active_power, type = "l", xlab="",
     ylab="Global Active Power (kilowatts)")

#upper right
plot(graphData$dateTime, graphData$Voltage, type = "l", xlab="datetime",
     ylab="Voltage")

#lower left
plot(x=graphData$dateTime, y=graphData$Sub_metering_1, type = "n", xlab="",
     ylab="Energy sub metering")
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
lines(graphData$dateTime, graphData$Sub_metering_1, type = "l", col = "black")
lines(graphData$dateTime, graphData$Sub_metering_2, type = "l", col = "red")
lines(graphData$dateTime, graphData$Sub_metering_3, type = "l", col = "blue")

#lower right
plot(graphData$dateTime, graphData$Global_reactive_power, type = "l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()