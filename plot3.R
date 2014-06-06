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
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

#------------------------ PLOT 3 ---------------------------
## Writing to file scales the text better that dev.copy(png, 'plot3.png') 
png(filename = 'plot3.png', width = 480, height = 480) # Export to file

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
       lty = 1)

dev.off()
