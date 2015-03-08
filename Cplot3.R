# Question 3, Exploratory DAta Analysis Project2, Question 3

library(ggplot2)

if(!exists("NEIdata"))
{
  NEIdata <- readRDS("summarySCC_PM25.rds")  
}

if(!exists("SCCdata"))
{
  SCCdata <- readRDS("Source_Classification_Code.rds")
}

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# 24510 is Baltimore, from plot2.R
subsetNEI  <- NEIdata[NEI$fips=="24510", ]

aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)

# Draw the plot 
g <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
dev.copy(png, file = "Cplot3.png", height = 800, width=800)
print(g)
dev.off()