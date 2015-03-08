# Question 5, Exploratory DAta Analysis Project2, Question 5

library(ggplot2)

if(!exists("NEIdata"))
{
  NEIdata <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCCdata"))
{
  SCCdata <- readRDS("Source_Classification_Code.rds")
}

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# 24510 is Baltimore, see plot2.R, Searching for ON-ROAD type in NEI, search for 'motor' in SCC only gave a subset (non-cars)

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
dev.copy(png, file = "Cplot5.png", height = 800, width=800)
print(g)
dev.off()