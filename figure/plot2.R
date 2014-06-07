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
# save to the working directory

png("plot2.png", 480, 480)

plot(df_filtered_datetime$DateTime, df_filtered_datetime$Global_active_power, 
     type = "l",  xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()

