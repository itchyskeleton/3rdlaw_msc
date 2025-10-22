###############################################################################
# This script tries to aggregate the correlation results by image in R by cut #
###############################################################################

library(here)
library(RColorBrewer)
library(scales)

load(here("data","processed","corrs_prereqs_cut05_2t.RData"))

matriz <- matrix(c(1,2,3,4,5,6,7,8,9,10,11,12), ncol=3, byrow=T)

##############
# No windows #
##############

load(here("data", "processed","mean_rates.RData"))

color <- brewer.pal(n=1, "Pastel1")
color <- sample(color, 1)

par(mar=c(5,5,3,3) 
    #mfrow=c(3,1)
)

pdf(file=here("output", "images", "results_nowindows_1.pdf"),
    height=8.27,
    width=11.7)

plot(mean_rates$speciation ~ mean_rates$extinction,
     bty="l",
     cex=2.5,
     cex.axis=1.8,
     col="black",
     pch=21,
     bg=color,
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main=""
)
abline(lm(speciation ~ extinction, data=mean_rates), col=color, lwd=3)
text(x=0.4, y=0.8, labels="tau = 0.6601, p < 0.01", col=color, cex=2.3)
abline(0,1,lwd=2, lty=2, col="darkgray")
mtext("Speciation rates", 2, line=2.7, cex=1.8)
mtext("Extinction rates", 1, line=3, cex=1.8)
mtext(substitute(paste(bold("Kendall correlation (no windows)"))), 3, line=1, cex=2)

dev.off()


pdf(file=here("output", "images", "results_nowindows_2.pdf"),
    height=8.27,
    width=11.7)

