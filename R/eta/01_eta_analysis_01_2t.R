library(here)
library(scales)

source(here("R", "eta", "00_eta_function.R"))

load(here("data", "processed", "00_eta_prerequisites.RData")) # This file contains all information about lineages, localities and their status that we'll need for this analysis, and four empty data frames (threshold_rates, eq, dec, rise) that we'll need to store the data.

# TWO THRESHOLDS #

#### CUT = 0.1 ####

# Let's find the thresholds for rise and decline, and calculate the mean speciation and extinction rates for all 22 lineages.

# 1. Let's make a loop to perform all ETA analyses

# 1a. Listing all files we need to access and creating a list of paths for the images
files <- list.files(here("data", "pyrate_RTT_plots"))

paths <- sub("_RTT_plots.r", "_cut_01_2t.pdf", files)

# 1b. Performing the analyses
for(i in 1:length(files)){
  
  #ETA analyses
  eta(here("data", "pyrate_RTT_plots", files[i]), cut=0.1, savePlot=T, path=here("output", "eta", "images", "two_thresholds", paths[i]))
  
  #Store results in the threshold rates data frame
  threshold_rates[i,1] <- result[1,1]
  threshold_rates[i,2] <- result[2,1]
  
  #Mean rates
  eta.means()
  
  #Store results in the rise, equilibrium and decline data frames
  rise$speciation[[i]] <- sp_rise
  rise$extinction[[i]] <- ex_rise
  
  eq$speciation[[i]] <- sp_equi
  eq$extinction[[i]] <- ex_equi
  
  dec$speciation[[i]] <- sp_decl
  dec$extinction[[i]] <- ex_decl
  
}

# 1c. Another loop, just for the values, without saving new images:

for(i in 1:length(files)){
  
  #ETA analyses
  eta(here("data", "pyrate_RTT_plots", files[i]), cut=0.1, savePlot=F, two=T)
  
  #Store results in the threshold rates data frame
  threshold_rates[i,1] <- result[1,1]
  threshold_rates[i,2] <- result[2,1]
  
  #Mean rates
  eta.means()
  
  #Store results in the rise, equilibrium and decline data frames
  rise$speciation[[i]] <- sp_rise
  rise$extinction[[i]] <- ex_rise
  
  eq$speciation[[i]] <- sp_equi
  eq$extinction[[i]] <- ex_equi
  
  dec$speciation[[i]] <- sp_decl
  dec$extinction[[i]] <- ex_decl
  
}

# 2. There are NAs in the rise, eq and dec data frames, and we can't have those, so we'll remove them.
for(i in 1:length(lineages)){if(is.na(rise[i,1]==T)){rise <- rise[-i,]}}
for(i in 1:length(lineages)){if(is.na(eq[i,1]==T)){eq <- eq[-i,]}}
for(i in 1:length(lineages)){if(is.na(dec[i,1]==T)){dec <- dec[-i,]}}

rise
eq
dec #always check if all NAs have been excluded. Sometimes they aren't

# 3. Write objects into .txt files

write.table(threshold_rates, file=here("output", "eta", "tables", "2t_threshold_rates_01.txt"), row.names=T, col.names=T, sep="\t")

write.table(rise, file=here("output", "eta", "tables", "2t_mean_rise_01.txt"), row.names=T, col.names=T, sep="\t")

write.table(eq, file=here("output", "eta", "tables", "2t_mean_eq_01.txt"), row.names=T, col.names=T, sep="\t")

write.table(dec, file=here("output", "eta", "tables", "2t_mean_dec_01.txt"), row.names=T, col.names=T, sep="\t")

save(rise, eq, dec, file=here("data", "processed", "corrs_prereqs_cut01_2t.RData"))


# Independent ETA analyses to generate figures ####

#Amphicyonidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Amphicyonidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[1]] <- sp_rise
rise$extinction[[1]] <- ex_rise

eq$speciation[[1]] <- sp_equi
eq$extinction[[1]] <- ex_equi

dec$speciation[[1]] <- sp_decl
dec$extinction[[1]] <- ex_decl


#Amphicyonidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Amphicyonidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[2]] <- sp_rise
rise$extinction[[2]] <- ex_rise

eq$speciation[[2]] <- sp_equi
eq$extinction[[2]] <- ex_equi

dec$speciation[[2]] <- sp_decl
dec$extinction[[2]] <- ex_decl


#Barbourofelidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Barbourofelidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[3]] <- sp_rise
rise$extinction[[3]] <- ex_rise

eq$speciation[[3]] <- sp_equi
eq$extinction[[3]] <- ex_equi

dec$speciation[[3]] <- sp_decl
dec$extinction[[3]] <- ex_decl


#Barbourofelidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Barbourofelidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[4]] <- sp_rise
rise$extinction[[4]] <- ex_rise

eq$speciation[[4]] <- sp_equi
eq$extinction[[4]] <- ex_equi

dec$speciation[[4]] <- sp_decl
dec$extinction[[4]] <- ex_decl


#Canidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Canidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[5]] <- sp_rise
rise$extinction[[5]] <- ex_rise

eq$speciation[[5]] <- sp_equi
eq$extinction[[5]] <- ex_equi

dec$speciation[[5]] <- sp_decl
dec$extinction[[5]] <- ex_decl


#Felidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Felidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[7]] <- sp_rise
rise$extinction[[7]] <- ex_rise

eq$speciation[[7]] <- sp_equi
eq$extinction[[7]] <- ex_equi

dec$speciation[[7]] <- sp_decl
dec$extinction[[7]] <- ex_decl


#Felidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Felidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[8]] <- sp_rise
rise$extinction[[8]] <- ex_rise

eq$speciation[[8]] <- sp_equi
eq$extinction[[8]] <- ex_equi

dec$speciation[[8]] <- sp_decl
dec$extinction[[8]] <- ex_decl


#Herpestidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Herpestidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[9]] <- sp_rise
rise$extinction[[9]] <- ex_rise

eq$speciation[[9]] <- sp_equi
eq$extinction[[9]] <- ex_equi

dec$speciation[[9]] <- sp_decl
dec$extinction[[9]] <- ex_decl


#Hyaenidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Hyaenidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[10]] <- sp_rise
rise$extinction[[10]] <- ex_rise

eq$speciation[[10]] <- sp_equi
eq$extinction[[10]] <- ex_equi

dec$speciation[[10]] <- sp_decl
dec$extinction[[10]] <- ex_decl


#Mephitidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Mephitidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[11]] <- sp_rise
rise$extinction[[11]] <- ex_rise

eq$speciation[[11]] <- sp_equi
eq$extinction[[11]] <- ex_equi

dec$speciation[[11]] <- sp_decl
dec$extinction[[11]] <- ex_decl


#Mustelidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Mustelidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[12]] <- sp_rise
rise$extinction[[12]] <- ex_rise

eq$speciation[[12]] <- sp_equi
eq$extinction[[12]] <- ex_equi

dec$speciation[[12]] <- sp_decl
dec$extinction[[12]] <- ex_decl


#Mustelidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Mustelidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[13]] <- sp_rise
rise$extinction[[13]] <- ex_rise

eq$speciation[[13]] <- sp_equi
eq$extinction[[13]] <- ex_equi

dec$speciation[[13]] <- sp_decl
dec$extinction[[13]] <- ex_decl


#Nimravidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Nimravidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[14]] <- sp_rise
rise$extinction[[14]] <- ex_rise

eq$speciation[[14]] <- sp_equi
eq$extinction[[14]] <- ex_equi

dec$speciation[[14]] <- sp_decl
dec$extinction[[14]] <- ex_decl


#Nimravidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Nimravidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[15]] <- sp_rise
rise$extinction[[15]] <- ex_rise

eq$speciation[[15]] <- sp_equi
eq$extinction[[15]] <- ex_equi

dec$speciation[[15]] <- sp_decl
dec$extinction[[15]] <- ex_decl


#Palaeogalidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Palaeogalidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[16]] <- sp_rise
rise$extinction[[16]] <- ex_rise

eq$speciation[[16]] <- sp_equi
eq$extinction[[16]] <- ex_equi

dec$speciation[[16]] <- sp_decl
dec$extinction[[16]] <- ex_decl


#Palaeogalidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Palaeogalidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[17]] <- sp_rise
rise$extinction[[17]] <- ex_rise

eq$speciation[[17]] <- sp_equi
eq$extinction[[17]] <- ex_equi

dec$speciation[[17]] <- sp_decl
dec$extinction[[17]] <- ex_decl


#Percrocutidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Percrocutidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[18]] <- sp_rise
rise$extinction[[18]] <- ex_rise

eq$speciation[[18]] <- sp_equi
eq$extinction[[18]] <- ex_equi

dec$speciation[[18]] <- sp_decl
dec$extinction[[18]] <- ex_decl


#Procyonidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Procyonidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[19]] <- sp_rise
rise$extinction[[19]] <- ex_rise

eq$speciation[[19]] <- sp_equi
eq$extinction[[19]] <- ex_equi

dec$speciation[[19]] <- sp_decl
dec$extinction[[19]] <- ex_decl


#Ursidae_EU
eta(file=here("data", "pyrate_RTT_plots", "Ursidae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[20]] <- sp_rise
rise$extinction[[20]] <- ex_rise

eq$speciation[[20]] <- sp_equi
eq$extinction[[20]] <- ex_equi

dec$speciation[[20]] <- sp_decl
dec$extinction[[20]] <- ex_decl


#Ursidae_NA
eta(file=here("data", "pyrate_RTT_plots", "Ursidae_NA_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[21]] <- sp_rise
rise$extinction[[21]] <- ex_rise

eq$speciation[[21]] <- sp_equi
eq$extinction[[21]] <- ex_equi

dec$speciation[[21]] <- sp_decl
dec$extinction[[21]] <- ex_decl


#Viverridae_EU
eta(file=here("data", "pyrate_RTT_plots", "Viverridae_EU_RTT_plots.R"), cut=0.1)
eta.means()
rise$speciation[[22]] <- sp_rise
rise$extinction[[22]] <- ex_rise

eq$speciation[[22]] <- sp_equi
eq$extinction[[22]] <- ex_equi

dec$speciation[[22]] <- sp_decl
dec$extinction[[22]] <- ex_decl


for(i in 1:length(lineages)){if(is.na(rise[i,1]==T)){rise <- rise[-i,]}}
for(i in 1:length(lineages)){if(is.na(eq[i,1]==T)){eq <- eq[-i,]}}
for(i in 1:length(lineages)){if(is.na(dec[i,1]==T)){dec <- dec[-i,]}}

rise
eq
dec




#linear regression by locality - old (reversed axes) ####

eu_lmrise_0.5 <- lm(rise$extinction~rise$speciation, data=rise, subset=rise$locality=="EU") 
summary(eu_lmrise_0.5)

na_lmrise_0.5 <- lm(rise$extinction~rise$speciation, data=rise, subset=rise$locality=="NA") 
summary(na_lmrise_0.5)





eu_lmeq_0.5 <- lm(eq$extinction~eq$speciation, data=eq, subset=eq$locality=="EU") 
summary(eu_lmeq_0.5)

na_lmeq_0.5 <- lm(eq$extinction~eq$speciation, data=eq, subset=eq$locality=="NA") 
summary(na_lmeq_0.5)





eu_lmdec_0.5 <- lm(dec$extinction~dec$speciation, data=dec, subset=dec$locality=="EU") 
summary(eu_lmdec_0.5)

na_lmdec_0.5 <- lm(dec$extinction~dec$speciation, data=dec, subset=dec$locality=="NA") 
summary(na_lmdec_0.5)





#plotting

mat <- matrix(c(1,3,2,4), nrow=2, ncol=2)
layout(mat, widths=c(1,1))

par(mar=c(5,5,3,3))


#EXPANSION

plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Expansion by locality (cut=0.1)")
abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
abline(a=eu_lmrise_0.5$coefficients[1], b=eu_lmrise_0.5$coefficients[2], lwd=2, col=alpha("#ca8198",0.5))
text(x=0.8, y=0.5, labels="r² = -0.09524", col=alpha("#ca8198",0.8))
abline(a=na_lmrise_0.5$coefficients[1], b=na_lmrise_0.5$coefficients[2], lwd=2, col=alpha("#008f99",0.5))
text(x=0.5, y=0.85, labels="r² = -0.001411", col=alpha("#008f99",0.8))



#EQUILIBRIUM

plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Equilibrium (cut=0.1)")
abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
abline(a=eu_lmeq_0.5$coefficients[1], b=eu_lmeq_0.5$coefficients[2], lwd=2, col=alpha("#ca8198",0.5))
text(x=0.55, y=0.75, labels="r² = 0.8784", col=alpha("#ca8198",0.8))
abline(a=na_lmeq_0.5$coefficients[1], b=na_lmeq_0.5$coefficients[2], lwd=2, col=alpha("#008f99",0.5))
text(x=0.8, y=0.64, labels="r² = 0.8597", col=alpha("#008f99",0.8))


#DECLINE

plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Decline (cut=0.1)")
abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
abline(a=eu_lmdec_0.5$coefficients[1], b=eu_lmdec_0.5$coefficients[2], lwd=2, col=alpha("#ca8198",0.5))
text(x=0.65, y=0.2, labels="r² = 0.09217", col=alpha("#ca8198",0.8))
abline(a=na_lmdec_0.5$coefficients[1], b=na_lmdec_0.5$coefficients[2], lwd=2, col=alpha("#008f99",0.5))
text(x=0.8, y=0.55, labels="r² = 0.686", col=alpha("#008f99",0.8))

#LEGEND
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

legend(
  "bottom",
  col="gray",
  title="",
  legend=c("Bisector line"), 
  horiz=F, 
  lty=2,
  lwd=3,
  xpd=T,
  cex=1.5,
  bty="n",
  xjust=0
)


# spearman correlation ####

rise_eu <- subset(rise, subset=(locality=="EU")) #10 degrees of freedom
rise_na <- subset(rise, subset=(locality=="NA")) #8 degrees of freedom

eu_spearmanrise_0.5 <- cor.test(x=rise_eu$extinction, y=rise_eu$speciation, method="spearman", alternative="two.sided") # rho = 0.1188811, p = 0.7162
na_spearmanrise_0.5 <- cor.test(x=rise_na$extinction, y=rise_na$speciation, method="spearman", alternative="two.sided") # rho = 0.430303, p = 0.218



eq_eu <- subset(eq, subset=(locality=="EU")) #10 degrees of freedom
eq_na <- subset(eq, subset=(locality=="NA")) #8 degrees of freedom

eu_spearmaneq_0.5 <- cor.test(x=eq_eu$extinction, y=eq_eu$speciation, method="spearman", alternative="two.sided") # rho = 0.8881119, p = 9.166e-05
na_spearmaneq_0.5 <- cor.test(x=eq_na$extinction, y=eq_na$speciation, method="spearman", alternative="two.sided") # rho = 0.9272727, p = 0.0001302




dec_eu <- subset(dec, subset=(locality=="EU")) #8 degrees of freedom
dec_na <- subset(dec, subset=(locality=="NA")) #5 degrees of freedom

eu_spearmandec_0.5 <- cor.test(x=dec_eu$extinction, y=dec_eu$speciation, method="spearman", alternative="two.sided") # rho = 0.5636364, p = 0.09579
na_spearmandec_0.5 <- cor.test(x=dec_na$extinction, y=dec_na$speciation, method="spearman", alternative="two.sided") # rho = 0.8928571 , p = 0.0123






#plotting

spearman_coefs <- t(data.frame(eu_rise=eu_spearmanrise_0.5, na_rise=na_spearmanrise_0.5, eu_eq=eu_spearmaneq_0.5, na_eq=na_spearmaneq_0.5, eu_dec=eu_spearmandec_0.5, na_dec=na_spearmandec_0.5))

layout(matrix(c(1,2), ncol=1, nrow=2), width=c(0.8,1), height=c(.8,.2))
par(mar=c(3,4,3,2))


#all data
plot(spearman_coefs,
     main="Spearman correlation",
     ylim=c(0,1),
     bty="l",
     cex=1.4,
     ylab="Spearman coefficients",
     xaxt="n",
     xlab="",
     col=c("#ca8198","#008f99","#ca8198","#008f99","#ca8198","#008f99"),
     pch=21,
     bg=c("#ca8198","#008f99","#ca8198","#008f99","#ca8198","#008f99")
     )
axis(1, at=c(1,2,3,4,5,6), labels=c("Rise_EU", "Rise_NA", "Eq_EU", "Eq_NA", "Dec_EU", "Dec_NA"))
text(x=3, y=0.95, labels="***", cex=1.2)
text(x=4, y=0.98, labels="***", cex=1.2)
text(x=6, y=0.95, labels="*", cex=1.2)

par(mar=c(1,1,0.05,1))
plot(x=NULL, y=NULL, type="n", main="", xlim=c(0,10), ylim=c(0,10), xaxt="n", yaxt="n", bty="n")
legend("center",
       col=c("#ca8198","#008f99","white","white"),
       title="",
       legend=c("Eurasia", "North America", "*     95% significant", "***  99% significant"),
       horiz=F,
       xpd=T,
       pch=c(19,19),
       bty="n",
       pt.cex=1.5,
       xjust=1
       )


#by phase with the points

library(scales)

#rise
par(mar=c(5,5,3,3))
plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Expansion by locality (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.85, y=0.15, labels="rho = 0.1189", col="#ca8198", cex=1.2)
text(x=0.85, y=0.03, labels="rho = 0.4303", col="#008f99", cex=1.2)


#eq
par(mar=c(5,5,3,3))
plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Equilibrium (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.73, y=0.15, labels="rho = 0.8881, p < 0.01", col="#ca8198", cex=1.2)
text(x=0.73, y=0.03, labels="rho = 0.9272, p < 0.01", col="#008f99", cex=1.2)



#dec
plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Decline (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.86, y=0.15, labels="rho = 0.5636", col="#ca8198", cex=1.2)
text(x=0.73, y=0.01, labels="rho = 0.8929, p < 0.05", col="#008f99", cex=1.2)


#par(mar=c(1,1,0.05,1))
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



#



# kendall correlation ####

library(stats)

eu_kendallrise_0.5 <- cor.test(x=rise_eu$extinction, y=rise_eu$speciation, method="kendall", alternative="two.sided") # tau = 0.9090909, p = 0.7373
na_kendallrise_0.5 <- cor.test(x=rise_na$extinction, y=rise_na$speciation, method="kendall", alternative="two.sided") # tau = 0.5555556, p = 0.02861

eu_kendalleq_0.5 <- cor.test(x=eq_eu$extinction, y=eq_eu$speciation, method="kendall", alternative="two.sided") # tau = 0.7878788, p = 0.0001074
na_kendalleq_0.5 <- cor.test(x=eq_na$extinction, y=eq_na$speciation, method="kendall", alternative="two.sided") # tau = 0.7777778, p = 0.0009463

eu_kendalldec_0.5 <- cor.test(x=dec_eu$extinction, y=dec_eu$speciation, method="kendall", alternative="two.sided") # tau = 0.2888889, p = 0.2912
na_kendalldec_0.5 <- cor.test(x=dec_na$extinction, y=dec_na$speciation, method="kendall", alternative="two.sided") # tau = 0.8095238, p = 0.01071




# ploting the data

#rise
par(mar=c(5,5,3,3), mfrow=c(2,2))
plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$status)],
     bg=c("#ca8198","#008f99")[as.factor(rise$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Expansion by locality (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.85, y=0.15, labels="tau = 0.2696", col="#ca8198", cex=1.2)
text(x=0.85, y=0.03, labels="tau = 0.4222", col="#008f99", cex=1.2)


#eq
par(mar=c(5,5,3,3))
plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(eq$status)],
     bg=c("#ca8198","#008f99")[as.factor(eq$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Equilibrium (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.73, y=0.15, labels="tau = 0.7879, p < 0.01", col="#ca8198", cex=1.2)
text(x=0.73, y=0.03, labels="tau = 0.7778, p < 0.01", col="#008f99", cex=1.2)



#dec
plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(dec$status)],
     bg=c("#ca8198","#008f99")[as.factor(dec$locality)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Decline (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.86, y=0.15, labels="tau = 0.2889", col="#ca8198", cex=1.2)
text(x=0.73, y=0.01, labels="tau = 0.8095, p < 0.05", col="#008f99", cex=1.2)


#par(mar=c(1,1,0.05,1))
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








#linear regression by status ####

alive_lmrise_0.5 <- lm(speciation~extinction, data=rise, subset=(status=="extant")) 
summary(alive_lmrise_0.5) #adj r² = -0.08282

dead_lmrise_0.5 <- lm(speciation~extinction, data=rise, subset=(status=="extinct")) 
summary(dead_lmrise_0.5) #adj r² = 0.5765





alive_lmeq_0.5 <- lm(speciation~extinction, data=eq, subset=(status=="extant")) 
summary(alive_lmeq_0.5) #adj r² = 0.8821

dead_lmeq_0.5 <- lm(speciation~extinction, data=eq, subset=(status=="extinct")) 
summary(dead_lmeq_0.5) #adj r² = 0.8998





alive_lmdec_0.5 <- lm(speciation~extinction, data=dec, subset=(status=="extant")) 
summary(alive_lmdec_0.5) #adj r² = 0.05152

dead_lmdec_0.5 <- lm(speciation~extinction, data=dec, subset=(status=="extinct")) 
summary(dead_lmdec_0.5) #adj r² = 0.2168




#plotting the data


mat <- matrix(c(1,3,2,4), nrow=2, ncol=2)
layout(mat, widths=c(1,1))

par(mar=c(5,5,3,3))


#EXPANSION

plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Expansion by status (cut=0.1)")
abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
abline(a=alive_lmrise_0.5$coefficients[1], b=alive_lmrise_0.5$coefficients[2], lwd=2, col=alpha("#68a83b",0.8))
text(x=0.8, y=0.25, labels="r² = -0.08282", col=alpha("#68a83b",1))
abline(a=dead_lmrise_0.5$coefficients[1], b=dead_lmrise_0.5$coefficients[2], lwd=2, col=alpha("#FF007D",0.5))
text(x=0.58, y=0.8, labels="r² = 0.5765", col=alpha("#FF007D",0.8))



#EQUILIBRIUM

plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(eq$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(eq$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Equilibrium by status (cut=0.1)")
abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
abline(a=alive_lmeq_0.5$coefficients[1], b=alive_lmeq_0.5$coefficients[2], lwd=2, col=alpha("#68a83b",0.8))
text(x=0.7, y=0.95, labels="r² = 0.8821", col=alpha("#68a83b",1))
abline(a=dead_lmeq_0.5$coefficients[1], b=dead_lmeq_0.5$coefficients[2], lwd=2, col=alpha("#FF007D",0.5))
text(x=0.8, y=0.6, labels="r² = 0.8998", col=alpha("#FF007D",0.8))


#DECLINE

plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(dec$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(dec$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Decline by status (cut=0.1)")
abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
abline(a=alive_lmdec_0.5$coefficients[1], b=alive_lmdec_0.5$coefficients[2], lwd=2, col=alpha("#68a83b",0.8))
text(x=0.65, y=0.4, labels="r² = 0.05152", col=alpha("#68a83b",1))
abline(a=dead_lmdec_0.5$coefficients[1], b=dead_lmdec_0.5$coefficients[2], lwd=2, col=alpha("#FF007D",0.5))
text(x=0.65, y=0.2, labels="r² = 0.2168", col=alpha("#FF007D",0.8))


#LEGEND
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

legend(
  "bottom",
  col="gray",
  title="",
  legend=c("Bisector line"), 
  horiz=F, 
  lty=2,
  lwd=3,
  xpd=T,
  cex=1.5,
  bty="n",
  xjust=0
)



# spearman regression ####

rise_alive <- subset(rise, subset=(status=="extant"))
rise_dead <- subset(rise, subset=(status=="extinct"))

alive_spearman_rise_0.5 <- cor.test(x=rise_alive$extinction, y=rise_alive$speciation, method="spearman", alternative="two.sided") # rho = -0.1923077, p-value = 0.5292
dead_spearman_rise_0.5 <- cor.test(x=rise_dead$extinction, y=rise_dead$speciation, method="spearman", alternative="two.sided") # rho = 0.7333333, p-value = 0.03112



eq_alive <- subset(eq, subset=(status=="extant"))
eq_dead <- subset(eq, subset=(status=="extinct"))

alive_spearman_eq_0.5 <- cor.test(x=eq_alive$extinction, y=eq_alive$speciation, method="spearman", alternative="two.sided") # rho = 0.8901099, p-value < 2.2e-16
dead_spearman_eq_0.5 <- cor.test(x=eq_dead$extinction, y=eq_dead$speciation, method="spearman", alternative="two.sided") # rho = 0.9333333, p-value = 0.0007496



dec_alive <- subset(dec, subset=(status=="extant"))
dec_dead <- subset(dec, subset=(status=="extinct"))

alive_spearman_dec_0.5 <- cor.test(x=dec_alive$extinction, y=dec_alive$speciation, method="spearman", alternative="two.sided") # rho = 0.2857143,  p-value = 0.5008
dead_spearman_dec_0.5 <- cor.test(x=dec_dead$extinction, y=dec_dead$speciation, method="spearman", alternative="two.sided") # rho = 0.75, p-value = 0.02549 




# plotting the data #


par(mfrow=c(2,2))

#rise
par(mar=c(5,5,3,3))
plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Expansion by status (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.80, y=0.15, labels="rho = -0.1923", col=alpha("#68a83b",2), cex=1.2)
text(x=0.7, y=0.03, labels="rho = 0.7333, p < 0.05", col="#FF007D", cex=1.2)


#eq
par(mar=c(5,5,3,3))
plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Equilibrium (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.73, y=0.15, labels="rho = 0.2857, p < 0.01", col="#68a83b", cex=1.2)
text(x=0.73, y=0.03, labels="rho = 0.9333, p < 0.01", col="#FF007D", cex=1.2)



#dec
plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Decline (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.86, y=0.15, labels="rho = 0.5636", col="#68a83b", cex=1.2)
text(x=0.73, y=0.01, labels="rho = 0.75, p < 0.05", col="#FF007D", cex=1.2)


#par(mar=c(1,1,0.05,1))
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









# kendall regression ####


rise_alive <- subset(rise, subset=(status=="extant"))
rise_dead <- subset(rise, subset=(status=="extinct"))

alive_kendall_rise_0.5 <- cor.test(x=rise_alive$extinction, y=rise_alive$speciation, method="kendall", alternative="two.sided") # tau = -0.1025641, p-value = 0.6754
dead_kendall_rise_0.5 <- cor.test(x=rise_dead$extinction, y=rise_dead$speciation, method="kendall", alternative="two.sided") # tau = 0.6111111, p-value = 0.02474



eq_alive <- subset(eq, subset=(status=="extant"))
eq_dead <- subset(eq, subset=(status=="extinct"))

alive_kendall_eq_0.5 <- cor.test(x=eq_alive$extinction, y=eq_alive$speciation, method="kendall", alternative="two.sided") # tau = 0.7435897 , p-value = 0.0001453
dead_kendall_eq_0.5 <- cor.test(x=eq_dead$extinction, y=eq_dead$speciation, method="kendall", alternative="two.sided") # tau = 0.8333333 , p-value = 0.0008543



dec_alive <- subset(dec, subset=(status=="extant"))
dec_dead <- subset(dec, subset=(status=="extinct"))

alive_kendall_dec_0.5 <- cor.test(x=dec_alive$extinction, y=dec_alive$speciation, method="kendall", alternative="two.sided") # tau = 0.2142857 ,  p-value = 0.5484
dead_kendall_dec_0.5 <- cor.test(x=dec_dead$extinction, y=dec_dead$speciation, method="kendall", alternative="two.sided") # tau = 0.5555556 , p-value = 0.04462 



# plotting the data #


par(mfrow=c(2,2))

#rise
par(mar=c(5,5,3,3))
plot(x=rise$extinction,
     y=rise$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Expansion by status (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.80, y=0.15, labels="tau = -0.1026", col=alpha("#68a83b",2), cex=1.2)
text(x=0.7, y=0.03, labels="tau = 0.6111, p < 0.05", col="#FF007D", cex=1.2)


#eq
par(mar=c(5,5,3,3))
plot(x=eq$extinction,
     y=eq$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Equilibrium (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.73, y=0.15, labels="tau = 0.7436, p < 0.01", col="#68a83b", cex=1.2)
text(x=0.73, y=0.03, labels="tau = 0.8333, p < 0.01", col="#FF007D", cex=1.2)



#dec
plot(x=dec$extinction,
     y=dec$speciation,
     bty="l",
     cex=1.5,
     col="black",
     pch=c(21,22)[as.factor(rise$locality)],
     bg=c("#68a83b","#FF007D")[as.factor(rise$status)],
     xlab="Extinction rates",
     xlim=c(0,1),
     ylab="Speciation rates",
     ylim=c(0,1),
     main="Decline (cut=0.1)")
#abline(a=0, b=1, lwd=2, col=alpha("black",0.3), lty=2)
text(x=0.86, y=0.15, labels="tau = 0.2143", col="#68a83b", cex=1.2)
text(x=0.73, y=0.01, labels="tau = 0.5555, p < 0.05", col="#FF007D", cex=1.2)


#par(mar=c(1,1,0.05,1))
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



