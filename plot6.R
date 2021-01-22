if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}

baltimore_data <- NEI[(NEI$fips=="24510"), ]
baltimore_data <- ddply(baltimore_data, .(year), summarize, TotalEmissions = sum(Emissions))
baltimore_data$County <- "Baltimore"
losangeles_data <- NEI[(NEI$fips=="06037"),]
losangeles_data <- ddply(losangeles_data, .(year), summarize, TotalEmissions = sum(Emissions))
losangeles_data$County <- "Los Angeles"

comparison_data <- rbind(baltimore_data, losangeles_data)
p <- ggplot(comparison_data, aes(x=factor(year), y=TotalEmissions, fill=County)) + geom_bar(aes(fill = County), position = "dodge", stat="identity") + labs(y = "Total Emissions (in log scale)", x = "Year", title="Motor vehicle emission in Baltimore and Los Angeles") + scale_y_continuous(trans = log_trans(), labels = function(x) as.character(round(x,2)))
print(p)
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()