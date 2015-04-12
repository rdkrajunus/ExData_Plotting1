# Extract the dataset in the HW description to the same directory as this R
# script.  This script is dependent on the dplyr package, which should be
# installed prior to running this script.  Install dplyr with:
# install.packages("dplyr")
library(dplyr)
ssv <- data.frame(read.table(
    file = "household_power_consumption.txt", header = TRUE, sep = ";",
    na.strings = c("?")))

GlobalActivePowerFeb1Thru2 <- ssv %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    #mutate(dateTime = as.character(strptime(paste(Date, Time, sep = " "), "%e/%m/%Y %T"))) %>%
    select(Global_active_power)

hist(GlobalActivePowerFeb1Thru2$Global_active_power,
     xlab = "Global Active Power (kilowatts)", main="Global Active Power",
     col="red")

dev.copy(png, "plot1.png", width=480, height=480)
dev.off()