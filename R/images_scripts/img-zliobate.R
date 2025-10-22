library(scales)
library(here)

a <- rnorm(1000000, 50, 20)
a <- a[-which(a <= -13)]
a <- a[-which(a >=113)]

#png(filename=here("text", "images","zliobate.png"), width=500, height=300)

plot(density(a),
  xaxt="none",
  yaxt="none",
  ylab="",
  xlab="",
  main="",
  bty="l",
  xlim=c(-30,125),
  ylim=c(0,0.023),
  lwd=5,
  col="rosybrown1"
)
title(ylab="Occupancy", xlab="Time", line=1)
points(x=-15, y=0, pch=19, col="pink3", cex=2)
text(x=-15, y=0.002, col="pink3", labels="Origination")
points(x=mean(a), y=0.0199, pch=19, col="pink3", cex=2)
text(x=mean(a), y=0.022, col="pink3", labels="Peak")
points(x=115, y=0, pch=19, col="pink3", cex=2)
text(x=115, y=0.002, pch=19, col="pink3", labels="Extinction")

dev.off()

min(a)
max(a)
density(a)


