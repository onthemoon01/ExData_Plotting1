
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

## draw histogram for Global active power and make it a png
png("Plot1.png")
hist(dat2$Global_active_power, col="red", xlab=" Global Active Power (kilowatts)",main="Global Active Power")
dev.off()




