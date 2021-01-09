dest <- "household_power_consumption.zip"

#Download File, Unzip file and create table
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",dest)
power <- read.table(unz(dest, "household_power_consumption.txt"),skip=1,sep=";")
unlink(dest)

#Read Table, rename columns and Filter on the 2 days

names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

#Plot 2

head(subpower)
#calling the basic plot function

#clearing plot space
while (!is.null(dev.list())) dev.off()

# Create PNG
png("plot3.png",width=480, height=480)

# Transforming the Date and Time from characters to Date 

subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")
subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower[1441:2880,"Time"] <- format(subpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# calling the basic plot functions
plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# annotating graph
title(main="Energy sub-metering")

#close plot
dev.off()
