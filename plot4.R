setwd('./Project1')
fdata = read.csv('household_power_consumption.txt',
         header=TRUE,
        sep = ';')

# Get data for 1 & 2 FEB 2007
data <- subset(fdata, Date == '1/2/2007' | Date == '2/2/2007') 
data <- data[complete.cases(data),]

# Add the datetime column
data$datetime <- paste(data$Date,data$Time)
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")

# Convert text meter data to numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

#------------------------ PLOT 4 ---------------------------
## Writing to file scales the text better that dev.copy(png, 'plot4.png') 
png(filename = 'plot4.png', width = 480, height = 480) # Export to file
split.screen(c(2, 2), erase = TRUE) # split screen in 4
screen(1) # Add "Global Active Power"
    plot(x = data$datetime,
         y = data$Global_active_power,
         type = "l",
         xlab = "",
         ylab = "Global Active Power" )

screen(2) # Add Plot "Voltage"
    plot(x = data$datetime,
         y = data$Voltage,
         type = "l",
         xlab = "datetime",
         ylab = "Voltage" )

screen(3) # Add Plot "Energy sub metering"
    plot(x = data$datetime,
         y = data$Sub_metering_1,
         type = "l",
         col = "black",
         xlab = "",
         ylab = "Energy sub metering" )
    lines(x = data$datetime,
          y = data$Sub_metering_2,
          type = "l",
          col = "red")
    lines(x = data$datetime,
          y = data$Sub_metering_3,
          type = "l",
          col = "blue")
    legend("topright",
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           col = c("black","red","blue"),
           lty = 1,
           box.lty = 0,
           #box.col = "white",
           pt.cex = 1,
           cex = 0.75)

screen(4) # Add "Global ReActive Power"
    plot(x = data$datetime,
         y = data$Global_reactive_power,
         type = "l",
         xlab = "datetime",
         ylab = "Global_reactive_power" )

close.screen(all = TRUE)    # exit split-screen mode
dev.off()

