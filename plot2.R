## It's assumed that data have been downloaded from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip,
## and it has been unzipped the file-"household_power_consumption.txt" into the subdirect-
## "data" of the working directory.

plot2 <- function() {
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
    
    ## Generate plot2.png file as required.
    png(filename="plot2.png", width=480, height=480)
    
    plot(subpowerCon$Date_time, subpowerCon$Global_active_power, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="") 
    
    dev.off()
}