library(plyr)
library(ggplot2)

if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

coal_scc <- SCC[grep("comb.*coal", tolower(SCC$Short.Name)), "SCC"]
data <- NEI[NEI$SCC %in% coal_scc,]
data <- ddply(data, .(year), summarize, TotalEmissions = sum(Emissions)/1000)
p <- ggplot(data, aes(year, TotalEmissions)) + geom_line() + geom_point() + 
  labs(title = "Total emissions from coal combustion related sources from 1999 to 2008",
         x = "Year", y = "Total emissions in kilo tons")
print(p)
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()