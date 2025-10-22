library(here)

source(here("R","eta","00_eta_function.R"))

#############
# cut = 0.1, two = T

pdf(here("output","images","eta_example_01T.pdf"), width=8.3, height=5.8)

eta(here("R","images_scripts","example_diversification.r"), cut=0.1, two=T)

dev.off()

#############
# cut = 0.9, two = T

pdf(here("output","images","eta_example_09T.pdf"), width=8.3, height=5.8)

eta(here("R","images_scripts","example_diversification.r"), cut=0.9, two=T)

dev.off()

#############
# cut = 0.1, two = F

pdf(here("output","images","eta_example_01F.pdf"), width=8.3, height=5.8)

eta(here("R","images_scripts","example_diversification.r"), cut=0.1, two=F)

dev.off()

#############
# cut = 0.9, two = F

pdf(here("output","images","eta_example_09F.pdf"), width=8.3, height=5.8)

eta(here("R","images_scripts","example_diversification.r"), cut=0.9, two=F)

dev.off()


############
# Now we have four images that will be edited in Inkscape to compose Fig. 2.