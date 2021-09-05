#load packages
library(readr)
library(tidyverse)
library(lubridate)
library(ggplot2)
#load dataset houshold power consumption (hcp)
household_power_consumption <- read_delim("~/Documents/Private/R/household_power_consumption.txt", 
                                               ";", escape_double = FALSE, trim_ws = TRUE)

hpc <- household_power_consumption

##Clean data
#Convert Date - as.Date and apply to dataset
head(hpc$Date) 
d <- as.factor(c(hpc$Date)) #convert to factor
head(d)
date <- as.Date(d, format = "%d/%m/%Y") #convert to date with correct format
head(date)
#apply to dataset
hpc$Date <- as.factor(c(hpc$Date))
hpc$Date <- as.Date(d, format = "%d/%m/%Y") 
head(hpc$Date)

#Select relevant time frame - from 01/02/2007 and 02/02/2007
s <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]
summary(s)
#apply to dataset
hpc <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]
#remove unnecessary variables
rm(s, d, date)

##Plot 1 - Global Active Power 
head(hpc$Global_active_power)
#open png file
png("plot1.png", width = 480, height = 480)
#create plot
plot1 <- hist(hpc$Global_active_power,
              breaks= 20 ,
              main="Global Active Power", 
              xlab="Gloal Active Power (kilowatts)", 
              col="red")
#close the file
dev.off()
