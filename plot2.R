#Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Calculate Total Emissions of Every Year in Baltimore City
NEIBAL<-subset(NEI,fips == "24510")
SumEmBAL<-tapply(NEIBAL$Emissions,NEIBAL$year,sum,simplify=TRUE)
SumEmBAL<-matrix(SumEmBAL,nrow=4,ncol=1)
Year<-c("1999","2002","2005","2008")
Year<-format(Year, format="%Y")
SumEmBAL<-cbind(Year,SumEmBAL)
colnames(SumEmBAL)=c("Year","Sum")

#Plot
png(file="plot2.png",width=480,height=480)
plot(SumEmBAL,main="Total Emissions from PM2.5 in Baltimore City",type="b",lty=1,lwd=1,ylim=c(1000,4000),pch=19,ylab="Total Emissions")
dev.off()
#Total emissions from PM2.5 have decreased in Baltimore City from 1999 to 2008, but there is an increase in 2005.