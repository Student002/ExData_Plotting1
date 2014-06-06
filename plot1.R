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

#------------------------ PLOT 1 ---------------------------
hist(x = data$Global_active_power,
      main = "Global Active Power",
      col = "red",
      xlab = "Global Active Power (kilowatts)")

dev.copy(png, 'plot1.png') # Export to file
dev.off()

