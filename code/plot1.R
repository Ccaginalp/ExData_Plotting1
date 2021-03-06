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

png("EDA course/ExData_Plotting1-master/figure/plot1.png", width = 480, height = 480)
hist(new_data$Global_active_power,
     breaks = 16,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0, 1200))
dev.off()
