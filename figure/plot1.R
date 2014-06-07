#dplyr is required for the filter function
library(dplyr)

# Read txt file from the working directory into a data frame

df<- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"", stringsAsFactors=FALSE)

# Convert column 3 (Global_active_power) to numeric values

df[, 3]  <- as.numeric(df[, 3])

# create a new data frame filtered for rows containing the dates 1/2/2007 and 2/2/2007

df_filtered <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")

# create PNG file with a width of 480 pixels and a height of 480 pixels
# containing a histogram of Global_active_power and save to the working directory

png("plot1.png", 480, 480)

hist(df_filtered$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     col="red", main = "Global Active Power",
     ylim = c(0, 1200), xlim = c(0, 6), xaxp = c(0, 6, 3))

dev.off()
