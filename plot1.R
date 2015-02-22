#Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Calculate Total Emissions of Every Year
SumEmi<-tapply(NEI$Emissions,NEI$year,sum,simplify=TRUE)
SumEmi<-matrix(SumEmi,nrow=4,ncol=1)
SumEmi<-SumEmi/1000
Year<-c("1999","2002","2005","2008")
Year<-format(Year, format="%Y")
SumEmi<-cbind(Year,SumEmi)
colnames(SumEmi)=c("Year","Sum")
#Plot
png(file="plot1.png",width=480,height=480)
plot(SumEmi,main="Total Emissions from PM2.5",type="b",lty=1,lwd=1,ylim=c(3000,8000),pch=19,ylab="Total Emissions(Thousand)")
dev.off()
#Total emissions from PM2.5 have decreased in the United States from 1999 to 2008.