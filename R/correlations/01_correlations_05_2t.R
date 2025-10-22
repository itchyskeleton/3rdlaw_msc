##############################################################
# Kendall correlations with windows, cut = 0.5, 2 thresholds #
##############################################################

library(here)
library(stats)
library(scales)

load(here("data","processed","corrs_prereqs_cut05_2t.RData"))

# 1. Let's split the data frames into localities and statuses. The cor.test function won't work if we don't do this.

dec_status <- split(dec, as.factor(dec$status))
dec_local <- split(dec, as.factor(dec$locality))

eq_status <- split(eq, as.factor(eq$status))
eq_local <- split(eq, as.factor(eq$locality))

rise_status <- split(rise, as.factor(rise$status))
rise_local <- split(rise, as.factor(rise$locality))

##########################

# WITH 18 LINEAGES

####################
# 2. Kendall corrs
####################

# 2a. Without dividing

neutral_rise <- cor.test(
  x=rise$extinction,
  y=rise$speciation,
  method="kendall",
  alternative="two.sided"
)

neutral_eq <- cor.test(
  x=eq$extinction,
  y=eq$speciation,
  method="kendall",
  alternative="two.sided"
)

neutral_dec <- cor.test(
  x=dec$extinction,
  y=dec$speciation,
  method="kendall",
  alternative="two.sided"
)

# 2b. By status

# Rise

alive_kendall_rise <- cor.test(
  x=rise_status$extant$extinction, 
  y=rise_status$extant$speciation, 
  method="kendall", 
  alternative="two.sided"
)

dead_kendall_rise <- cor.test(
  x=rise_status$extinct$extinction, 
  y=rise_status$extinct$speciation, 
  method="kendall", 
  alternative="two.sided"
)


# Equilibrium

alive_kendall_eq <- cor.test(
  x=eq_status$extant$extinction, 
  y=eq_status$extant$speciation, 
  method="kendall", 
  alternative="two.sided"
)

dead_kendall_eq <- cor.test(
  x=eq_status$extinct$extinction, 
  y=eq_status$extinct$speciation, 
  method="kendall", 
  alternative="two.sided"
)



# Decline

alive_kendall_dec <- cor.test(
  x=dec_status$extant$extinction, 
  y=dec_status$extant$speciation, 
  method="kendall", 
  alternative="two.sided"
)

dead_kendall_dec <- cor.test(
  x=dec_status$extinct$extinction, 
  y=dec_status$extinct$speciation, 
  method="kendall", 
  alternative="two.sided"
)


# 2c. By locality

# Rise

eu_kendall_rise <- cor.test(
  x=rise_local$EU$extinction, 
  y=rise_local$EU$speciation, 
  method="kendall", 
  alternative="two.sided"
)

nam_kendall_rise <- cor.test(
  x=rise_local$NAm$extinction, 
  y=rise_local$NAm$speciation, 
  method="kendall", 
  alternative="two.sided"
)


# Equilibrium

eu_kendall_eq <- cor.test(
  x=eq_local$EU$extinction, 
  y=eq_local$EU$speciation, 
  method="kendall", 
  alternative="two.sided"
)

nam_kendall_eq <- cor.test(
  x=eq_local$NAm$extinction, 
  y=eq_local$NAm$speciation, 
  method="kendall", 
  alternative="two.sided"
)



# Decline

eu_kendall_dec <- cor.test(
  x=dec_local$EU$extinction, 
  y=dec_local$EU$speciation, 
  method="kendall", 
  alternative="two.sided"
)

nam_kendall_dec <- cor.test(
  x=dec_local$NAm$extinction, 
  y=dec_local$NAm$speciation, 
  method="kendall", 
  alternative="two.sided"
)

# 2d. Saving those objects to plot the results image

save(alive_kendall_dec,alive_kendall_eq,alive_kendall_rise,dead_kendall_dec,dead_kendall_eq,dead_kendall_rise,nam_kendall_dec,nam_kendall_eq,nam_kendall_rise,eu_kendall_dec,eu_kendall_eq,eu_kendall_rise,neutral_dec,neutral_eq,neutral_rise, file=here("output","correlations","data","cut05_2t.RData"))



###############################
# 3. Plotting the correlations
###############################

# 3a. No division

# Rise
par(mar=c(5,5,3,3))

pdf(file=here("output","correlations","images","cut05_2t","neutral_rise.pdf"),
    width=8.3,
    height=5.8
)

plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=21,
     bg=alpha("#1E88E5",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Expansion (cut=0.1, two thresholds)",
     cex.axis=1.5)
#abline(lm(speciation ~ extinction, data=rise), col="#1E88E5", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.84, y=0.01, labels="tau = 0.0980 (NS)", col="#1E88E5", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)

dev.off()


# Equilibrium
pdf(file=here("output","correlations","images","cut05_2t","neutral_equilibrium.pdf"),
    width=8.3,
    height=5.8
)

plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=21,
     bg=alpha("#FFC107",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Equilibrium (cut=0.1, two thresholds)",
     cex.axis=1.5)
abline(lm(speciation ~ extinction, data=eq), col="#FFC107", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.8, labels="tau = 0.6993, p < 0.01", col="#FFC107", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)

dev.off()


# Decline
pdf(file=here("output","correlations","images","cut05_2t","neutral_decline.pdf"),
    width=8.3,
    height=5.8
)

plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=21,
     bg=alpha("#D81B60",0.6),
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Decline (cut=0.1, two thresholds)",
     cex.axis=1.5)
#abline(lm(speciation ~ extinction, data=dec), col="#D81B60", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.84, y=0.01, labels="tau = 0.3590 (NS)", col="#D81B60", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)

dev.off()

# 3b. By status

# Rise
par(mar=c(5,5,3,3))

pdf(file=here("output","correlations","images","cut05_2t","status_rise.pdf"),
    width=8.3,
    height=5.8
)

plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Expansion (cut=0.5, two thresholds)",
     cex.axis=1.5)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.1, labels="tau = -0.1026 (NS)", col="#68a83b", cex=1.5)
text(x=0.84, y=0.01, labels="tau = 0.6 (NS)", col="#FF007D", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)

dev.off()


# Equilibrium
pdf(file=here("output","correlations","images","cut05_2t","status_equilibrium.pdf"),
    width=8.3,
    height=5.8
)

plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Equilibrium (cut=0.5, two thresholds)",
     cex.axis=1.5)
abline(lm(speciation ~ extinction, data=eq, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=eq, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.35, y=0.7, labels="tau = 0.7436, p < 0.01", col="#68a83b", cex=1.5)
text(x=0.84, y=0.01, labels="tau = 0.6 (NS)", col="#FF007D", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)

dev.off()



# Decline
pdf(file=here("output","correlations","images","cut05_2t","status_decline.pdf"),
    width=8.3,
    height=5.8
)

plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Decline (cut=0.5, two thresholds)",
     cex.axis=1.5)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extant")), col="#68a83b", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.84, y=0.9, labels="tau = 0.2143 (NS)", col="#68a83b", cex=1.5)
text(x=0.87, y=0.81, labels="tau = 0.4 (NS)", col="#FF007D", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)


dev.off()


# Legend
pdf(file=here("output","correlations","images","cut05_2t","legend_status.pdf"),
    width=8.3,
    height=5.8
)

plot(x=NULL, y=NULL, type="n", main="", xlim=c(0,10), ylim=c(0,10), xaxt="n", yaxt="n", bty="n", xlab="", ylab="")
legend(
  "left",
  col=c("#68a83b","#FF007D"), 
  title="status",
  legend=c("Extant", "Extinct"), 
  horiz=F, 
  cex=1.5, 
  xpd=T,
  pch=19,
  pt.cex=2.5,
  bty="n",
  xjust=0
)

legend(
  "right",
  col="gray",
  title="Localities",
  legend=c("EU", "NA"), 
  horiz=F, 
  cex=1.5, 
  xpd=T,
  pch=c(19,15),
  pt.cex=2.5,
  bty="n",
  xjust=0
)

dev.off()




# 3c. By location

par(mar=c(5,5,3,3))

# Rise
pdf(file=here("output","correlations","images","cut05_2t","location_rise.pdf"),
    width=8.3,
    height=5.8
)

plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Expansion (cut=0.5, two thresholds)",
     cex.axis=1.5)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=rise, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.84, y=0.1, labels="tau = 0.1111 (NS)", col="#ca8198", cex=1.5)
text(x=0.84, y=0.01, labels="tau = 0.1428 (NS)", col="#008f99", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)


dev.off()


# Equilibrium
pdf(file=here("output","correlations","images","cut05_2t","location_equilibrium.pdf"),
    width=8.3,
    height=5.8
)

plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Equilibrium (cut=0.5, two thresholds)",
     cex.axis=1.5)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="EU")), col="#ca8198", lwd=2)
abline(lm(speciation ~ extinction, data=eq, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.8, y=0.5, labels="tau = 0.7778, p < 0.01", col="#ca8198", cex=1.5)
text(x=0.4, y=0.85, labels="tau = 0.7143, p < 0.05", col="#008f99", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)

dev.off()


# Decline
pdf(file=here("output","correlations","images","cut05_2t","location_decline.pdf"),
    width=8.3,
    height=5.8
)

plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="",
     xlim=c(0,1),
     ylab="",
     ylim=c(0,1),
     main="Decline (cut=0.5, two thresholds)",
     cex.axis=1.5)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=dec, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.84, y=0.1, labels="tau = 0.2857 (NS)", col="#ca8198", cex=1.5)
text(x=0.87, y=0.01, labels="tau = 0.6 (NS)", col="#008f99", cex=1.5)
mtext("Extinction rates", 1, line=3, cex=1.5)
mtext("Speciation rates", 2, line=3, cex=1.5)

dev.off()


# Legend
pdf(file=here("output","correlations","images","cut05_2t","legend_location.pdf"),
    width=8.3,
    height=5.8
)

plot(x=NULL, y=NULL, type="n", main="", xlim=c(0,10), ylim=c(0,10), xaxt="n", yaxt="n", bty="n", xlab="", ylab="")
legend(
  "left",
  col=c("#ca8198","#008f99"), 
  title="Localities",
  legend=c("EU", "NA"), 
  horiz=F, 
  cex=1.5, 
  xpd=T,
  pch=19,
  pt.cex=2.5,
  bty="n",
  xjust=0
)

legend(
  "right",
  col="gray",
  title="Status",
  legend=c("Extant", "Extinct"), 
  horiz=F, 
  cex=1.5, 
  xpd=T,
  pch=c(19,15),
  pt.cex=2.5,
  bty="n",
  xjust=0
)

dev.off()