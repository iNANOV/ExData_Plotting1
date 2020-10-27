# plot2
Sys.setlocale("LC_ALL","en_US.UTF-8")
library(dplyr)
library(tidyr)

# import the original data
tab <- read.table("household_power_consumption.txt", header = TRUE,na.strings = "?",
                  colClasses = c(rep("character",2),rep("numeric",7)),sep = ";" )

# format the original the data; combine Date & Time into DateTime column; subset
tab_f <- unite(tab, "DateTime", Date,Time ,sep = " ", remove = TRUE, na.rm = FALSE) %>%
  mutate(DateTime = as.POSIXct(strptime(DateTime,"%d/%m/%Y %H:%M:%S"))) %>%
  filter(DateTime >= "2007-02-01 00:00:00",DateTime <= "2007-02-02 23:59:00")

# Plot 2 Global Active Power
png(file="plot2.png",width = 480, height = 480)
plot(tab_f$DateTime,tab_f$Global_active_power,type = "l", 
     ylab = "Global Active Power (kilowatts)",xlab="")
dev.off()
