library(dplyr)
library(lubridate)

setwd("C:/Users/asuarez8/Desktop")
filename = "household_power_consumption.txt"
tab5rows = read.table(filename, header=TRUE, nrows=5)
classes = sapply(tab5rows, class)
df = read.table(filename, header=TRUE, sep=";", colClasses=classes)


df$Date = dmy(df$Date)
df = subset(df, Date=="2007-02-01" | Date=="2007-02-02")

df$Date = as.POSIXct(paste(df$Date, df$Time), 
                     format="%Y-%m-%d %H:%M:%S")
df$Time = NULL

toNum = function(vector){
      vector = as.numeric(as.character(vector))
      return(vector)
}

df$Global_active_power = toNum(df$Global_active_power)
df$Global_reactive_power = toNum(df$Global_reactive_power)
df$Voltage = toNum(df$Voltage)
df$Global_intensity = toNum(df$Global_intensity)
df$Sub_metering_1 = toNum(df$Sub_metering_1)
df$Sub_metering_2 = toNum(df$Sub_metering_2)
df$Sub_metering_3 = toNum(df$Sub_metering_3)


#################################################################
################## Now the plot##################################
#################################################################

png("plot2.png", width=480, height=480)
plot(df$Date, df$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
