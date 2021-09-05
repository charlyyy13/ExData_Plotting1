#load packages
library(readr)
library(tidyverse)
library(lubridate)
library(ggplot2)
#load dataset houshold power consumption (hcp)
household_power_consumption <- read_delim("~/Documents/Private/R/household_power_consumption.txt", 
                                          +     ";", escape_double = FALSE, trim_ws = TRUE)
hpc <- household_power_consumption

##Clean data
#convert Date - as.Date
head(hpc$Date) 
d <- as.factor(c(hpc$Date)) #convert to factor
head(d)
date <- as.Date(d, format = "%d/%m/%Y") #conver to date in right format
head(date)
#apply to dataset
hpc$Date <- as.factor(c(hpc$Date))
hpc$Date <- as.Date(d, format = "%d/%m/%Y") 
head(hpc$Date)

#select by date - from 01/02/2007 and 02/02/2007
s <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]
summary(s)
#apply to dataset
hpc <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]

#date and time combined
dt<- as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S")
str(dt)
datetime <- dt

##Plot4
#graphic device for mac
quartz()
#open png file
#png("plot4.png", width = 480, height = 480)
#create plots
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
#1 - plot top left
plot2 <- with(hpc,plot(datetime, Global_active_power, type="l", pch=5))
plot2

#2- plot top right
plotx <- with(hpc,plot(datetime, Voltage, type="l", pch=5))
plotx

#3 - plot bottom left
plot3 <- with(hpc,plot(datetime, Sub_metering_3, type="l",col="blue", ylab="",  ylim = c(0, 40), 
))
par(new=TRUE)
with(hpc, plot(datetime, Sub_metering_1, type="l",col="black", ylab ="", ylim = c(0, 40)))
par(new=TRUE)
with(hpc, plot(datetime, Sub_metering_2, type="l",col="red", ylab="Energy sub metering", ylim = c(0, 40))) 
#add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lty=1:2, cex=0.8)

#4 - plot bottom right
ploty <- with(hpc,plot(datetime, Global_reactive_power, type="l", pch=5))
ploty

#close the file
dev.off()

