NEI <- readRDS("summarySCC_PM25.rds")
ytotal <- aggregate(Emissions ~ year, NEI, sum)

png(filename="Plot1.png", width=640)
  with(ytotal, {
    plot(year, Emissions, type="o", ylim=c(0,max(Emissions)), axes=FALSE, ann=FALSE)
    title(expression(paste("Total emissions from PM"[2.5]," in the United States")))
    axis(1, year, year)
    axis(2, c(0,Emissions), c(0,sprintf("%.1f", Emissions/1e+6)))
    title(xlab="", ylab="Emissions, mln tons")
    abline(Emissions[4],0, col="red", lty="dashed")
  })
dev.off()