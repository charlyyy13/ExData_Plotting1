#load dataset houshold power consumption (hcp)
library(readr)
household_power_consumption <- read_delim("~/Documents/Private/R/household_power_consumption.txt", 
                                               ";", escape_double = FALSE, trim_ws = TRUE)

hpc <- household_power_consumption

#Plot1
#Clean data
#Convert Date - as.Date and apply to dataset
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

#Select relevant time frame - from 01/02/2007 and 02/02/2007
s <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]
summary(s)
#apply to dataset
hpc <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]
#remove unneeded variables
rm(s, d, date)

#Plot 1 - Global Active Power 
head(hpc$Global_active_power)

plot1 <- hist(hpc$Global_active_power,
              breaks= 20 ,
              main="Global Active Power", 
              xlab="Gloal Active Power (kilowatts)", 
              col="red")
plot1