plot(x=mean_rates$extinction,
     y=mean_rates$speciation,
     bty="l",
     cex=2.5,
     col="black",
     pch=c(21,22)[as.factor(mean_rates$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(mean_rates$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=1.8)
abline(lm(speciation ~ extinction, data=mean_rates, subset=(status=="extant")), col="#68a83b", lwd=3)
abline(lm(speciation ~ extinction, data=mean_rates, subset=(status=="extinct")), col="#FF007D", lwd=3)
text(x=0.4, y=0.8, labels="tau = 0.6154, p < 0.01", col="#68a83b", cex=2.3)
text(x=0.75, y=0.5, labels="tau = 1, p < 0.05", col="#FF007D", cex=2.3)
abline(0,1,lwd=2, lty=2, col="darkgray")
mtext("Speciation rates", 2, line=2.7, cex=1.8)
mtext("Extinction rates", 1, line=3, cex=1.8)
mtext(substitute(paste(bold("Correlation by status (no windows)"))), 3, line=1, cex=2)
legend("bottomright",
       col=c("#68a83b","#FF007D","gray","gray"),
       legend=c("Extant", "Extinct", "EU", "NA"),
       pch=c(19,19,19,15),
       ncol=2,
       cex=2
)

dev.off()




pdf(file=here("output", "images", "results_nowindows_3.pdf"),
    height=8.27,
    width=11.7)

plot(x=mean_rates$extinction,
     y=mean_rates$speciation,
     bty="l",
     cex=2.5,
     col="black",
     pch=c(21,22)[as.factor(mean_rates$status)],
     bg=c("#ca8198","#008f99")[as.factor(mean_rates$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=1.8)
abline(lm(speciation ~ extinction, data=mean_rates, subset=(locality=="EU")), col="#ca8198", lwd=3)
#abline(lm(speciation ~ extinction, data=mean_rates, subset=(locality=="NAm")), col="#008f99", lwd=2)
text(x=0.4, y=0.8, labels="tau = 0.7333, p < 0.01", col="#ca8198", cex=2.3)
text(x=0.87, y=0.25, labels="tau = 0.5714 (NS)", col="#008f99", cex=2.3)
abline(0,1,lwd=2, lty=2, col="darkgray")
mtext("Speciation rates", 2, line=2.7, cex=1.8)
mtext("Extinction rates", 1, line=3, cex=1.8)
mtext(substitute(paste(bold("Correlation by geography (no windows)"))), 3, line=1, cex=2)
legend("bottomright",
       col=c("#ca8198","#008f99","gray","gray"),
       legend=c("EU", "NA", "Extant", "Extinct"),
       pch=c(19,19,19,15),
       ncol=2,
       cex=2
)

dev.off()





##################
# Two thresholds #
##################

##### CUT = 0.1 ####

pdf(file=here("output", "images", "results_bycut_2t_preliminar.pdf"),
    width=16.5,
    height=11.7)

matricius <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T)

layout(matricius 
       #heights=c(0.3,0.3,0.3,0.1)
       )
par(mar=c(5,5,3,3))

load(here("output","correlations","data","cut01_2t.RData"))
load(here("data","processed","corrs_prereqs_cut01_2t.RData"))

plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#1E88E5",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise), col="#1E88E5", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.05, labels="tau = 0.1751 (NS)", col="#1E88E5", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext(substitute(paste(bold("Expansion"))), 3, line=1, cex=2)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#FFC107",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq), col="#FFC107", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.72, labels="tau = 0.7436, p < 0.01", col="#FFC107", cex=2.3)
mtext(substitute(paste(bold("Equilibrium"))), 3, line=1, cex=2)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#D81B60",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec), col="#D81B60", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.18, labels="tau = 0.3846 (NS)", col="#D81B60", cex=2.3)
mtext(substitute(paste(bold("Decline"))), 3, line=1, cex=2)


plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.20, labels="tau = 0.1282 (NS)", col="#68a83b", cex=2.3)
text(x=0.84, y=0.05, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.75, labels="tau = 0.7857, p < 0.01", col="#68a83b", cex=2.3)
text(x=0.87, y=0.05, labels="tau = 0.6 (NS)", col="#FF007D", cex=2.3)




plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.18, labels="tau = 0.2857 (NS)", col="#68a83b", cex=2.3)
text(x=0.84, y=1, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.25, labels="tau = 0.2889 (NS)", col="#ca8198", cex=2.3)
text(x=0.8, y=0.05, labels="tau = 0.2857 (NS)", col="#008f99", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext("Extinction rates", 1, line=3, cex=1.3)



plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.4, y=0.85, labels="tau = 0.9285, p < 0.01", col="#ca8198", cex=2.3)
text(x=0.84, y=0.05, labels="tau = 0.6 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)



plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.18, labels="tau = 0.4286 (NS)", col="#ca8198", cex=2.3)
text(x=0.84, y=1, labels="tau = 0.8 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)

plot(x=NULL, y=NULL, type="n", main="", xlim=c(0,10), ylim=c(0,10), xaxt="n", yaxt="n", bty="n", xlab="", ylab="")

plot(x=NULL, y=NULL, type="n", main="", xlim=c(0,10), ylim=c(0,10), xaxt="n", yaxt="n", bty="n", xlab="", ylab="")
legend(
  "left",
  col=c("#68a83b","#FF007D"), 
  title="Status",
  legend=c("Extant", "Extinct"), 
  horiz=F, 
  cex=2, 
  xpd=T,
  pch=19,
  pt.cex=3,
  bty="n",
  xjust=0
)

legend(
  "right",
  col="gray",
  title="Localities",
  legend=c("EU", "NA"), 
  horiz=F, 
  cex=2, 
  xpd=T,
  pch=c(19,15),
  pt.cex=3,
  bty="n",
  xjust=0
)


dev.off()








##### CUT = 0.5 ####

pdf(file=here("output", "images", "18l_05_results_bycut_2t_preliminar.pdf"),
    width=16.5,
    height=11.7)

matricius <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T)

layout(matricius)
par(mar=c(5,5,3,3))

load(here("output","correlations","data","cut05_2t.RData"))
load(here("data","processed","corrs_prereqs_cut05_2t.RData"))


plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#1E88E5",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise), col="#1E88E5", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.05, labels="tau = 0.1372 (NS)", col="#1E88E5", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext(substitute(paste(bold("Expansion"))), 3, line=1, cex=2)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#FFC107",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq), col="#FFC107", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.8, labels="tau = 0.6601, p < 0.01", col="#FFC107", cex=2.3)
mtext(substitute(paste(bold("Equilibrium"))), 3, line=1, cex=2)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#D81B60",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec), col="#D81B60", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.18, labels="tau = 0.3077 (NS)", col="#D81B60", cex=2.3)
mtext(substitute(paste(bold("Decline"))), 3, line=1, cex=2)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.78, y=0.20, labels="tau = -0.0256 (NS)", col="#68a83b", cex=2.3)
text(x=0.84, y=0.05, labels="tau = 0.6 (NS)", col="#FF007D", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.75, labels="tau = 0.7179, p < 0.01", col="#68a83b", cex=2.3)
text(x=0.84, y=0.05, labels="tau = 0.6 (NS)", col="#FF007D", cex=2.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.18, labels="tau = 0.0714 (NS)", col="#68a83b", cex=2.3)
text(x=0.84, y=1.05, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.2, labels="tau = 0.1111 (NS)", col="#ca8198", cex=2.3)
text(x=0.8, y=0.05, labels="tau = 0.1428 (NS)", col="#008f99", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext("Extinction rates", 1, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="EU")), col="#ca8198", lwd=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.4, y=0.85, labels="tau = 0.6889, p < 0.01", col="#ca8198", cex=2.3)
text(x=0.72, y=0.35, labels="tau = 0.7143, p < 0.05", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.18, labels="tau = 0.2889 (NS)", col="#ca8198", cex=2.3)
text(x=0.84, y=1.05, labels="tau = 0.6 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)


dev.off()








###### CUT = 0.9 ######

pdf(file=here("output", "images", "18l_09_results_bycut_2t_preliminar.pdf"),
    width=16.5,
    height=11.7)

matricius <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T)

