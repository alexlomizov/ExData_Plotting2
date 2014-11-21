NEI <- readRDS("summarySCC_PM25.rds")
ytotal <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
xticks <- c(0,max(ytotal[,2])%/%3e+6,max(ytotal[,2])%/%3e+6*2,max(ytotal[,2])%/%3e+6*3,max(ytotal[,2])%/%3e+6*4) 

png(filename = "plot.png", bg = "transparent")
  plot(ytotal, type="o", main=expression("Total US emissions from PM"[2.5]), xlab="", ylab="Emissions, tons", ylim=c(0,1.1*max(ytotal[,2])), axes=FALSE)
  axis(1,ytotal[,1],ytotal[,1])
  axis(2,xticks*1e+6,sprintf("%.0fmln", xticks))
  text(ytotal[1,1], ytotal[1,2], sprintf("%.1fmln", ytotal[1,2]/1e+6), pos=4)
  text(ytotal[4,1], ytotal[4,2], sprintf("%.1fmln", ytotal[4,2]/1e+6), pos=2)
dev.off
