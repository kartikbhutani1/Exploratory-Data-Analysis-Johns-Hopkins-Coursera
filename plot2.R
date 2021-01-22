if (!"NEI" %in% ls()) {
  NEI <- readRDS("summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {
  SCC <- readRDS("Source_Classification_Code.rds")
}
data <- NEI[NEI$fips == "24510",]
print(nrow(data))
data <- tapply(data$Emissions, data$year, sum)
df <- data.frame(year=as.numeric(names(data)), 
                 emissions=data/1000)
plot(df, xaxt="n", pch=16, ylab="Emissions (ktons) in Baltimore City")
axis(side=1, at=seq(1999,2008, by=3))
segments(df[1,1], df[1,2], df[2,1], df[2,2])
segments(df[2,1], df[2,2], df[3,1], df[3,2])
segments(df[3,1], df[3,2], df[4,1], df[4,2])

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()