layout(matricius)
par(mar=c(5,5,3,3))

load(here("output","correlations","data","cut09_2t.RData"))
load(here("data","processed","corrs_prereqs_cut09_2t.RData"))


plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#1E88E5",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise), col="#1E88E5", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.05, labels="tau = 0.1111 (NS)", col="#1E88E5", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext(substitute(paste(bold("Expansion"))), 3, line=1, cex=2)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#FFC107",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq), col="#FFC107", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.33, y=0.8, labels="tau = 0.6601, p < 0.01", col="#FFC107", cex=2.3)
mtext(substitute(paste(bold("Equilibrium"))), 3, line=1, cex=2)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#D81B60",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec), col="#D81B60", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.18, labels="tau = 0.3077 (NS)", col="#D81B60", cex=2.3)
mtext(substitute(paste(bold("Decline"))), 3, line=1, cex=2)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.87, y=0.2, labels="tau = 0 (NS)", col="#68a83b", cex=2.3)
text(x=0.83, y=0.05, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extant")), col="#68a83b", lwd=2)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.3, y=0.75, labels="tau = 0.6667, p < 0.01", col="#68a83b", cex=2.3)
text(x=0.7, y=0.4, labels="tau = 1, p < 0.05", col="#FF007D", cex=2.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.1428 (NS)", col="#68a83b", cex=2.3)
text(x=0.84, y=1, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.2, labels="tau = 0.1556 (NS)", col="#ca8198", cex=2.3)
text(x=0.78, y=0.05, labels="tau = -0.1428 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.3, y=0.8, labels="tau = 0.6889, p < 0.01", col="#ca8198", cex=2.3)
text(x=0.8, y=0.05, labels="tau = 0.5714 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.2857 (NS)", col="#ca8198", cex=2.3)
text(x=0.84, y=1, labels="tau = 0.6 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)

dev.off()






#################
# ONE THRESHOLD #
#################

### CUT = 0.1 ###

pdf(file=here("output", "images", "results_bycut_1t_preliminar.pdf"),
    width=16.5,
    height=11.7)

matricius <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T)

layout(matricius 
       #heights=c(0.3,0.3,0.3,0.1)
)
par(mar=c(5,5,3,3))

load(here("output","correlations","data","cut01_1t.RData"))
load(here("data","processed","corrs_prereqs_cut01_1t.RData"))

plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#1E88E5",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise), col="#1E88E5", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.05, labels="tau = 0.1503 (NS)", col="#1E88E5", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext(substitute(paste(bold("Expansion"))), 3, line=1, cex=2)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#FFC107",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq), col="#FFC107", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.3, y=0.73, labels="tau = 0.7179, p < 0.01", col="#FFC107", cex=2.3)
mtext(substitute(paste(bold("Equilibrium"))), 3, line=1, cex=2)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#D81B60",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec), col="#D81B60", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.3636 (NS)", col="#D81B60", cex=2.3)
mtext(substitute(paste(bold("Decline"))), 3, line=1, cex=2)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.87, y=0.05, labels="tau = 0 (NS)", col="#68a83b", cex=2.3)
text(x=0.84, y=0.22, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.85, labels="tau = 0.8571, p < 0.01", col="#68a83b", cex=2.3)
text(x=0.84, y=0.05, labels="tau = 0.6 (NS)", col="#FF007D", cex=2.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.1428 (NS)", col="#68a83b", cex=2.3)
text(x=0.85, y=1, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.2, labels="tau = 0.1111 (NS)", col="#ca8198", cex=2.3)
text(x=0.8, y=0.05, labels="tau = 0.2857 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.4, y=0.8, labels="tau = 0.8571, p < 0.01", col="#ca8198", cex=2.3)
text(x=0.84, y=0.05, labels="tau = 0.6 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.2857 (NS)", col="#ca8198", cex=2.3)
text(x=0.8, y=1, labels="tau = 0.6667 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.5)


dev.off()






### CUT = 0.5 ###

pdf(file=here("output", "images", "18l_05_results_bycut_1t_preliminar.pdf"),
    width=16.5,
    height=11.7)

matricius <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T)

layout(matricius 
       #heights=c(0.3,0.3,0.3,0.1)
)
par(mar=c(5,5,3,3))

load(here("output","correlations","data","cut05_1t.RData"))
load(here("data","processed","corrs_prereqs_cut05_1t.RData"))


plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#1E88E5",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise), col="#1E88E5", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.05, labels="tau = 0.1618 (NS)", col="#1E88E5", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext(substitute(paste(bold("Expansion"))), 3, line=1, cex=2)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#FFC107",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq), col="#FFC107", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.3, y=0.8, labels="tau = 0.5686, p < 0.01", col="#FFC107", cex=2.3)
mtext(substitute(paste(bold("Equilibrium"))), 3, line=1, cex=2)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#D81B60",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec), col="#D81B60", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.4286 (NS)", col="#D81B60", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)
mtext(substitute(paste(bold("Decline"))), 3, line=1, cex=2)




plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.87, y=0.25, labels="tau = 0 (NS)", col="#68a83b", cex=2.3)
text(x=0.87, y=0.05, labels="tau = 0.6 (NS)", col="#FF007D", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.3, y=0.8, labels="tau = 0.5641, p < 0.01", col="#68a83b", cex=2.3)
text(x=0.85, y=0.05, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.3333 (NS)", col="#68a83b", cex=2.3)
text(x=0.85, y=1, labels="tau = 0.4 (NS)", col="#FF007D", cex=2.3)



plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.2, labels="tau = 0.1667 (NS)", col="#ca8198", cex=2.3)
text(x=0.8, y=0.05, labels="tau = 0.1429 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.8, labels="tau = 0.6889, p < 0.01", col="#ca8198", cex=2.3)
text(x=0.8, y=0.05, labels="tau = 0.5714 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.84, y=1.15, labels="tau = 0.6 (NS)", col="#ca8198", cex=2.3)
text(x=0.8, y=1, labels="tau = 0.3333 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)

dev.off()








### CUT = 0.9 ###

pdf(file=here("output", "images", "18l_09_results_bycut_1t_preliminar.pdf"),
    width=16.5,
    height=11.7)

matricius <- matrix(c(1,2,3,4,5,6,7,8,9), ncol=3, byrow=T)

layout(matricius 
       #heights=c(0.3,0.3,0.3,0.1)
)
par(mar=c(5,5,3,3))

load(here("output","correlations","data","cut09_1t.RData"))
load(here("data","processed","corrs_prereqs_cut09_1t.RData"))


plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#1E88E5",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise), col="#1E88E5", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.05, labels="tau = 0.1238 (NS)", col="#1E88E5", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)
mtext(substitute(paste(bold("Expansion"))), 3, line=1, cex=2)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#FFC107",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq), col="#FFC107", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.8, labels="tau = 0.5425, p < 0.01", col="#FFC107", cex=2.3)
mtext(substitute(paste(bold("Equilibrium"))), 3, line=1, cex=2)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=21,
     bg=alpha("#D81B60",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec), col="#D81B60", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.6667 (NS)", col="#D81B60", cex=2.3)
mtext(substitute(paste(bold("Decline"))), 3, line=1, cex=2)


plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.79, y=0.2, labels="tau = -0.0909 (NS)", col="#68a83b", cex=2.3)
text(x=0.8, y=0.05, labels="tau = 0.6667 (NS)", col="#FF007D", cex=2.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(status=="extinct")), col="#FF007D", lwd=2)
text(x=0.35, y=0.8, labels="tau = 0.5385, p < 0.05", col="#68a83b", cex=2.3)
text(x=0.84, y=0.05, labels="tau = 0.6 (NS)", col="#FF007D", cex=2.3)


plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=1.15, labels="tau = 0.3333 (NS)", col="#68a83b", cex=2.3)
text(x=0.7, y=1, labels="Not enough observations", col="#FF007D", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)
mtext("Speciation rates", 2, line=3, cex=1.3)




plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.2, labels="tau = 0.2222 (NS)", col="#ca8198", cex=2.3)
text(x=0.83, y=0.05, labels="tau = -0.2 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)
mtext("Speciation rates", 2, line=3, cex=1.3)


plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.8, labels="tau = 0.5111, p < 0.05", col="#ca8198", cex=2.3)
text(x=0.83, y=0.05, labels="tau = 0.5 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)



plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=2,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1.2),
     main="",
     cex.axis=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.87, y=1.15, labels="tau = 1 (NS)", col="#ca8198", cex=2.3)
text(x=0.87, y=1, labels="tau = 1 (NS)", col="#008f99", cex=2.3)
mtext("Extinction rates", 1, line=3, cex=1.3)


dev.off()