NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.MotVh<- SCC$SCC[grep("Vehicles", SCC$SCC.Level.Two)]
NEI.BLLA.MotVh <- subset(NEI, (fips == "24510" | fips == "06037") & SCC %in% SCC.MotVh)
NEI.BLLA.MotVh$County[NEI.BLLA.MotVh$fips == "24510"] <- "Baltimore City"
NEI.BLLA.MotVh$County[NEI.BLLA.MotVh$fips == "06037"] <- "Los Angeles County"
ytotal.BLLA.MotVh <- aggregate(Emissions ~ County + year, NEI.BLLA.MotVh, sum)

hlines <- ytotal.BLLA.MotVh[ytotal.BLLA.MotVh$year == 2008, c(3,2,1)]
ylabels <- trunc(c(max(ytotal.BLLA.MotVh$Emissions), min(ytotal.BLLA.MotVh$Emissions),
                   ytotal.BLLA.MotVh$Emissions[ytotal.BLLA.MotVh$year == 1999 |
                                                  ytotal.BLLA.MotVh$year == 2008]), 0)  

library(ggplot2)
g <- ggplot(ytotal.BLLA.MotVh, aes(year,Emissions))

png(filename="Plot6.png", width=640, bg="transparent")
  g + geom_line() + 
    geom_point() + 
    facet_grid(.~County) + 
    geom_hline(aes(yintercept=hlines[,1]), hlines, color="red", linetype="dashed") +
    scale_x_continuous(breaks=c(1999,2002,2005,2008)) + coord_cartesian(xlim=c(1998,2009)) +
    scale_y_continuous(breaks=unique(ylabels), minor_breaks=NULL) +
    labs(x=NULL, y="Emissions, tons") + 
    ggtitle(expression(paste("PM"[2.5]," emissions in Baltimore City, types of sources"))) +
    theme_bw()
dev.off()