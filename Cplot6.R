# Question 6, Exploratory DAta Analysis Project2, Question 6

library(ggplot2)

if(!exists("NEIdata"))
{
  NEIdata <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCCdata"))
{
  SCCdata <- readRDS("Source_Classification_Code.rds")
}

# Now, merge the above 2 datasets to one
if(!exists("NEISCC"))
{
  NEISCCdata <- merge(NEIdata, SCCdata, by="SCC")
}
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# 24510 is Baltimore, see plot2.R, 06037 is LA CA, sarch for ON-ROAD type in NEI and for 'motor' in SCC to get (non-cars)
subsetNEI <- NEIdata[(NEIdata$fips=="24510"|NEIdata$fips=="06037") & NEIdata$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity") + xlab("year") +  ylab(expression('Total PM'[2.5]*" Emissions")) +  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
png("Cplot6.png", width=1040, height=480)
print(g)
dev.off()
