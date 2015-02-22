#Load Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Filter by Coal Combustion-related Sources
unique(SCC$EI.Sector)
coal<-grep("coal",as.character(SCC$EI.Sector),ignore.case=TRUE,value=TRUE)
comb<-grep("comb",coal,ignore.case=TRUE,value=TRUE)
scc_coal<-SCC[SCC$EI.Sector %in% comb,]
sub_coal2<-NEI[NEI$SCC %in% scc_coal[,1],]

#Calculate Total Emissions from Coal Combustion-related Sources
SumCoalEm<-tapply(sub_coal2$Emissions,sub_coal2$year,sum,simplify=TRUE)
SumCoalEm<-SumCoalEm/1000
SumCoalEm<-matrix(SumCoalEm,nrow=4,ncol=1)
Year<-c("1999","2002","2005","2008")
Year<-format(Year, format="%Y")
SumCoalEm<-cbind(Year,SumCoalEm)
colnames(SumCoalEm)=c("Year","Sum")

#Plot
png(file="plot4.png",width=480,height=480)
plot(SumCoalEm,main="Emissions from Coal Combustion-related Sources",type="b",lty=1,lwd=1,pch=19,ylab="Total Emissions (Thousand)")
dev.off()
#Total emissions from Coal Combustion-related Sources have decrease from 1999 to 2008 on whole, but there is a slight increase in 2005.
