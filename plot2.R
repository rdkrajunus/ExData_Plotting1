# Extract the dataset in the HW description to the same directory as this R
# script.  This script is dependent on the dplyr package, which should be
# installed prior to running this script.  Install dplyr and lubridate with:
# install.packages("dplyr")
# install.packages("lubridate")
library(dplyr)
library(lubridate)
ssv <- data.frame(read.table(
    file = "household_power_consumption.txt", header = TRUE, sep = ";",
    na.strings = c("?")))

GlobalActivePowerFeb1Thru2 <- ssv %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(dateTime = dmy_hms(paste(Date, Time, sep = " "))) %>%
    select(dateTime, Global_active_power)

plot(GlobalActivePowerFeb1Thru2$dateTime,
     GlobalActivePowerFeb1Thru2$Global_active_power, type = "l", xlab="",
     ylab="Global Active Power (kilowatts)")

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()