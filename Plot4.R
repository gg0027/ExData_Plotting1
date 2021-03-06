# Download, unzip and read the raw data 
setwd(dir = "~/ExData_Plotting1/")
download.file(url = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "raw")
unzip(zipfile = "raw")
DataAll <- read.csv("~/ExData/household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

# Extract data from 2007-02-01 and 2007-02-02. Note: you must have dply and lubridate packages for the codes to work:)

library(dplyr)
library(lubridate)
data<- DataAll %>% 
  filter (Date == "2/2/2007" | Date == "1/2/2007") %>% 
  mutate(t=paste(Date,Time))
data$t <- dmy_hms(data$t)
data[3:8]<- apply(data[3:8], 2, as.numeric) 

# Plot 4
png(filename = "plot4.png")
par(mfrow=c(2,2))

plot(x = data$t,y=data[,3],type = 'l', ylab="Global Active Power (kilowatts)",xlab="")

plot(x = data$t,y=data[,5],type = 'l', ylab="Voltage",xlab="datetime")

plot(x=data$t, y=data[,7],"l",xlab="",ylab="Energy sub metering")
lines(x=data$t, y=data[,8],"l",col="red")
lines(x=data$t, y=data[,9],"l",col="blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1),col = c("black","red","blue"),cex=0.8,bty="n" )

plot(x = data$t, y=data[,4],type = 'l', ylab="Global Reactive Power",xlab="datetime")

dev.off()