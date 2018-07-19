NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")
df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI_SCC <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

## Question 1: Have total emissions from PM2.5 decreased in the 
## United States from 1999 to 2008?

plot_1 <- aggregate(Emissions ~ year, NEI_SCC, sum)

plot(plot_1$year,plot_1$Emissions, main="Total US PM2.5 Emissions", "b", 
     xlab="Year", ylab="Emissions (tons)",xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

par(mar=c(5.1,5.1,4.1,2.1))
dev.copy(png, file="plot_1.png", width=720, height=480)
dev.off()