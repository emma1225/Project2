#Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Calculate Total Emissions from four types of sources of Every Year  
NEIBAL<-subset(NEI,fips == "24510")
SumType<-tapply(NEIBAL$Emissions,list(NEIBAL$year,NEIBAL$type),sum,simplify=TRUE)
SumType<-as.numeric(SumType)
Year<-c("1999","2002","2005","2008")
Type<-c("Non-Road","Non-Road","Non-Road","Non-Road",
"NonPoint","NonPoint","NonPoint","NonPoint",
"On-Road","On-Road","On-Road","On-Road",
"Point","Point","Point","Point")
SumType2<-data.frame(Year,Type,SumType)
colnames(SumType2)=c("Year","Type","Sum")
#ggplot
library(ggplot2)
png(file="plot3.png",width=960,height=480)
qplot(Year,Sum,data=SumType2,facets=.~Type)
dev.off()
#Three sources(Non-Road,NonPoint,On-Road) have seen decreases in emissions for Baltimore City from 1999 to 2008.
#One source(Point) have seen increases in emissions for Baltimore City from 1999 to 2008.
