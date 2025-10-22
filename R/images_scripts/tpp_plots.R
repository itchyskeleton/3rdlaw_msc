####################################################
# Plotting the occurrences for TPP PyRate analyses #
####################################################

library(here)

load(here("data", "occs", "functions.RData"))

##### Amphicyonidae_EU ####

data <- read.table(here("data", "occs", "amph_eu", 
                        "Amphicyonidae_eurasia_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "amph_eu", "epochs.txt"))

png(filename=here("output","images","tpp_plots","amph_eu.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Canidae_EU ####

data <- read.table(here("data", "occs", "cani_eu", 
                        "Canidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs", "cani_eu", "epochs.txt"))

png(filename=here("output","images","tpp_plots","cani_eu.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Felidae_EU ####

data <- read.table(here("data", "occs", "feli_eu", 
                        "Felidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs", "feli_eu", "epochs.txt"))

png(filename=here("output","images","tpp_plots","feli_eu.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Herpestidae_EU ####

data <- read.table(here("data", "occs", "herp_eu", 
                        "Herpestidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs", "herp_eu", "epochs.txt"))

png(filename=here("output","images","tpp_plots","herp_eu.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Hyaenidae_EU ####

data <- read.table(here("data", "occs", "hyae_eu", 
                        "Hyaenidae_eurasia_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "hyae_eu", "epochs.txt"))

png(filename=here("output","images","tpp_plots","hyae_eu.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Mustelidae_EU ####

data <- read.table(here("data", "occs", "must_eu", 
                        "Mustelidae_eurasia_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "must_eu", "epochs.txt"))

png(filename=here("output","images","tpp_plots","must_eu.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Ursidae_EU ####

data <- read.table(here("data", "occs", "ursi_eu", 
                        "Ursidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs", "ursi_eu", "epochs.txt"))

png(filename=here("output","images","tpp_plots","ursi_eu.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()



##### Amphicyonidae_NAm ####

data <- read.table(here("data", "occs", "amph_na", 
                        "Amphicyonidae_N_america_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "amph_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","amph_na.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Canidae_NAm ####

data <- read.table(here("data", "occs", "cani_na", 
                        "Canidae_N_america_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "cani_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","cani_na.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Felidae_NAm ####

data <- read.table(here("data", "occs", "feli_na", 
                        "Felidae_N_america_data_final_now_&_pbdb.txt"),
                   header=T)
intervals <- scan(here("data", "occs", "feli_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","feli_na.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Mephitidae_NAm ####

data <- read.table(here("data", "occs", "meph_na", 
                        "Mephitidae_N_america_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "meph_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","meph_na.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Mustelidae_NAm ####

data <- read.table(here("data", "occs", "must_na", 
                        "Mustelidae_N_america_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "must_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","must_na.png"),
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Nimravidae_NAm ####

data <- read.table(here("data", "occs", "nimr_na", 
                        "Nimravidae_N_america_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "nimr_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","nimr_na.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Procyonidae_NAm ####

data <- read.table(here("data", "occs", "proc_na", 
                        "Procyonidae_N_america_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "proc_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","proc_na.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Ursidae_NAm ####

data <- read.table(here("data", "occs", "ursi_na", 
                        "Ursidae_N_america_data_final_now_&_pbdb.txt"), 
                   header=T)
intervals <- scan(here("data", "occs", "ursi_na", "epochs.txt"))

png(filename=here("output","images","tpp_plots","ursi_na.png"), 
    width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()
