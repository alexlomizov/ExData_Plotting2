NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.CoalComb <- SCC$SCC[grep("Coal",SCC$SCC.Level.Three[grep("Combustion",SCC$SCC.Level.One)])]
NEI.CoalComb <- subset(NEI, SCC %in% SCC.CoalComb)
ytotal.CoalComb <- aggregate(Emissions ~ year, NEI.CoalComb, sum)

png(filename="Plot4.png", width=640)
  with(ytotal.CoalComb, {
    plot(year, Emissions, type="o", ylim=c(0,max(Emissions)), axes=FALSE, ann=FALSE)
    title(expression(paste("PM"[2.5],
      " emissions from coal combustion-related sources in the United States")))
    axis(1, year, year)
    axis(2, c(0,Emissions), c(0,sprintf("%.0f", Emissions/1e+3)))
    title(xlab="", ylab="Emissions, thousands tons")
    abline(Emissions[4],0, col="red", lty="dashed")
  })
dev.off()