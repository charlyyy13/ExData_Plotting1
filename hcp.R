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

#Select by date - from 01/02/2007 and 02/02/2007
s <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]
summary(s)
#apply to dataset
hpc <- hpc[hpc$Date >= "2007-02-01" & hpc$Date <= "2007-02-02",]

#conver Time to time
head(hpc$Time)
t <- as.factor(c(hpc$Time))
head(t)
t2 <- strptime(hpc$Time,format = "%X")
head(t2)
#x<- mutate(X3 = ymd_hm(paste(household_power_consumption$Date, household_power_consumption$Time)))

##also includes the current date - exclude date

#Plot 1 - Global Active Power 
head(hpc$Global_active_power)
quantile(hpc$Global_active_power, na.rm = TRUE)
summary((hpc$Global_active_power))
df <- hpc$Global_active_power

hist(newdata$Global_active_power)
#xaxis 0.5steps
#yaxis rearange to 0:1200 

plot1 <- hist(hpc$Global_active_power,
     breaks= 20 ,
     main="Global Active Power", 
     xlab="Gloal Active Power (kilowatts)", 
     col="red")
plot1

#####
#Plot 2 - Global Active Power on Thu Fri Sat including time
head(hpc$Global_active_power)
#first convert to date and secondly as weekdays
weekdays <- weekdays(hpc$Date)
weekdays
summary(weekdays)
head(weekdays)
?subset
#wd<- subset(weekdays, select = "Thursday")
#wd <- filter(weekdays, weekdays = "Thursday" &  weekdays= "Friday"&  weekdays = "Saturday")
#wd <- filter(weekdays(weekdays, "Thursday"))
#filter(weekdays)

#ordering days
weekdays <- factor(weekdays,levels = c("Thursday", "Friday", "Saturday"))
head(weekdays)
summary(weekdays)

library(ggplot2)
plot2 <- ggplot(data = hpc, aes(x = weekdays, y = df))+ 
                  geom_line()+
                  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
                  ylab("Global Active Power (kilowatts)")
plot2

#Plot 3 - Energy sub metering 
#Sub_metering_1 black 
#Sub_metering_2 red
#Sub_metering_3 blue 
plot3 <- ggplot(hpc, aes(x=dt)) + 
  geom_line(aes(y=Sub_metering_1, color="Sub_metering_1")) + 
  geom_line(aes(y=Sub_metering_2, color="Sub_metering_2")) + 
  geom_line(aes(y=Sub_metering_3, color="Sub_metering_3")) +
  ylab("Global Active Power (kilowatts)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
plot3
