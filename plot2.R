# Source File, download file and read file
href<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
DataFile<- download.file(href, destfile = "power_data.zip", method = "curl")
unzip(zipfile = "power_data.zip")
power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

# Set date format
power_data[,"Date"] <- as.Date(power_data[,"Date"],format = "%d/%m/%Y")

# subset data by date
date_subset<-subset(power_data,Date == "2007-02-01" | Date == "2007-02-02")

# Set Date-time format
Dtime_data<-strptime(paste(date_subset$Date,date_subset$Time,sep = " "), "%Y-%m-%d %H:%M:%S" )

# Convert string to numeric format
globalActivePower<-as.numeric(date_subset[,"Global_active_power"])

# Make and save plot
png("plot2.png",width = 480, height = 480)
plot(Dtime_data,globalActivePower,type = "l",xlab = " ",ylab = "Global Active Power (kilowatts)")
dev.off()
