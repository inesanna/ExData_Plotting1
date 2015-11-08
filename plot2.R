#Plot 2
# get data if it's not already there
if (!file.exists(paste(getwd(),"/Data/household_power_consumption.txt",sep=""))){
    dir.create(paste(getwd(),"/Data",sep=""))
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = paste(getwd(),"/Data/data.zip","",sep="") , method = "curl")
    unzip(paste(getwd(),"/Data/","data.zip",sep=""),exdir=paste("Data/."))
}
fl=paste("Data/household_power_consumption.txt")
F<-read.table(fl,header = TRUE,sep=";",nrows=1)
# I didn't want to load the whole file so I used grep to find the line where the needed date occurs.
# since there is 1 measurement per minute, 2 days will take up 2880 rows. 
# I add one more row to get the weekeday name for the next day as well
G<-read.table(fl,header = FALSE,sep=";",skip = 66637,nrows = 2881)
names(G)<-colnames(F)

#Create axis tick names:
G$Weekdays<-weekdays(as.Date(G$Date,"%d/%m/%Y"),abbreviate = TRUE)
N<-unique(G$Weekdays)
NL<-length(N)
t<-as.numeric()
for (i in 1:NL){
    t[i]<-min(grep(N[i],G$Weekdays))
}

png("plot2.png", width = 480, height = 480)
plot(G$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)", xaxt="n")
axis(1, at=t, labels=N)
dev.off()
