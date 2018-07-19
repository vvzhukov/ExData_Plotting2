NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")
df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI_SCC <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

## Question 3: Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases in emissions 
## from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?

library(reshape2)

plot_3 <- subset(NEI_SCC, fips == "24510", c("Emissions", "year","type"))
plot_3 <- melt(plot_3, id=c("year", "type"), measure.vars=c("Emissions"))
plot_3 <- dcast(plot_3, year + type ~ variable, sum)

ggplot(data=plot_3, aes(x=year, y=Emissions, group=type, color=type)) + geom_line() + 
  geom_point( size=4, shape=21, fill="white") + xlab("year") + ylab("Emissions (tons)") + 
  ggtitle("Baltimore PM2.5 Emissions by Type and Year")

ggsave(file="plot_3.png")