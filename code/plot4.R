library(tidyverse)
library(lubridate)

data <- read.csv("household_power_consumption.txt",
                 header = TRUE,
                 sep = ";",
                 stringsAsFactors = FALSE)
new_data <- data %>% 
  mutate(Time_date = as.POSIXct(ymd(as.Date(Date, format = "%d/%m/%Y")) + hms(Time)),
         Global_active_power = as.numeric(Global_active_power),
         Global_reactive_power = as.numeric(Global_reactive_power),
         Voltage = as.numeric(Voltage),
         Global_intensity = as.numeric(Global_intensity),
         Sub_metering_1 = as.numeric(Sub_metering_1),
         Sub_metering_2 = as.numeric(Sub_metering_2),
         Sub_metering_3 = as.numeric(Sub_metering_3)) %>%   
  filter(between(Time_date, 
                 as.POSIXct("2007-02-01 00:00:00", tz = "GMT"), 
                 as.POSIXct("2007-02-02 23:59:59", tz = "GMT")))

png("EDA course/ExData_Plotting1-master/figure/plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))
# plot 1
plot(new_data$Time_date,
     new_data$Global_active_power,
     type = "l",
     main = "",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
# plot 2
plot(new_data$Time_date,
     new_data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
# plot 3
plot(new_data$Time_date,
     new_data$Sub_metering_1,
     type = "l",
     main = "",
     xlab = "",
     ylab = "Energy sub metering")
lines(new_data$Time_date,
      new_data$Sub_metering_2,
      col = "red")
lines(new_data$Time_date,
      new_data$Sub_metering_3,
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), 
       lty = 1,
       bty = "n")
# plot 4
plot(new_data$Time_date,
     new_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
