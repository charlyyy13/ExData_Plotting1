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
#remove unnecessary variables
rm(s, d, date)

#date and time combined
dt<- as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S")
str(dt)
dt1 <- strftime(dt, format= "%Y-%m-%d %H:%M:%S")
dt1
str(dt1)
dt2 <- as.Date(dt, format= "%X")
str(dt2)
### attempt to change time to right format
head(hpc$Time) 
tt <- as.factor(c(hpc$Time)) #convert to factor
head(tt)
time <- strftime(tt, format = "%H:%M:%S") #convert to date in right format
head(time)

#convert to weekdays
weekdays <- weekdays(dt)
summary(weekdays)
#ordering days
weekdays <- factor(weekdays,levels = c("Thursday", "Friday", "Saturday"))
head(weekdays)
summary(weekdays)


##Plot2
#open png file
png("plot2.png", width = 480, height = 480)
#create plot
plot2 <- with(hpc,plot(dt, Global_active_power,type="l"))
plot2 
#close the file
dev.off()
