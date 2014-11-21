NEI <- readRDS("summarySCC_PM25.rds")
NEI.BL <- subset(NEI, fips == "24510" )
yeartype.BL <- aggregate(Emissions ~ type + year, NEI.BL, sum)

library(ggplot2)
g <- ggplot(yeartype.BL, aes(year,Emissions))

png(filename = "Plot3.png", width = 640, bg = "transparent")
  g + geom_line() + geom_point() + theme_bw() + 
      facet_grid(.~type) + 
      scale_x_continuous(breaks=c(1999,2002,2005,2008))
dev.off()


