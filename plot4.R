# plot4
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

# Plot 4 multiple plots
png(file="plot4.png",width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4, 4, 1, 1), oma = c(0, 0, 2, 0))
# plot 1
plot(tab_f$DateTime,tab_f$Global_active_power,type = "l", 
     ylab = "Global Active Power",xlab="")
# plot 2
plot(tab_f$DateTime,tab_f$Voltage,type = "l", 
     ylab = "Voltage",xlab="datetime")
# plot 3
plot(tab_f$DateTime,tab_f$Sub_metering_1,type = "l", 
     ylab = "Energy sub metering",xlab="")
lines(tab_f$DateTime,tab_f$Sub_metering_2,col="red")
lines(tab_f$DateTime,tab_f$Sub_metering_3,col="blue")
legend("topright",lty = rep(1,3),col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
# plot 4
plot(tab_f$DateTime,tab_f$Global_reactive_power,type = "l", 
     ylab = "Global_reactive_power",xlab="datetime")
dev.off()
