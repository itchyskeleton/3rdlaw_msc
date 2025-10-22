#########################################################################################################
# This script generates pdf files with the plot output of the eta analyses.
# It allows us to visualize which sections of the clade's diversification dynamics belong to each window.
#########################################################################################################

files <- list.files(here("data", "pyrate_analyses"))

files_eu <- files[c(1,3,5,7,9,10,12,14,16,18,20,22)]
files_nam <- files[c(2,4,6,8,11,13,15,17,19,21)]

source(here("R", "eta", "00_eta_function.R"))

##########
# EUROPE #
##########

# 1. Two thresholds

library(here)
library(shiny)

matriz <- matrix(seq(1, 12), nrow=4, byrow=T)
layout(matriz)

eta(file=here("data", "pyrate_analyses", files[1]), cut=0.5, two=T)

