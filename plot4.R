## It's assumed that data have been downloaded from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip,
## and it has been unzipped the file-"household_power_consumption.txt" into the subdirect-
## "data" of the working directory.

plot4 <- function() {
    ## My Windows OS is Chinese version, So set local to English just in case.
    
    Sys.setlocale("LC_TIME", "English")
    
    library(lubridate)
    powerCon <- read.table("./data/household_power_consumption.txt", header=T, 
                           sep=';', stringsAsFactors = FALSE, na.strings="?")
    
    ## Retrieve data which need to be plotted
    subpowerCon <- powerCon[powerCon$Date == "1/2/2007" | powerCon$Date == "2/2/2007",]
    
    rm(powerCon) ## remove all data to save memory
    
    ## Combine date and time to a new column-Date_time
    subpowerCon$Date_time <- strptime(paste(subpowerCon$Date, subpowerCon$Time), 
                                      "%d/%m/%Y %H:%M:%S")
    
    ## Generate plot4.png file as required.
    png(filename="plot4.png", width=480, height=480)

    par(mfrow=c(2,2))
    
    with(subpowerCon, {
        plot(Date_time, Global_active_power, type="l", 
             ylab="Global Active Power", xlab="")
        
        plot(Date_time, Voltage, type="l",  
             ylab="Voltage", xlab="datetime") 
        
        plot(Date_time, Sub_metering_1, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Date_time, Sub_metering_2, col='Red') 
        lines(Date_time, Sub_metering_3, col='Blue') 
        legend("topright", col=c("black", "red", "blue"), lwd = 2,
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(Date_time, Global_reactive_power, type="l", xlab="datetime")
    })
    
    dev.off()
}