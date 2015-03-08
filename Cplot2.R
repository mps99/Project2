# Question 2, Exploratory DAta Analysis Project2, Question 2

if(!exists("NEIdata"))
{
  NEIdata <- readRDS("summarySCC_PM25.rds")
  
}

if(!exists("SCCdata"))
{
  SCCdata <- readRDS("Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

subsetNEIdata  <- NEIdata[NEIdata$fips=="24510", ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEIdata, sum)

barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))
dev.copy(png, file = "Cplot2.png", height = 800, width=800)
dev.off()
