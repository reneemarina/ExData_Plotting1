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
##Plot 4: Create Plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

## Save file and close device
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()