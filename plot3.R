library(plyr)
library(ggplot2)

if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}
data <- NEI[NEI$fips == "24510",]
data <- ddply(data, .(type, year), summarize, 
              TotalEmissions = sum(Emissions))
p <- ggplot(data, aes(year, TotalEmissions)) +
  geom_line() + geom_point() + facet_wrap(~type, ncol=2) + 
  labs(title = expression('Total PM'[2.5]*" Emissions in Baltimore City, Maryland from 1999 to 2008"), x = "Year", y = expression('Total PM'[2.5]*" Emission (in tons)"))
print(p)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()