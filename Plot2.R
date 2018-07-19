NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")
df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI_SCC <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

## Question 2. Have total emissions from PM2.5 decreased in 
## the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

plot_2 <- subset(NEI_SCC, fips == "24510", c("Emissions", "year","type"))
plot_2 <- aggregate(Emissions ~ year, plot_2, sum)

plot(plot_2$year,plot_2$Emissions, main="Total Baltimore PM2.5 Emissions", 
     "b", xlab="year", ylab="Emissions (tons)",xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

par(mar=c(5.1,5.1,4.1,2.1))
dev.copy(png, file="plot_2.png", width=720, height=480)
dev.off()