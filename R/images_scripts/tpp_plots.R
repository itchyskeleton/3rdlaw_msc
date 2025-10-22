####################################################
# Plotting the occurrences for TPP PyRate analyses #
####################################################

library(here)

load(here("data", "occs_for_pyrate", "functions.RData"))

##### Amphicyonidae_EU ####

data <- read.table(here("data", "occs_for_pyrate", "amph_eu", "Amphicyonidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "amph_eu", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","amph_eu","amph_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Barbourofelidade_EU ####

data <- read.table(here("data", "occs_for_pyrate", "barb_eu", "Barbourofelidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "barb_eu", "epochs_modelo_2.txt"))

png(filename=here("data","occs_for_pyrate","barb_eu","barb_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Canidae_EU ####

data <- read.table(here("data", "occs_for_pyrate", "cani_eu", "Canidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "cani_eu", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","cani_eu","cani_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Felidae_EU ####

data <- read.table(here("data", "occs_for_pyrate", "feli_eu", "Felidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "feli_eu", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","feli_eu","feli_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Herpestidae_EU ####

data <- read.table(here("data", "occs_for_pyrate", "herp_eu", "Herpestidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "herp_eu", "epochs_modelo_3.txt"))

png(filename=here("data","occs_for_pyrate","herp_eu","herp_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Hyaenidae_EU ####

data <- read.table(here("data", "occs_for_pyrate", "hyae_eu", "Hyaenidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "hyae_eu", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","hyae_eu","hyae_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Mustelidae_EU ####

data <- read.table(here("data", "occs_for_pyrate", "must_eu", "Mustelidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "must_eu", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","must_eu","must_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Ursidae_EU ####

data <- read.table(here("data", "occs_for_pyrate", "ursi_eu", "Ursidae_eurasia_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "ursi_eu", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","ursi_eu","ursi_eu.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()



##### Amphicyonidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "amph_na", "Amphicyonidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "amph_na", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","amph_na","amph_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Canidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "cani_na", "Canidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "cani_na", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","cani_na","cani_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Felidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "feli_na", "Felidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "feli_na", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","feli_na","feli_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Mephitidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "meph_na", "Mephitidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "meph_na", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","meph_na","meph_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Mustelidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "must_na", "Mustelidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "must_na", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","must_na","must_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Nimravidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "nimr_na", "Nimravidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "nimr_na", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","nimr_na","nimr_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Palaeogalidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "pala_na", "Palaeogalidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "pala_na", "epochs_modelo_3.txt"))

png(filename=here("data","occs_for_pyrate","pala_na","pala_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Procyonidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "proc_na", "Procyonidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "proc_na", "epochs_modelo_2.txt"))

png(filename=here("data","occs_for_pyrate","proc_na","proc_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()

##### Ursidae_NAm ####

data <- read.table(here("data", "occs_for_pyrate", "ursi_na", "Ursidae_N_america_data_final_now_&_pbdb.txt"), header=T)
intervals <- scan(here("data", "occs_for_pyrate", "ursi_na", "epochs_carnivora_modelo_1.txt"))

png(filename=here("data","occs_for_pyrate","ursi_na","ursi_na.png"), width=1000, height=720, pointsize=25)
TPP.visualization(data, intervals, plot.TPP=T)
dev.off()
