# Source File, download file and read file
href<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
DataFile<- download.file(href, destfile = "power_data.zip", method = "curl")
unzip(zipfile = "power_data.zip")

# Read data
power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Set date format
power_data[,"Date"] <- as.Date(power_data[,"Date"],format = "%d/%m/%Y")

# subset data by date
date_subset<-subset(power_data,Date == "2007-02-01" | Date == "2007-02-02")

globalActivePower <- as.numeric(date_subset$Global_active_power)
Dtime_data <- strptime(paste(date_subset$Date,date_subset$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )
sub_met1 <- as.numeric(date_subset[,"Sub_metering_1"])
sub_met2 <- as.numeric(date_subset[,"Sub_metering_2"])
sub_met3 <- as.numeric(date_subset[,"Sub_metering_3"])
globalReactivePower <- as.numeric(date_subset[,"Global_reactive_power"])
Volt <- as.numeric(date_subset[,"Voltage"])

png("plot4.png",width = 480, height = 480)
par(mfrow = c(2,2))

# 1st Plot
plot(Dtime_data,globalActivePower,type = "l",xlab = " ",ylab = "Global Active Power")

# 2nd Plot
plot(Dtime_data,Volt,type = "l",xlab = "datetime",ylab = "Voltage")

# 3rd Plot
plot(Dtime_data,sub_met1,col = "black",type = "l", xlab = " ", ylab = "Energy sub metering")
lines(Dtime_data, sub_met2, col = "red")
lines(Dtime_data, sub_met3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"))

# 4th Plot
plot(Dtime_data,globalReactivePower,type = "l",xlab = "datetime",ylab = "Global_reactive_power")

dev.off()
