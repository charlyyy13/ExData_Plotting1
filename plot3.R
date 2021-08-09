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


######
#Plot 3 - Energy sub metering 
#Sub_metering_1 black 
#Sub_metering_2 red
#Sub_metering_3 blue 
library(ggplot2)
#open png file
png("plot3.png", width = 480, height = 480)
#create plot3
plot3 <- ggplot(hpc, aes(x=dt)) + 
  geom_line(aes(y=Sub_metering_1, color="Sub_metering_1")) + 
  geom_line(aes(y=Sub_metering_2, color="Sub_metering_2")) + 
  geom_line(aes(y=Sub_metering_3, color="Sub_metering_3")) +
  xlab(" ")+
  ylab("Energy sub metering") +
  scale_colour_manual(values = c("black", "red", "blue"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
plot3
#close the file
dev.off()