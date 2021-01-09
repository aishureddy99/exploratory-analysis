dest <- "household_power_consumption.zip"

#Download File, Unzip file and create table
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",dest)
power <- read.table(unz(dest, "household_power_consumption.txt"),skip=1,sep=";")
unlink(dest)

#Read Table, rename columns and Filter on the 2 days

names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

#Plot 1

head(subpower)
#calling the basic plot function

#clearing plot space
while (!is.null(dev.list())) dev.off()

# Create PNG
png("plot1.png")

hist(as.numeric(as.character(subpower$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# annotating graph
title(main="Global Active Power")

#close plot
dev.off()
