###########################################
# MAKING IMAGE FOR INTODUCTION (BOXPLOTS) #
###########################################

library(here)

# Let's load the pyrate output files.

## Amph_EA

amph_eu <- read.table(file=here(
  "data",
  "pyrate", "output", "mcmc_logs",
  "Amphicyonidae_EU_combined_50mcmc_mcmc.log"), 
  sep="\t", header=T)

##################################

## Amph_NAm

amph_na <- read.table(file=here(
  "data",
  "pyrate", "output", "mcmc_logs",
  "Amphicyonidae_NAm_combined_50mcmc_mcmc.log"), 
  sep="\t", header=T)

##################################

## Canidae_EA

cani_eu <- read.table(file=here(
  "data",
  "pyrate", "output", "mcmc_logs",
  "Canidae_EU_combined_50mcmc_mcmc.log"), 
  sep="\t", header=T)

##################################

## Canidae_NAm

cani_na <- read.table(file=here(
  "data",
  "pyrate", "output", "mcmc_logs",
  "Canidae_NAm_combined_50mcmc_mcmc.log"), 
  sep="\t", header=T)

##################################

## Felidae_EA

feli_ea <- read.table(file=here(
  "data",
  "pyrate", "output", "mcmc_logs",
  "Felidae_EU_combined_50mcmc_mcmc.log"), 
  sep="\t", header=T)

##################################

## Felidae_NA

feli_na <- read.table(file=here(
  "data",
  "pyrate", "output", "mcmc_logs",
  "Felidae_NAm_combined_50mcmc_mcmc.log"), 
  sep="\t", header=T)

##################################

## Herpestidae_EA

herp_eu <- read.table(file=here(
  "data",
  "pyrate", "output", "mcmc_logs",
  "Herpestidae_EU_combined_50_mcmc.log"), 
  sep="\t", header=T)

##################################

## Viverridade_EA

vive_ea <- read.table(
  file=here("data","pyrate","output","mcmc_logs",
            "Viverridae_EU_combined_50_mcmc.log"),
  sep="\t", header=T
)

##################################

## 1. Sutherland - Actinopterygii

sutherland2025 <- read.table(file=here(
  "data",
  "pyrate",
  "output",
  "other_work",
  "sutherland_glo_all_sp_10_mcmc.log"), 
  sep="\t", header=T)

# a. How many preservation bins are there?

length(grep("q_",colnames(sutherland2025))) #12

# b. Distribution of mean preservation rates

sutherland_q <- c(
  mean(sutherland2025$q_0),
  mean(sutherland2025$q_1),
  mean(sutherland2025$q_2),
  mean(sutherland2025$q_3),
  mean(sutherland2025$q_4),
  mean(sutherland2025$q_5),
  mean(sutherland2025$q_6),
  mean(sutherland2025$q_7),
  mean(sutherland2025$q_8),
  mean(sutherland2025$q_9),
  mean(sutherland2025$q_10),
  mean(sutherland2025$q_11)
)

##############################

## 2. Jouault 2025 - Hymenoptera

jouault <- read.table(file=here(
  "data",
  "pyrate",
  "output",
  "other_work",
  "jouault_Genus_6_RJMCMC-1_Grj_mcmc.log"), 
  sep="\t", header=T)

# a. How many preservation bins are there?

length(grep("q_",colnames(jouault))) #65

# b. Distribution of mean preservation rates

jouault_q <- c(
  mean(jouault$q_0),
  mean(jouault$q_1),
  mean(jouault$q_2),
  mean(jouault$q_3),
  mean(jouault$q_4),
  mean(jouault$q_5),
  mean(jouault$q_6),
  mean(jouault$q_7),
  mean(jouault$q_8),
  mean(jouault$q_9),
  mean(jouault$q_10),
  mean(jouault$q_11),
  mean(jouault$q_12),
  mean(jouault$q_13),
  mean(jouault$q_14),
  mean(jouault$q_15),
  mean(jouault$q_16),
  mean(jouault$q_17),
  mean(jouault$q_18),
  mean(jouault$q_19),
  mean(jouault$q_20),
  mean(jouault$q_21),
  mean(jouault$q_22),
  mean(jouault$q_23),
  mean(jouault$q_24),
  mean(jouault$q_25),
  mean(jouault$q_26),
  mean(jouault$q_27),
  mean(jouault$q_28),
  mean(jouault$q_29),
  mean(jouault$q_30),
  mean(jouault$q_31),
  mean(jouault$q_32),
  mean(jouault$q_33),
  mean(jouault$q_34),
  mean(jouault$q_35),
  mean(jouault$q_36),
  mean(jouault$q_37),
  mean(jouault$q_38),
  mean(jouault$q_39),
  mean(jouault$q_40),
  mean(jouault$q_41),
  mean(jouault$q_42),
  mean(jouault$q_43),
  mean(jouault$q_44),
  mean(jouault$q_45),
  mean(jouault$q_46),
  mean(jouault$q_47),
  mean(jouault$q_48),
  mean(jouault$q_49),
  mean(jouault$q_50),
  mean(jouault$q_51),
  mean(jouault$q_52),
  mean(jouault$q_53),
  mean(jouault$q_54),
  mean(jouault$q_55),
  mean(jouault$q_56),
  mean(jouault$q_57),
  mean(jouault$q_58),
  mean(jouault$q_59),
  mean(jouault$q_60),
  mean(jouault$q_61),
  mean(jouault$q_62),
  mean(jouault$q_63),
  mean(jouault$q_64)
)

