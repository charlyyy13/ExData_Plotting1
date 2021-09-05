#load packages
library(readr)
library(tidyverse)
library(lubridate)
library(ggplot2)
#load dataset houshold power consumption (hcp)
hpc<-read.table("household_power_consumption.txt",sep=";",header=T)

##Clean data
#convert Date - as.Date
head(hpc$Date) 
d <- as.factor(c(hpc$Date)) #convert to factor
head(d)
date <- as.Date(d, format = "%d/%m/%Y") #convert to date in right format
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
#convert to weekdays
weekdays <- weekdays(dt)
#remove unnecessary variables
rm(s, d, date)


##Plot 3 - Energy sub metering 
#Sub_metering_1 black 
#Sub_metering_2 red
#Sub_metering_3 blue 
library(ggplot2)
#open png file
png("plot3.png", width = 480, height = 480)
#create plot3
plot3 <- with(hpc,plot(datetime, Sub_metering_3, type="l",col="blue", ylab="",  ylim = c(0, 40), 
))
par(new=TRUE)
with(hpc, plot(datetime, Sub_metering_1, type="l",col="black", ylab ="", ylim = c(0, 40)))
par(new=TRUE)
with(hpc, plot(datetime, Sub_metering_2, type="l",col="red", ylab="Energy sub metering", ylim = c(0, 40))) 
#add legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lty=1:2, cex=0.8)
#close the file
dev.off()
