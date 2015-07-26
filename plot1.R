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

NEI$year<-as.factor(NEI$year)
emissions<-aggregate(Emissions ~ year, sum, data=NEI)

png("plot1.png")
plot(emissions$year,emissions$Emissions,type="n",xlab="Year",ylab="Total PM2.5 Emission",boxwex=0.05)
lines(emissions$year,emissions$Emissions, col="blue")
dev.off()
