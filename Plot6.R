NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.MotVh<- SCC$SCC[grep("Vehicles", SCC$SCC.Level.Two)]
NEI.BL_LA.MotVh <- subset(NEI, (fips == "24510" | fips == "06037") & SCC %in% SCC.MotVh)
NEI.BL_LA.MotVh$County[NEI.BL_LA.MotVh$fips == "24510"] <- "Baltimore City"
NEI.BL_LA.MotVh$County[NEI.BL_LA.MotVh$fips == "06037"] <- "Los Angeles County"
ytotal.BL_LA.MotVh <- aggregate(Emissions ~ County + year, NEI.BL_LA.MotVh, sum)

hlines <- ytotal.BL_LA.MotVh[ytotal.BL_LA.MotVh$year == 2008, c(3,2,1)]
ylabels <- trunc(c(max(ytotal.BL_LA.MotVh$Emissions), min(ytotal.BL_LA.MotVh$Emissions),
                   ytotal.BL_LA.MotVh$Emissions[ytotal.BL_LA.MotVh$year == 1999 |
                                                  ytotal.BL_LA.MotVh$year == 2008]), 0)  

library(ggplot2)
g <- ggplot(ytotal.BL_LA.MotVh, aes(year,Emissions))

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