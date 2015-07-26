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

NEI_SCC <- merge(NEI, SCC, by.x="SCC", by.y="SCC", all=TRUE)
data <- subset(NEI_SCC, (fips == "24510" | fips == "06037") & type =="ON-ROAD", c("Emissions", "year","type", "fips"))
data$city[data$fips=="24510"]<-"Baltimore"
data$city[data$fips=="06037"]<-"LA"

ag_data<-ddply(data,.(year,city),summarize,sum=sum(Emissions))

png("plot6.png")
gplot<-ggplot(ag_data,aes(year,sum))
gplot+geom_point(aes(color=city),size=2)+labs(title="PM2.5 Emission from motor vehicle sources",
                                              y="total PM2.5 emission each year")
dev.off()