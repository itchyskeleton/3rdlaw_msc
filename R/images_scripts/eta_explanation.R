library(here)

source(here("R","eta","00_eta_function.R"))

#############
# cut = 0.1, two = T

eta(here("R","images_scripts","example_diversification.r"), cut=0.1, two=T,
    savePlot=T, path=here("output", "images", "eta_example_012t.pdf"))


#############
# cut = 0.9, two = T

eta(here("R","images_scripts","example_diversification.r"), cut=0.9, two=T,
    savePlot=T, path=here("output", "images", "eta_example_092t.pdf"))

#############
# cut = 0.1, two = F

eta(here("R","images_scripts","example_diversification.r"), cut=0.1, two=F,
    savePlot=T, path=here("output", "images", "eta_example_011t.pdf"))

#############
# cut = 0.9, two = F

eta(here("R","images_scripts","example_diversification.r"), cut=0.9, two=F,
    savePlot=T, path=here("output", "images", "eta_example_091t.pdf"))


############
# Now we have four images that will be edited in Inkscape to compose Fig. 2.