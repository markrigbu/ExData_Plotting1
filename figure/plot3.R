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
# containing a plot of Global_active_power against (Date and time) 
# save to working directory

png("plot3.png", 480, 480)

plot(df_filtered_datetime$DateTime, df_filtered_datetime$Sub_metering_1, 
     type = "l", xlab = "", ylab = "Energy sub metering")
points(df_filtered_datetime$DateTime, df_filtered_datetime$Sub_metering_2, 
       type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(df_filtered_datetime$DateTime, df_filtered_datetime$Sub_metering_3, 
       type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       #cex = 0.5,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

