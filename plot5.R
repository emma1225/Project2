#Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filter by Motor Vehicle Sources
veh<-grep("veh",as.character(SCC$Short.Name),ignore.case = TRUE,value=TRUE)
mot<-grep("mobile",as.character(SCC$EI.Sector),ignore.case=TRUE,value=TRUE)
sccsub<-SCC[SCC$Short.Name %in% veh,]
sccsubset<-sccsub[sccsub$EI.Sector %in% mot,]
sub_motor<-NEI[NEI$SCC %in% sccsubset[,1],]

#Calculate Total Emissions from Motor Vehicle Sources
sub_motor1<-subset(sub_motor,fips == "24510")
SumMotEm<-tapply(sub_motor1$Emissions,sub_motor1$year,sum,simplify=TRUE)
SumMotEm<-matrix(SumMotEm,nrow=4,ncol=1)
Year<-c("1999","2002","2005","2008")
SumMotEm<-cbind(Year,SumMotEm)
colnames(SumMotEm)=c("Year","Sum")

#Plot
png(file="plot5.png",width=480,height=480)
plot(SumMotEm,main="Emissions from Motor Vehicle Sources",type="b",lty=1,lwd=1,pch=19,ylab="Total Emissions (Thousand)")
dev.off()
#Total emissions from Motor Vehicle Sources in Baltimore City have decrease from 1999 to 2008.

