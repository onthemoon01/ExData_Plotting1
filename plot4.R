
## Download, unzip and load data frame

temp<-tempfile()
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
url2<-download.file(url,temp, method='curl' )
data<-read.csv2(unz(temp,"household_power_consumption.txt" ), stringsAsFactors=F)
unlink(temp)

## Subset data between feb 1 2007 and feb 2 2007
data[,1]<-as.Date(data[,1], "%d/%m/%Y")
dat1<-subset(data, Date>="2007-02-01")
dat2<-subset(dat1, Date <"2007-02-03")
dat2[,c(3:9)]<-sapply(dat2[,c(3:9)],as.numeric)

## Create a column that concatenate date and time
dat2$dateTime<- as.POSIXlt(paste(dat2$Date, dat2$Time))

## draw 4 plots and make it a png

png("Plot4.png")
par(mfrow=c(2,2))
plot(dat2$dateTime, dat2$Global_active_power, type='l', ylab="Global Active Power (kilowatts)", xlab="")
plot(dat2$dateTime,dat2$Voltage, type='l', xlab="datetime", ylab="Voltage")
plot(dat2$dateTime,dat2$Sub_metering_1,ylab="Energy sub metering",xlab="",lwd=1,type="l")
lines(dat2$dateTime,dat2$Sub_metering_2,col="red")
lines(dat2$dateTime,dat2$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1, col=c("black", "red", "blue"))
plot(dat2$dateTime,dat2$Global_reactive_power, type='l', xlab='datetime', ylab= 'Global_reactive_power')
dev.off()