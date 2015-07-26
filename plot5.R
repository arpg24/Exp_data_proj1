##Libraries
library(ggplot2)
library(plyr)

##Download and unzip the files
if(!file.exists("./data")){dir.create("./data")}
file<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file,destfile="./data/Data_proj2.zip",method="auto")

unzip(zipfile="./data/Data_proj2.zip",exdir="./data")

rm(file)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

data<-transform(NEI,type=factor(type),year=factor(year))
data<-data[data$fips=="24510",]
vehicles<-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicles)<-"SCC"
data<-merge(vehicles,data,by="SCC")

ag_data <- with(data, aggregate(Emissions, by = list(year), sum))
colnames(ag_data)<-c("year","Emissions")

png("plot5.png")
ggplot(data=ag_data, aes(x=year, y=Emissions)) + geom_point() + xlab("Year") + ylab("Emissions (tons)") + ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore")
dev.off()
