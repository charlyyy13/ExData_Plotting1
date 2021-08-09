#load dataset houshold power consumption (hcp)
library(readr)
household_power_consumption <- read_delim("~/Documents/Private/R/household_power_consumption.txt", 
                                          +     ";", escape_double = FALSE, trim_ws = TRUE)
hpc <- household_power_consumption

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
dt1 <- strftime(dt, format= "%Y-%m-%d %H:%M:%S")
dt1
str(dt1)
dt2 <- as.Date(dt, format= "%X")
str(dt2)
### attempt to change time to right format
head(hpc$Time) 
tt <- as.factor(c(hpc$Time)) #convert to factor
head(tt)
time <- strftime(tt, format = "%H:%M:%S") #conver to date in right format
head(time)



#Plot 2 - Global Active Power on Thu Fri Sat including time
df <- hpc$Global_active_power

#first convert to date and secondly as weekdays
weekdays <- weekdays(dt)
summary(weekdays)
#ordering days
weekdays <- factor(weekdays,levels = c("Thursday", "Friday", "Saturday"))
head(weekdays)
summary(weekdays)

library(tidyverse)
library(lubridate)
library(ggplot2)
#Plot2
p <- ggplot(hpc, aes(x=dt, y=hpc$Global_active_power)) +
  geom_line() + 
  xlab("") +
  ylab("Global Active Power (kilowatts)")
p
p + scale_x_date(dt2)
p
str(dt)
str("dt1")

#Plot2
png("plot2.png", width = 480, height = 480)
plot2 <- with(hpc,plot(dt,Global_active_power))
dev.off()