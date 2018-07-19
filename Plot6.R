NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")
df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI_SCC <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

## Question 6: Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes over time 
## in motor vehicle emissions?

library(reshape2)  
  
plot_6 <- subset(NEI_SCC, (fips == "24510" | fips == "06037") & type =="ON-ROAD", 
                 c("Emissions", "year","type", "fips"))
plot_6$fips <- factor(plot_6$fips, levels=c("06037", "24510"), labels=c("Los Angeles, CA", 
                                                                        "Baltimore, MD"))
plot_6 <- melt(plot_6, id=c("year", "fips"), measure.vars=c("Emissions"))
plot_6 <- dcast(plot_6, fips + year ~ variable, sum)
plot_6[2:8,"Change"] <- diff(plot_6$Emissions)
plot_6[c(1,5),4] <- 0

ggplot(data=plot_6, aes(x=year, y=Change, group=fips, color=fips)) + 
                      geom_line() + geom_point( size=4, shape=21, fill="white") + 
                      xlab("year") + ylab("Change in Emissions (tons)") + 
                      ggtitle("Motor Vehicle PM2.5 Emissions Changes: Baltimore vs. LA") +
                      labs(color="City")

ggsave(file="plot_6.png")