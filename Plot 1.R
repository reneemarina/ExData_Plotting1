##1. Load & clean data

## Read Data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date ##or data$Date <-strptime(data$Date,"%d/%m/%Y")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Filter data ##or subdata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation ##or subdata <-na.omit(subdata)
data <- data[complete.cases(data),]

## Combine Date and Time column & Name the vector
dateTime <- paste(data$Date, data$Time)
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
data <- data[ ,!(names(data) %in% c("Date","Time"))]

## Add DateTime column
data <- cbind(dateTime, data)

## Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

##2. Plot data
##Plot 1: Create histogram
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
