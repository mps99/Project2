# Question 4, Exploratory DAta Analysis Project2, Question 4

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
if(!exists("NEISCC")){
  NEISCCdata <- merge(NEIdata, SCCdata, by="SCC")
}

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# Extract all NEIxSCC records with Short.Name (SCC) Coal
coalMatches  <- grepl("coal", NEISCCdata$Short.Name, ignore.case=TRUE)
subsetNEISCCdata <- NEISCCdata[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')
dev.copy(png, file = "Cplot4.png", height = 800, width=800)
print(g)
dev.off()
