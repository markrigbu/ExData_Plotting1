#dplyr is required for the filter and mutate functions
library(dplyr)

# Read txt file from the working directory into a data frame

df<- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", 
               quote = "\"", stringsAsFactors=FALSE)

# create a new data frame filtered for rows containing the dates 1/2/2007 and 2/2/2007

df_filtered <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")

# Add a new column to the df with the mutate function containing date and time variables combined 
# specify the column format with the strptime function

df_filtered_datetime <- mutate(df_filtered, DateTime = as.POSIXct(strptime(
        paste(df_filtered$Date, df_filtered$Time), "%d/%m/%Y %H:%M:%S")))

# create PNG file with a width of 480 pixels and a height of 480 pixels
# containing 4 plots that are arranged into a 2 by 2 grid using mfrow
# save to working directory

png("plot4.png", 480, 480)

par(mfrow = c(2, 2))

# plot 1 (NW)
plot(df_filtered_datetime$DateTime, df_filtered_datetime$Global_active_power, 
     #cex.axis=0.5, 
     type = "l", ylab = "Global Active Power", xlab = "")

# plot 2 (NE)
plot(df_filtered_datetime$DateTime, df_filtered_datetime$Voltage, 
     #cex.lab=0.5, cex.axis=0.5, 
     type = "l", ylab = "Voltage", xlab = "datetime")

# plot 3 (SW)
plot(df_filtered_datetime$DateTime, df_filtered_datetime$Sub_metering_1, 
     #cex.lab=0.5, cex.axis=0.5, 
     type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
points(df_filtered_datetime$DateTime, df_filtered_datetime$Sub_metering_2, 
       #cex.lab=0.5, cex.axis=0.5, 
       type = "l", xlab = "", ylab = "Sub_metering_2", col = "red")
points(df_filtered_datetime$DateTime, df_filtered_datetime$Sub_metering_3, 
       #cex.lab=0.5, cex.axis=0.5, 
       type = "l", xlab = "", ylab = "Sub_metering_3", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       #cex = 0.5, 
       border = "white",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", )

# plot 4 (SE)
plot(df_filtered_datetime$DateTime, df_filtered_datetime$Global_reactive_power, 
     #cex.lab=0.5, cex.axis=0.5, 
     type = "l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0, 0.5))

dev.off()
# Running the dev.off function twice closes the plotting windows stipulated by par().
dev.off()
