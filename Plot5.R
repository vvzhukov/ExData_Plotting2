NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")
df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI_SCC <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

## Question 5: How have emissions from motor vehicle sources changed 
## from 1999–2008 in Baltimore City?

plot_5 <- subset(NEI_SCC, fips == "24510" & type =="ON-ROAD", c("Emissions", "year","type"))
plot_5 <- aggregate(Emissions ~ year, plot_5, sum)

ggplot(data=plot_5, aes(x=year, y=Emissions)) + geom_line() + 
                            geom_point( size=4, shape=21, fill="white") + xlab("year") +
                            ylab("Emissions (tons)") +
                            ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore")

ggsave(file="plot_5.png")