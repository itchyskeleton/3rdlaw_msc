###########################################
# MAKING IMAGE FOR INTODUCTION (BOXPLOTS) #
###########################################

library(here)

# Let's load the pyrate output files.

load(here("data","processed","img-intro.RData"))

# Now let's load data from other works.

##################################

## 1. Sutherland - Actinopterygii

sutherland2025 <- read.table(file=here(
  "data",
  "pyrate",
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

## 3. Bravo - Phorusrhacidae

bravo <- data.frame(
  avg=c(0.7432,1.2378,1.7743),
  earlymio=c(0.8557,1.8063,2.9346),
  latemio=c(0.3270,1.7103,3.5112),
  earlyplio=c(0.3464,1.8163,3.7562),
  lateoligo=c(0.0279,0.6636,1.6459)
)

# Let's extract means from that

bravo_q <- c(
  mean(bravo$avg),
  mean(bravo$earlymio),
  mean(bravo$latemio),
  mean(bravo$earlyplio),
  mean(bravo$lateoligo)
)

##############################

# 4. Guinot 2023 - Elasmobranchii

#sharks

guinot1 <- data.frame(
  premaas = c(0.3306,0.2485,0.4229),
  maas = c(0.7188,0.4833,0.9822),
  palaeo = c(0.3121,0.1819, 0.4528)
)

guinot1_q <- c(
  mean(guinot1$premaas),
  mean(guinot1$maas),
  mean(guinot1$palaeo)
)

#skates and rays

guinot2 <- data.frame(
  premaas = c(0.3134,0.1906,0.4487),
  maas = c(0.9217,0.6291,1.2652),
  palaeo = c(0.1453,0.5731,0.3334)
)

guinot2_q <- c(
  mean(guinot2$premaas),
  mean(guinot2$maas),
  mean(guinot2$palaeo)
)

##############################

# 5. Jouault 2024 - crown ants

jouault2024_crown <- read.table(file=here(
  "data","pyrate",
  "other_work","jouault2024",
  "crownants_1_RJMCMC-26_Grj_mcmc.log"
), header=T
)

# a. How many preservation bins are there?

length(grep("q_",colnames(jouault2024_crown))) #30

# b. Distribution of mean preservation rates

jc2024_q <- c(
  mean(jouault2024_crown$q_0),
  mean(jouault2024_crown$q_1),
  mean(jouault2024_crown$q_2),
  mean(jouault2024_crown$q_3),
  mean(jouault2024_crown$q_4),
  mean(jouault2024_crown$q_5),
  mean(jouault2024_crown$q_6),
  mean(jouault2024_crown$q_7),
  mean(jouault2024_crown$q_8),
  mean(jouault2024_crown$q_9),
  mean(jouault2024_crown$q_10),
  mean(jouault2024_crown$q_11),
  mean(jouault2024_crown$q_12),
  mean(jouault2024_crown$q_13),
  mean(jouault2024_crown$q_14),
  mean(jouault2024_crown$q_15),
  mean(jouault2024_crown$q_16),
  mean(jouault2024_crown$q_17),
  mean(jouault2024_crown$q_18),
  mean(jouault2024_crown$q_19),
  mean(jouault2024_crown$q_20),
  mean(jouault2024_crown$q_21),
  mean(jouault2024_crown$q_22),
  mean(jouault2024_crown$q_23),
  mean(jouault2024_crown$q_24),
  mean(jouault2024_crown$q_25),
  mean(jouault2024_crown$q_26),
  mean(jouault2024_crown$q_27),
  mean(jouault2024_crown$q_28),
  mean(jouault2024_crown$q_29)
)

# c. The outliers are making it hard to visualize, so we'll remove them.

jc2024_q <- jc2024_q[!jc2024_q %in% boxplot.stats(jc2024_q)$out]

##############################

# 5. Jouault 2024 - stem ants

jouault2024_stem <- read.table(file=here(
  "data","pyrate",
  "other_work","jouault2024",
  "stemants_1_RJMCMC-27_Grj_mcmc.log"
), header=T
)

# a. How many preservation bins are there?

length(grep("q_",colnames(jouault2024_stem))) #6

# b. Distribution of mean preservation rates

js2024_q <- c(
  mean(jouault2024_stem$q_0),
  mean(jouault2024_stem$q_1),
  mean(jouault2024_stem$q_2),
  mean(jouault2024_stem$q_3),
  mean(jouault2024_stem$q_4),
  mean(jouault2024_stem$q_5)
)



##############################

# 6. Let's plot everyone together for the img:

library("RColorBrewer")
library("scales")
library("rlist")

a <- brewer.pal(8, "Set2")

b <- list.reverse(seq(1:25))

png(filename=here("output","images","boxplot_introduction.png"), 
    width=700, height=900, units="px")

par(mar=c(5,5,3,3))

boxplot(sutherland_q,
        jouault_q,
        bravo_q,
        guinot1_q,
        guinot2_q,
        jc2024_q,
        js2024_q,
        amph_eu$mean_q,
        amph_na$mean_q,
        cani_eu$mean_q,
        cani_na$mean_q,
        feli_ea$mean_q,
        feli_na$mean_q,
        herp_eu$mean_q,
        hyae_eu$mean_q,
        meph_na$mean_q,
        must_eu$mean_q,
        must_na$mean_q,
        nimr_eu$mean_q,
        nimr_na$mean_q,
        perc_eu$mean_q,
        proc_na$mean_q,
        ursi_eu$mean_q,
        ursi_na$mean_q,
        vive_ea$mean_q,
        main="Preservation rates",
        yaxt="n", ylab="Organisms", 
        xlab="Preservation rate (lineage/Myr)",
        col=c(a[1], a[2], a[4], rep(a[5],2), rep(a[6],2), rep(a[3], 18)),
        horizontal=T,
        cex.main=2,
        cex.axis=1.5,
        cex.lab=1.5
)
axis(side=2, at=1:25, labels=b, las=1, cex.axis=1.5)
#text(5.5,8,labels="PLACEHOLDER", col=alpha("red", 0.5), cex=5)

dev.off()

