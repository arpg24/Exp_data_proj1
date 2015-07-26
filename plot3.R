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

NEI_Baltimore<-NEI[NEI$fips == "24510",]

ag_data<-ddply(NEI_Baltimore,.(year,type),summarize,sum=sum(Emissions))

png("plot3.png")
gplot<-ggplot(ag_data,aes(year,sum))
gplot+geom_point()+facet_grid(.~type)+labs(title="PM2.5 Emission in Baltimore city",
y="total PM2.5 emission each year")
dev.off()
