NEI <- readRDS("summarySCC_PM25.rds")

NEI.BL <- subset(NEI, fips == "24510" )
ytotal.BL.type <- aggregate(Emissions ~ type + year, NEI.BL, sum)

hlines <- ytotal.BL.type[ytotal.BL.type$year == 2008, c(3,2,1)]

library(ggplot2)
g <- ggplot(ytotal.BL.type, aes(year,Emissions))

png(filename="Plot3.png", width=640, bg="transparent")
  g + geom_line() + 
      geom_point() + 
      facet_grid(.~type) + 
      geom_hline(aes(yintercept=hlines[,1]), hlines, color="red", linetype="dashed") +
      scale_x_continuous(breaks=c(1999,2002,2005,2008)) + coord_cartesian(xlim=c(1998,2009)) +
      labs(x=NULL, y="Emissions, tons") + 
      ggtitle(expression(paste("PM"[2.5]," emissions in Baltimore City, types of sources"))) +
      theme_bw()
dev.off()