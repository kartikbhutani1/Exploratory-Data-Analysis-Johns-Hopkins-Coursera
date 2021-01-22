library(plyr)
library(ggplot2)

if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

motor_vehicle_scc <- SCC[grep("vehicle", tolower(SCC$EI.Sector)), "SCC"]
data <- NEI[NEI$SCC %in% motor_vehicle_scc & NEI$fips == "24510",]
data <- ddply(data, .(year), summarize, TotalEmissions = sum(Emissions))
p <- ggplot(data, aes(year, TotalEmissions)) + geom_line() + geom_point() + 
  labs(title = "Total emissions from motor vehicle sources in Baltimore city (1999-2008)",
       x = "Year", y = "Total emissions in tons")
print(p)
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()