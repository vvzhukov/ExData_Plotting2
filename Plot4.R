NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")
df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI_SCC <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

## Question 4: Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999–2008?

plot_4 <- subset(NEI_SCC, grepl('Coal',NEI_SCC$Short.Name, fixed=TRUE), 
                 c("Emissions", "year","type", "Short.Name"))

plot_4 <- aggregate(Emissions ~ year, plot_4, sum)

ggplot(data=plot_4, aes(x=year, y=Emissions)) + geom_line() + geom_point( size=4, 
                shape=21, fill="white") + xlab("year") + 
                ylab("Emissions (Tons)") + 
                ggtitle("Total United States PM2.5 Coal Emissions")

ggsave(file="plot_4.png")