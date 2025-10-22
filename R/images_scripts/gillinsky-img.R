################################
# REPDRODUCING GILLINSKY'S IMG #
################################

library(here)
library(RColorBrewer)
library(scales)

gillinsky <- read.csv(here("data","processed","gillinsky_data.csv"), header=T)
gillinsky <- gillinsky[-which(gillinsky$Origination==0),]

factors <- split(gillinsky, gillinsky$Status)

colors <- brewer.pal("Pastel1", n=3)

png(filename=here("output", "images", "gillinsky_reproduced.png"), 
    width=400, height=300)

plot(
  factors$extinct$Origination ~ factors$extinct$Extinction,
  pch=21,
  col=colors[1],
  bg=alpha(colors[1],0.4),
  cex=1.4,
  bty="l",
  ylim=c(0,0.6),
  ylab="Origination probablity",
  xlab="Extinction probability"
)

points(
  factors$extant$Origination ~ factors$extant$Extinction,
  pch=21,
  col=colors[2],
  bg=alpha(colors[2],0.4),
  cex=1.4
)

legend(
  "bottomright",
  pch=c(19,19),
  col=c(colors[1], colors[2]),
  legend=c("Extinct families", "Extant families"),
  pt.cex=1.6,
  bty="n"
)

dev.off()