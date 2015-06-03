#####################################################################
## This contains code to generate plot1.png
## author: Andy Shiue
#####################################################################

## First step is to load the data, make sure the data file is at the
## same level as the R script.

df = data.frame("Date"=character(), "Time"=character(), "Global_active_power"=numeric(),
		"Global_reactive_power"=numeric(), "Voltage"=numeric(),
		"Global_intensity"=numeric(), "Sub_metering_1"=numeric(),
		"Sub_metering_2"=numeric(), "Sub_metering_3"=numeric(),
		stringsAsFactors = FALSE)

fileCon <- file("household_power_consumption.txt", open = "r")

## read the header first before starting to fill the dataframe
fileHeader <- readLines(fileCon, n = 1)
fileHeader <- strsplit(fileHeader, ";")[[1]]

i <- 0
while(length( (l <- readLines(fileCon, n = 1) ) > 0 )){

	l <- strsplit(l, ";")[[1]]
	l <- data.frame("Date"=l[1], "Time"=l[2], "Global_active_power"=as.numeric(l[3]),
                "Global_reactive_power"=as.numeric(l[4]), "Voltage"=as.numeric(l[5]),
                "Global_intensity"=as.numeric(l[6]), "Sub_metering_1"=as.numeric(l[7]),
                "Sub_metering_2"=as.numeric(l[8]), "Sub_metering_3"=as.numeric(l[9]),
                stringsAsFactors = FALSE)

	if (l$Date=="1/2/2007" || l$Date=="2/2/2007") {
		df <- rbind(df, l)
	}
}

## Close file connection
close(fileCon)

## Create plot on file device
png("plot1.png", width=480, height=480, units="px")
hist(df$Global_active_power, main="Global Active Power",
	xlab="Global Active Power (kilowatts)",
	ylab="Frequency", col="red")
dev.off()
