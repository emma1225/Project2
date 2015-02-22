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
sub_motor2<-subset(sub_motor,fips == "06037")
#Batimore City
SumMotEm1<-tapply(sub_motor1$Emissions,sub_motor1$year,sum,simplify=TRUE)
Year<-c("1999","2002","2005","2008")
Location1<-"Batimore City"
SumMotEm1<-as.numeric(SumMotEm1)
SumMotEm1<-data.frame(Year,SumMotEm1,Location1)
colnames(SumMotEm1)=c("Year","Sum","Location")
#Los Angeles County
SumMotEm2<-tapply(sub_motor2$Emissions,sub_motor2$year,sum,simplify=TRUE)
SumMotEm2<-as.numeric(SumMotEm2)
Location2<-"Los Angeles County"
SumMotEm2<-data.frame(Year,SumMotEm2,Location2)
colnames(SumMotEm2)=c("Year","Sum","Location")
SumMotEm<-rbind(SumMotEm1,SumMotEm2)

#Plot
library(ggplot2)
png(file="plot6.png",width=960,height=480)
qplot(Year,Sum,data=SumMotEm,facets=.~Location,geom = c("line", "point"),)
dev.off()
# Los Angeles County has seen greater changes over time in motor vehicle emissions.

