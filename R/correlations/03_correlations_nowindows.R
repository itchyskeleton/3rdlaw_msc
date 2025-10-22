########################################
# Kendall correlations without windows #
########################################

library(here)

# 1. Retrieving mean speciation and extinction rates

# 1a. Creating a data frame to store the rates

mean_rates <- data.frame(
  speciation=rep(NA, times=18),
  extinction=rep(NA, times=18),
  status=c("extinct","extinct","extant","extant","extant","extant","extant","extant","extant","extant","extant","extinct","extinct","extinct","extant","extant","extant","extant"),
  locality=c("EU","NAm","EU","NAm","EU","NAm","EU","EU","NAm","EU","NAm","EU","NAm","EU","NAm","EU","NAm","EU")
)

rownames(mean_rates) <- c("amph_eu","amph_na","cani_eu","cani_na","feli_eu","feli_na","herp_eu","hyae_eu","meph_na","must_eu","must_na","nimr_eu","nimr_na","perc_eu","proc_na","ursi_eu","ursi_na","vive_eu")


# 1b. Retrieving rates

files <- list.files(here("data", "pyrate_RTT_plots")) #List of files from which to retrieve them

sourcery <- function(file, start=1, end=Inf) {
  file.lines <- scan(file, what=character(), skip=start-1, nlines=end-start+1, sep='\n')
  file.lines.collapsed <- paste(file.lines, collapse='\n')
  source(textConnection(file.lines.collapsed))
} #Thanks Matthew Plourde @ stackoverflow for this: https://stackoverflow.com/questions/12214963/source-only-part-of-a-file

for(i in 1:length(mean_rates$speciation)){
  
  #speciation
  sourcery(file=here("data", "pyrate_RTT_plots", files[i]), start=5, end=21)
  mean_rates$speciation[i] <- mean(rate)
  
  #extinction
  sourcery(file=here("data", "pyrate_RTT_plots", files[i]), start=21, end=30)
  mean_rates$extinction[i] <- mean(rate)
  
}


# 2. Kendall correlations

# 2a. Split into localities and status

mean_status <- split(mean_rates, as.factor(mean_rates$status))

mean_local <- split(mean_rates, as.factor(mean_rates$locality))

# 2b. Correlations without dividing

neutral_kendall <- cor.test(
  x=mean_rates$extinction,
  y=mean_rates$speciation,
  method="kendall",
  alternative="two.sided"
)

# 2c. Correlations by status

alive_kendall_status <- cor.test(
  x=mean_status$extant$extinction,
  y=mean_status$extant$speciation,
  method="kendall",
  alternative="two.sided"
)

dead_kendall_status <- cor.test(
  x=mean_status$extinct$extinction,
  y=mean_status$extinct$speciation,
  method="kendall",
  alternative="two.sided"
)


# 2d. Correlations by locality

eu_kendall <- cor.test(
  x=mean_local$EU$extinction,
  y=mean_local$EU$speciation,
  method="kendall",
  alternative="two.sided"
)

nam_kendall <- cor.test(
  x=mean_local$NAm$extinction,
  y=mean_local$NAm$speciation,
  method="kendall",
  alternative="two.sided"
)


# 3. Plotting the correlations

# 3a. No division

pdf(file=here("output","correlations","images","nowindows","neutral.pdf"),
    width=8.3,
    height=5.8
)

plot(x=mean_rates$extinction,
     y=mean_rates$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=21,
     bg=alpha("#9e9cc2", 0.7),
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Kendall correlation (no windows)")
abline(lm(speciation ~ extinction, data=mean_rates), col="#9e9cc2", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.4, y=0.8, labels="tau = 0.6601, p < 0.01", col="#9e9cc2", cex=1.3)

dev.off()

# 3b. Status

pdf(file=here("output","correlations","images","nowindows","status.pdf"),
    width=8.3,
    height=5.8
)

plot(x=mean_rates$extinction,
     y=mean_rates$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(mean_rates$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(mean_rates$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Correlation by status (no windows)")
abline(lm(speciation ~ extinction, data=mean_rates, subset=(status=="extant")), col="#68a83b", lwd=2)
abline(lm(speciation ~ extinction, data=mean_rates, subset=(status=="extinct")), col="#FF007D", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.38, y=0.8, labels="tau = 0.6154, p < 0.01", col="#68a83b", cex=1.3)
text(x=0.6, y=0.42, labels="tau = 1, p < 0.05", col="#FF007D", cex=1.3)
legend("bottomright",
       col=c("#68a83b","#FF007D","gray","gray"),
       legend=c("Extant", "Extinct", "EU", "NA"),
       pch=c(19,19,19,15),
       ncol=2,
       cex=1.2
)

dev.off()


# 3c. Localities

pdf(file=here("output","correlations","images","nowindows","locality.pdf"),
    width=8.3,
    height=5.8
)

plot(x=mean_rates$extinction,
     y=mean_rates$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(mean_rates$status)],
     bg=c("#ca8198","#008f99")[as.factor(mean_rates$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Correlation by locality (no windows)")
abline(lm(speciation ~ extinction, data=mean_rates, subset=(locality=="EU")), col="#ca8198", lwd=2)
#abline(lm(speciation ~ extinction, data=mean_rates, subset=(locality=="NAm")), col="#008f99", lwd=2)
abline(0,1,lwd=2, lty=2, col="darkgray")
text(x=0.4, y=0.8, labels="tau = 0.7333, p < 0.01", col="#ca8198", cex=1.3)
text(x=0.9, y=0.2, labels="tau = 0.5714 (NS)", col="#008f99", cex=1.3)
legend("bottomright",
       col=c("#ca8198","#008f99","gray","gray"),
       legend=c("EU", "NA", "Extant", "Extinct"),
       pch=c(19,19,19,15),
       ncol=2,
       cex=1.2
)

dev.off()
