NEI <- readRDS("summarySCC_PM25.rds")

NEI.BL <- subset(NEI, fips == "24510" )
ytotal.BL <- aggregate(Emissions ~ year, NEI.BL, sum)

png(filename="Plot2.png", width=640, bg="transparent")
  with(ytotal.BL, {
    plot(year, Emissions, type="o", ylim=c(0,max(Emissions)), axes=FALSE, ann=FALSE)
    title(main=expression(paste("Total emissions from PM"[2.5]," in Baltimore City")))
    axis(1, year, year)
    axis(2,c(0,Emissions), c(0,sprintf("%.1f", Emissions/1e+3)))
    title(xlab="", ylab="Emissions, thousand tons")
    abline(Emissions[4],0, col="red", lty="dashed")
  }) 
dev.off()