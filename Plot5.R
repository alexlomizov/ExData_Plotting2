NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.MotVh<- SCC$SCC[grep("Vehicles", SCC$SCC.Level.Two)]
NEI.BL.MotVh <- subset(NEI, fips == "24510" & SCC %in% SCC.MotVh)
ytotal.BL.MotVh <- aggregate(Emissions ~ year, NEI.BL.MotVh, sum)

png(filename="Plot5.png", width=640, bg="transparent")
  with(ytotal.BL.MotVh, {
    plot(year, Emissions, type="o", ylim=c(0,max(Emissions)), axes=FALSE, ann=FALSE)
    title(main=expression(paste("PM"[2.5], 
      " emissions from motor vehicle sources in Baltimore City")))
    axis(1, year, year)
    axis(2,c(0,Emissions), c(0,sprintf("%.0f", Emissions)))
    title(xlab="", ylab="Emissions, tons")
    abline(Emissions[4],0, col="red", lty="dashed")
  }) 
dev.off()