# One of the values is bigger than the others

which(jouault_q==max(jouault_q)) #it's 48. Let's remove it

jouault_q <- jouault_q[-48]

##############################

## 3. Guo - Echinodermata

guo_echi <- read.table(file=here(
  "data",
  "pyrate",
  "output",
  "other_work",
  "guo_Echinodermata_mcmcdiv.log"), 
  sep="\t", header=T)

# a. How many preservation bins are there?

length(grep("q_",colnames(guo_echi))) #1

##############################

## 3. Guo - Brachiopoda

guo_brachi <- read.table(file=here(
  "data",
  "pyrate",
  "output",
  "other_work",
  "guo_Brachiopoda_mcmcdiv.log"), 
  sep="\t", header=T)

# a. How many preservation bins are there?

length(grep("q_",colnames(guo_echi))) #1

##############################

# X. Let's plot everyone together for the img:

library("RColorBrewer")
library("scales")

a <- brewer.pal(7, "Set2")

works <- c("Actinopterygii (Sutherland 2025)",
           "Amphicyonidae_EA (this work)",
           "Amphicyonidae_NAm (this work)",
           "Canidae_EA (this work)",
           "Canidae_NAm (this work)",
           "Felidae_EA (this work)",
           "Felidae_NAm (this work)",
           "Herpestidae_EU (this work)",
           "Viverridae_EU (this work)")

png(filename=here("text","images","boxplot_introduction.png"), 
    width=640, height=480, units="px")

boxplot(sutherland_q,
        jouault_q,
        amph_eu$mean_q,
        amph_na$mean_q,
        cani_eu$mean_q,
        cani_na$mean_q,
        feli_ea$mean_q,
        feli_na$mean_q,
        herp_eu$mean_q,
        vive_ea$mean_q,
        main="Preservation rates",
        xaxt="n", xlab="Organisms", 
        ylab="Preservation rate (lineage/Myr)",
        col=c(a[1], a[2], rep(a[3], 8))
        )
axis(side=1, at=1:12, labels=seq(1:12))
text(5.5,8,labels="PLACEHOLDER", col=alpha("red", 0.5), cex=5)

dev.off()






##############################
# Let's find out which bin has the highest preservation in each work

# 1. Sutherland

## a. How many preservation bins are there?

length(grep("q_",colnames(sutherland2025))) #12

## b. Now to visualize them:

boxplot(sutherland2025$q_0, sutherland2025$q_1, sutherland2025$q_2, 
        sutherland2025$q_3, sutherland2025$q_4, sutherland2025$q_5, 
        sutherland2025$q_6, sutherland2025$q_7, sutherland2025$q_8, 
        sutherland2025$q_9, sutherland2025$q_10, sutherland2025$q_11, 
        main="Sutherland 2025 preservation rates", xaxt="n", 
        xlab="Bins", ylab="Preservation")
axis(side=1, at=1:12, 
     labels=c(
       "q_0", "q_1", "q_2", "q_3", "q_4", "q_5", "q_6", "q_7", "q_8",
       "q_9", "q_10", "q_11")
     )
# Clearly the highest preservation rate is in q_6, and the worst is q_8


#########

# 2. Mine

## a. How many preservation bins are there?

length(grep("q_", colnames(mine))) #5

## b. Now to visualize them:

boxplot(mine$q_0, mine$q_1, mine$q_2, mine$q_3, mine$q_4,
        main="My preservation rates", xaxt="n", xlab="Bins",
        ylab="Preservation")
axis(side=1, at=1:5, labels=c("q_0","q_1","q_2","q_3","q_4"))
#The highest one is q_4, and the worst is q_3



############

# X. Let's plot everyone together for the img:

library("RColorBrewer")

a <- brewer.pal(7, "Set2")

works <- c(
  "Actinopterygii (Sutherland 2025)",
  "Amphicyonidae_EA (this work)",
  "Amphicyonidae_NAm (this work)",
  "Canidae_EA (this work)",
  "Canidae_NAm (this work)",
  "Felidae_EA (this work)",
  "Felidae_NAm (this work)",
  "Herpestidae_EU (this work)",
  "Viverridae_EU (this work)"
  )

boxplot(sutherland2025$q_8, sutherland2025$q_6, mine$q_3, mine$q_4, main="Preservation rates",
        xaxt="n", xlab="Organisms", ylab="Preservation rate (lineage/Myr)",
        col=c(a[1], a[1], a[4], a[4]))
axis(side=1, at=1:4, labels=works)

