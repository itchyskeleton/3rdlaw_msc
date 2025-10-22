library(here)
library(scales)
library(RecordLinkage)
library(LaplacesDemon)
library(TeachingDemos)
library(DescTools)
library(tidyr)
library(geosphere)
library(fitdistrplus)
library(plyr)
library(data.table)

# Load the functions needed for this script

load(here("R", "occs_data_prep", "needed_functions.RData"))
#Thank you Matheus Januario for those functions!


# Read the pbdb and now occurrences tables. 
# This is obtained by downloading the occurrence tables from the websites,
# then filtering the columns until you have only the ones that interest us
# (which are Species, MaxT, MinT, lng, lat, bed_info, and family)
# and then saving as .txt.

pbdb <- read.table(here("R", "occs_data_prep", "pbdb_for_analysis.txt"), 
                   h=T, 
                   sep = "")

now <- read.table(here("R", "occs_data_prep", "now_for_analysis.txt"), 
                  h=T, 
                  sep = "")


# Create a new column to sort the occurrences by site:
pbdb <- search.site(data = pbdb)
now <- search.site(data = now)


# A little correction for the sites in the NOW database:
now$Site <- now$Site+max(pbdb$Site)



###############################################################################

# Dealing with occurrence resolution

# Looking at our data, we can see that it has much variation in time resolution, 
# that is, the timespan between each occurrence for a species.
# That can mean uncertainty in the data,
# because a species hardly has such longevity (i.e., 10Myr).

# So we're going to remove that.

###############################################################################

# Let's plot the frequencies of lifespans in our data:
resolution <- pbdb$MaxT-pbdb$MinT

hist(resolution, 
     xlab="resolution", 
     main="Carnivora filtering based on resolution - PBDB", 
     col="red")


# Lets remove low resolution occurrences. 
# To do this, we will calculate the midpoints of eachoccurrence
# and base their max resolution accepted on this

pbdb <- pbdb[-which(
  pbdb$MinT + ((pbdb$MaxT-pbdb$MinT)/2)>=23 & #Removing occs from Paleogene 
    (pbdb$MaxT-pbdb$MinT)>10),] #and with a resolution worse than 10my



pbdb <- pbdb[-which(
  pbdb$MinT + ((pbdb$MaxT-pbdb$MinT)/2)<23 & #Removing occs from Neogene and
    (pbdb$MaxT-pbdb$MinT)>6),] #with a resolution worse than 5my


# Now our resolution improved:
hist(pbdb$MaxT-pbdb$MinT, 
     xlab="resolution", 
     add=T, 
     breaks = 9, 
     fill="white")

legend("topright", 
       inset=.02, 
       title="Type of occurrence after filtering",
       c("Maintained","Removed"), 
       fill=c("white", "red"), 
       horiz=F, 
       cex=0.8)


length(unique(pbdb$Species))




######## Now let's remove high resolution occs only from NOW.


# Let's plot the frequencies of lifespans in our data:

resolution <- now$MaxT-now$MinT
hist(resolution, 
     xlab="resolution", 
     main="Carnivora filtering based on resolution - NOW ", 
     col="red")


# Lets remove low resolution occurrences. 
# To do this, we will calculate the midpoints of eachoccurrence
# and base their max resolution accepted on this

now <- now[-which(
  now$MinT + ((now$MaxT-now$MinT)/2)>=23 & #Removing occs from Paleogene and
    (now$MaxT-now$MinT)>6),] #with a resolution worse than 10my


now <- now[-which(
  now$MinT + ((now$MaxT-now$MinT)/2)<23 & #Removing occs from Neogene and
    (now$MaxT-now$MinT)>6),] #with a resolution worse than 5my


# Now our resolution improved:
hist(now$MaxT-now$MinT, 
     xlab="resolution", 
     add=T, 
     breaks = 9, 
     fill="white")
legend("topright", 
       inset=.02, 
       title="Type of occurrence after filtering",
       c("Maintained","Removed"), 
       fill=c("white", "red"), 
       horiz=F, 
       cex=0.8)



#######################################################################
# Now let's separate by lineage.
#######################################################################



pbdb <- data.frame(pbdb[pbdb$FAMILY == c("LINEAGE NAME HERE"),])

now <-data.frame(now[now$FAMILY == c("LINEAGE NAME HERE"),])



pbdb$FAMILY = NULL
now$FAMILY = NULL






###############################################################################
# Now let's find and remove double occurrences.

# Double occurrences are fossil occurrences that are artificially duplicated 
# in fossil occurrence datasets - in contrast with “true replicas” , 
# which are occurrences of the same species that correspond 
# to independent fossil occurrences of a same fossil lineage. 

###############################################################################


# Let's apply the function to find double occurrences

PR <- find.pseudoreplicas(
  dtst1 = pbdb, 
  dtst2 = now, 
  lat_threshold = 1, 
  long_threshold = 1, 
  time_threshold = 6, 
  print_progress = T
  )


# Removing only double occurrences

removed_psedoreps <- data.frame(
  Species=unlist(lapply(PR, function(x) x[1,"Species"])),
  MaxT=unlist(lapply(PR, function(x) x[1,"MaxT"])),
  MinT=unlist(lapply(PR, function(x) x[1,"MinT"]))
) 



#################################################

# Removing them from original data:

datawithoutpseudo <- rbind(now, remove.pseudoreplicas(PR, pbdb))

length(datawithoutpseudo$Species)

length(unique(datawithoutpseudo$Species))


# Let's visualize the final dataset:

resolution <- datawithoutpseudo$MaxT-datawithoutpseudo$MinT

hist(resolution, 
     xlab="resolution", 
     main="Resolution NOW + PBDB - removing PBDB replicates)", 
     col="red")




###########
# Now we can visualize a few things within our dataset.


par(mfrow=c(1,2))



# Plot comparing the distribution of occurrence resolution of both datasets:
hist(datawithoutpseudo$MaxT-datawithoutpseudo$MinT, 
     xlab = "Resolution (My)",
     col=alpha("black", .2), 
     main="Resolution", 
     probability = F)
hist(removed_psedoreps$MaxT-removed_psedoreps$MinT, 
     add=T, 
     border="red", 
     col=alpha("red", .2), 
     breaks = 5, 
     probability = F)
legend("right", 
       inset=0.3, 
       title="Type of occurrence",
       c("True occs","Double occs"), 
       fill=scales::alpha(c("black", "red"), alpha = .5), 
       horiz=F, cex=0.8)


# And a second one comparing how occurrences are distributed within species:
hist(table(datawithoutpseudo$Species), 
     breaks=40, 
     xlab="Species number of occurrences", 
     probability = F, 
     col=alpha("black", .2),
     main="Occurrences within species")
hist(table(removed_psedoreps$Species), 
     add=T, 
     border="red", 
     probability = F, 
     col=alpha("red", .2), 
     breaks = 3)
legend("right", 
       inset=0.3, 
       title="Type of occurrence",c("True occs","Double occs"), 
       fill=scales::alpha(c("black", "red"), alpha = .5), 
       horiz=F, 
       cex=0.8)



par(mfrow=c(1,1))


# Do those differences mean that there is something different
# in the double occurrences? What if they are simply "random subsets" 
# of occurrences in the original dataset? One possible way to evaluate this 
# is by ramdomnly draw a subset of the data 
# without double occurrences (i.e. true reps):
plot(NA, xlim=c(0,237), ylim=c(0,1), 
     ylab="cumulative sum of density", 
     xlab="Species number of occurrences", 
     main="Distribution of occurrences per species")


# Plotting
for(i in 1:100){
  randomdt=datawithoutpseudo[sample(1:nrow(datawithoutpseudo), 
                                    size = nrow(removed_psedoreps)),]
  csrdm_wout_pseudo=cumsum(table(randomdt$Species)/nrow(randomdt))
  csrdm_wout_quant=(1:length(csrdm_wout_pseudo))#/length(csrdm_wout_pseudo)
  lines(x=csrdm_wout_quant, y=csrdm_wout_pseudo, 
        type="l", lwd=1, col=scales::alpha("black", .2))
} 


# Now lets plot the original data
csdt_wout_pseudo <- 
  cumsum(table(datawithoutpseudo$Species)/nrow(datawithoutpseudo))

csdt_wout_quant <- 
  (1:length(csdt_wout_pseudo))#/length(csdt_wout_pseudo)

lines(x=csdt_wout_quant, y=csdt_wout_pseudo, type="l", lwd=3)


# Now ploting the double occurrences
csdt_with_pseudo <- 
  cumsum(table(removed_psedoreps$Species)/nrow(removed_psedoreps))

csdt_with_quant <- 
  (1:length(csdt_with_pseudo))#/length(csdt_with_pseudo)

lines(x=csdt_with_quant, y=csdt_with_pseudo, col="red", lwd=3)

legend("bottomright", 
       inset=.02, 
       title="Type of occurrence",
       c("True occs (N = 3092)","Double occurrences (N = 82)", 
         "Randomly-resampled true occs (each N =82"),
       col=c("black", "red", scales::alpha("black", alpha = .5)), 
       horiz=F, cex=0.8, lty=1, lwd=c(3,3,1))


# But we can also check the double occurrences trends through time 
# by doing the following:



# Let's put a time component in this exploratory analysis:
par(mfrow=c(3,1))


# Raw number of double occurrences
literal_occstt <- raw.DTT(removed_psedoreps)
plot(NA, xlim=rev(range(removed_psedoreps$MaxT)), 
     main="Double occurrences through time", 
     ylab="Number of occurrences", 
     xlab="Time (Mya)", 
     ylim=c(-1,max(literal_occstt)))
add.int(GSA=T)
text(x = c(35, 27, 15,3.7,1.8), 
     y = rep(-1.2, times=5), 
     labels = c("Eoc", "Olig", "Mioc", "Pl", "Qt"), 
     cex=.5)
lines(x=literal_occstt$time, y=literal_occstt$dtt, lwd=3)
text(x = 36, y = 65, labels = "A", cex=3)


# "Diversity through time" of double occurrences
literal_dtt <- raw.DTT(removed_psedoreps, lineages = 1)
plot(NA, 
     ylim=c(0, max(literal_dtt$dtt)), 
     xlim=rev(range(removed_psedoreps$MaxT)), 
     main="Diversity Through Time of double occurrences", 
     ylab="Number of species", 
     xlab ="Time (Mya)")
add.int(GSA=T)
text(x = c(35, 27, 15,3.7,1.8), 
     y = rep(rev(range(removed_psedoreps$MaxT))[2]-1, times=5), 
     labels = c("Eoc", "Olig", "Mioc", "Pl", "Qt"), 
     cex=.5)
lines(x=literal_dtt$time, y=literal_dtt$dtt,col="red", lwd=3,)
text(x = 36, y = 30, labels = "B", cex=3)



# "Double occurrences per species through time"
pseudott <- merge(literal_dtt, literal_occstt, by = "time")
colnames(pseudott) <- c("time", "diversity", "n_occs")
plot(NA, 
     xlim=rev(range(removed_psedoreps$MaxT)), 
     main="Double occurrencetion per species through time", 
     ylab="Occs / species", 
     xlab="Time (Mya)", 
     ylim=c(min(pseudott$n_occs/pseudott$diversity, na.rm = T)-1, 
            max(pseudott$n_occs/pseudott$diversity, na.rm = T)))
add.int(GSA=T)
text(x = c(35, 27, 15,3.7,1.8), 
     y = rep(min(pseudott$n_occs/pseudott$diversity, na.rm = T)-1, times=5), 
     labels = c("Eoc", "Olig", "Mioc", "Pl", "Qt"), 
     cex=.5)
lines(x=pseudott$time, y=pseudott$n_occs/pseudott$diversity, lwd=3, col="blue")
text(x = 30, y = 7, labels = "C", cex=3)


dev.off()
par(mfrow=c(1,1))


# Now, let’s take a final look at them:

# Checking their temporal distribution as raw data:
now_wout_pseudo <- 
  remove.pseudoreplicas(PR, now) #removing double occurrences from NOW dataset
true_occs <- rbind(pbdb, now_wout_pseudo)
true_occs$col="black"
pseudoreps=removed_psedoreps
pseudoreps$col="purple"
pseudoTT=rbind(true_occs[,c(1:3, 7)], pseudoreps)
pseudoTT=pseudoTT[order(pseudoTT$MaxT, decreasing = T),]
plot(NA, 
     xlim=c(40,0), 
     ylim=c(0, nrow(pseudoTT)), 
     yaxt="n",
     ylab="Fossil occrruences",
     xlab="Time (Mya)", 
     main="Double occurrences through time")
for(i in 1:nrow(pseudoTT)){
  segments(x0 = pseudoTT$MaxT[i], 
           y0 = i, 
           x1 = pseudoTT$MinT[i], 
           y1 = i, 
           col = pseudoTT$col[i])
}

# And lets check the proportion of species with double occurrences through time:
Toccs=raw.DTT(true_occs)
Poccs=raw.DTT(removed_psedoreps, max_time = 46.2)
dt_aux=merge(Toccs, Poccs, by = "time")
colnames(dt_aux)=c("time", "Tdtt", "Pdtt")
head(dt_aux)


plot(NA, 
     xlim=rev(range(dt_aux$time)), 
     main="Proportion of species with double occurrences through time", 
     ylab="Pseudorep spp / True spp", 
     xlab="Time (Mya)",
     ylim=c(-0.005,.15))
add.int(GSA=T)
text(x = c(35, 27, 15,3.7,1.8),
     y = rep(-0.005, times=5), 
     labels = c("Eoc", "Olig", "Mioc", "Pl", "Qt"), 
     cex=.5)
lines(x=dt_aux$time, y=dt_aux$Pdtt/dt_aux$Tdtt, lwd=3, col="black",)




# Now we'll remove the double occurrences from NOW so they will 
# no longer be doubled, and NOW will have unique registers compared to PBDB.

# As the NOW database does not have a tool to track the primary reference 
# of each occurrence, we can be conservative here and just remove 
# all possible replicates, using the command 

now=now_wout_pseudo #removing double occurrences from NOW dataset


####AQUI PARAMOS COM AS COISAS EXPLORATORIAS 


####################################

# Going back to cleaning the dataset:


###############################################################################

# Adding info regarding fossil site and extinction at current time

# This is where we'll start preparing the data to identify preservation models.
# We'll use original data table from PBDB and NOW without double occurrences.

# In PyRate, preservation refers to the probability of fossilization, 
# identification and sampling. Because of this, if a fossil assemblage or 
# site contains several occurrences, it might be realistic to consider these
# occurrences as contemporary, meaning that all occurrences should have the 
# same randomization of age within their temporal ranges. In other words, 
# they will have identical random ages within the same replicated dataset. 
# The attribution of sites can be done by specifying manually a “Site” 
# column in the input data, with a number specifying the ID of the assemblage
# for each occurrence. 

###############################################################################

# Let's add an additional column of information and use the search.site()
#f unction to assign sites based on the information provided.

pbdb <- search.site(data = pbdb)
now <- search.site(data = now_wout_pseudo)


# A little correction for the sites in the NOW database:
now$Site=now$Site+max(pbdb$Site)
PyRate_input <- rbind(pbdb, now)






#############################################################################
#############################################################################

##############       Separating fossils by continent           ##############       

#############################################################################
#############################################################################

library(sp)
library(rworldmap)
library(yarrr)
library(ggplot2)


###################### Creating a function to separate into continents

# Defining the continent polygons by latitude and longitude

NAm <- data.frame(lat=c(90,90,78.13,57.5,15,15,1.25,1.25,51,60,60,90),
               lon=c(-168.75,-10,-10,-37.5,-30,-75,-82.5,-105,
                     -180,-180,-168.75,-168.75))

NAm2 <- data.frame(lat=c(51,51,60,51),
                  lon=c(166.6,180,180,166.6))

SAm <- data.frame(lat=c(1.25,1.25,15,15,-60,-60,1.25),
                 lon=c(-105,-82.5,-75,-30,-30,-105,-105))

europe <- data.frame(lat=c(90,90,42.5,42.5,40.79,41,40.55,40.40,40.05,39.17,
                           35.46,33,38,35.42,28.25,15,57.5,78.13,90),
                  lon=c(-10,77.5,48.8,30,28.81,29,27.31,26.75,26.36,
                        25.19,27.91,27.5,10,-10,-13,-30,-37.5,-10,-10))

africa <- data.frame(lat=c(15,28.25,35.42,38,33,31.74,29.54,27.78,11.3,
                        12.5,-60,-60,15),
                  lon=c(-30,-13,-10,10,27.5,34.58,34.92,34.46,
                        44.3,52,75,-30,-30))

australia <- data.frame(lat=c(-11.88,-10.27,-10,-30,-52.5,-31.88,-11.88),
                     lon=c(110,140,145,161.25,142.5,110,110))

asia <- data.frame(lat=c(90,42.5,42.5,40.79,41,40.55,40.4,40.05,39.17,35.46,33,
                      31.74,29.54,27.78,11.3,12.5,-60,-60,-31.88,-11.88,-10.27,
                      33.13,51,60,90,90),
                lon=c(77.5,48.8,30,28.81,29,27.31,26.75,26.36,25.19,27.91,27.5,
                      34.58,34.92,34.46,44.3,52,75,110,110,110,140,140,166.6,
                      180,180,77.5))

asia2 <- data.frame(lat=c(90,90,60,60,90), 
                    lon=c(-180,-168.75,-168.75,-180,-180))

antarctica <- data.frame(lat=c(-60,-60,-90,-90,-60), 
                         lon=c(-180,180,180,-180,-180))

continents <- list(
  y=c(NAm$lat, NA, NAm2$lat, NA, SAm$lat, NA, europe$lat,NA,africa$lat,NA,
      australia$lat,NA,asia$lat,NA,asia2$lat,NA,antarctica$lat),
  x=c(NAm$lon, NA, NAm2$lon, NA, SAm$lon, NA,europe$lon,NA,africa$lon,NA,
      australia$lon,NA,asia$lon,NA,asia2$lon,NA,antarctica$lon),
  names <- c("North America", "North America:2", "South America", "Europe",
          "Africa","Australia","Asia","Asia:2","Antarctica"))
class(continents) <- "map"



######################


data <- PyRate_input

points <- data.frame(PyRate_input$lng, PyRate_input$lat)


continents_of_each_record <- maps::map.where(continents, points)

# Add a column at the end of the main dataframe with the continents
PyRate_input <- PyRate_input %>%
  mutate(continent=continents_of_each_record)


# Now select only the ones from SELECTED LOCALITY

# We'll do that by removing all the occurrences from UNSELECTED LOCALITIES.

PyRate_input=PyRate_input[!PyRate_input$continent == "UNSELECTED LOCALITY 1", ]
PyRate_input=PyRate_input[!PyRate_input$continent == "UNSELECTED LOCALITY 2", ]

# And so on and so forth.


# Then we remove continent column 
PyRate_input <- PyRate_input[,-c(8)]

# Our final input has only the SELECTED LOCALITY records 
PyRate_input


###############################################################################



# Then we remove the information of latitude, 
# ongitude and bed_info, which are not used by PyRate

PyRate_input <- PyRate_input[,-c(4,5,6)]

# Our final input looks like:
head(PyRate_input)


#Note: check if the site function correctly attributed each site. 
# As I will not do this here in this tutorial, 
# I will just remove the site column
PyRate_input <- PyRate_input[,-4]



# The next step is to inform to our data which species 
# are extant and which are extinct. 

living_carnivora <- c("Mustela_lutreola",
                      "Neovison_macrodon",
                      "Nasua_narica",
                      "Ailuropoda_melanoleuca",
                      "Ailurus_fulgens",
                      "Aonyx_cinerea",
                      "Arctictis_binturong",
                      "Arctonyx_collaris",
                      "Bassariscus_astutus",
                      "Canis_aureus",
                      "Canis_latrans",
                      "Canis_lupus",
                      "Canis_rufus",
                      "Catopuma_temminckii",
                      "Conepatus_leuconotus",
                      "Conepatus_semistriatus",
                      "Crocuta_crocuta",
                      "Cuon_alpinus",
                      "Enhydra_lutris",
                      "Felis_chaus",
                      "Felis_ocreata",
                      "Felis_silvestris",
                      "Gulo_gulo",
                      "Helarctos_malayanus",
                      "Herpestes_urva",
                      "Leopardus_pardalis",
                      "Lontra_canadensis",
                      "Lutra_lutra",
                      "Lutra_sumatrana",
                      "Lutrogale_perspicillata",
                      "Lynx_canadensis",
                      "Lynx_lynx",
                      "Lynx_pardinus",
                      "Lynx_rufus",
                      "Martes_americana",
                      "Martes_flavigula",
                      "Martes_foina",
                      "Martes_martes",
                      "Martes_oregonensis",
                      "Martes_zibellina",
                      "Meles_leucurus",
                      "Meles_meles",
                      "Melogale_orientalis",
                      "Melursus_ursinus",
                      "Mephitis_mephitis",
                      "Mustela_erminea",
                      "Mustela_frenata",
                      "Mustela_nigripes",
                      "Mustela_nivalis",
                      "Mustela_nudipes",
                      "Mustela_putorius",
                      "Mustela_sibirica",
                      "Neofelis_nebulosa",
                      "Neovison_vison",
                      "Nyctereutes_procyonoides",
                      "Paguma_larvata",
                      "Panthera_onca",
                      "Panthera_tigris",
                      "Paradoxurus_hermaphroditus",
                      "Prionailurus_bengalensis",
                      "Prionailurus_planiceps",
                      "Procyon_lotor",
                      "Puma_concolor",
                      "Spilogale_putorius",
                      "Taxidea_taxus",
                      "Urocyon_cinereoargenteus",
                      "Ursus_americanus",
                      "Ursus_arctos",
                      "Ursus_maritimus",
                      "Ursus_thibetanus",
                      "Viverra_tangalunga",
                      "Viverra_zibetha",
                      "Vormela_peregusna",
                      "Vulpes_corsac",
                      "Vulpes_lagopus",
                      "Vulpes_macrotis",
                      "Vulpes_velox",
                      "Vulpes_vulgaris",
                      "Vulpes_vulpes")


# Now we assign status to the species
PyRate_input$Status <- "extinct"
PyRate_input$Status[PyRate_input$Species %in% living_carnivora] <- "extant"


# Reorganizing data:
PyRate_input <- PyRate_input[,c(1,4,2,3)]

# Pyrate's final input:
head(PyRate_input)

head (PyRate_input[,c(1,2,3,4)])

PyRate_input <- PyRate_input[,c(1,2,4,3)]




###############################################################################

#Visualizing and selecting preservation models


#The uncertainty related to fossil dating is not the only aspect 
#related to preservation that is important in a fossil analysis. 
# The preservation rate in fossil record varies throughout geologic time, 
# and this affects the type of inference which can be made with fossil 
# occurrences. We can check for this possibility of variation in preservation 
# in the data by modeling the preservation of the fossil dataset 
# as a Time-variable Poisson process (TPP). This model of preservation assumes 
# that preservation rates are constant within a predefined time frame 
# (i.e. a preservation regime), but can vary across time frames 
# (e.g. geological epochs). This model is particularly useful if we expect 
# rate heterogeneity to occur mostly through time. 

# To check if preservation varies in time and also to set the model,
# one first needs to provide the time frames in which preservation is constant. 
# As there are many possibilities of time frames, we can use a simple 
# visual analysis to decide which is the best time frame configuration. 
# We use the TPP.visualization() function to evaluate the fit of proposed
# intervals of time to the time-variance in the resolution of data.
# We can also check different models, choose two or three of them,
# and compare them by using function -PPmodeltest on PyRate.

#The desired in a TPP is maximizing the number of occurrences completely 
# inside each interval (i.e. occurrences which DON’T cross any time frame), 
# but retaining some reasonable amount of occurrences in each of the intervals 
# (because the model needs occurrences to estimate diversification 
# and preservation parameters). A very important thing to consider 
# when proposing a preservation interval is to take in consideration 
# the interpretability of the preservation regimes. It is desirable 
# to maximize the interpretation of the preservation parameters 
# to both maximize the information returned by PyRate 
# and minimize the chance of overfitting.

###############################################################################


# We can compare the fit of different propositions of intervals:

PyRate_input=na.omit(PyRate_input)
#MODEL 1
#Holocene, Pleistocene, Pliocene, Miocene1 (5.33 - 13.82), 
#Miocene2 (13.82 - Oligocene), Oligocene, Eocene, Paleocene
model_1=c(0, 1.78,4.9, 13.62, 25.03,37.5,56.0)
TPP.visualization(PyRate_input, intervals = model_1, plot.TPP = T, buffer = 0.1)

# Once again, it doesnt look like there's a clear divide, but I'll keep trying.

model_2=c(0, 1.78,4.9, 13, 25.03,37.5,56.0)
TPP.visualization(PyRate_input, intervals = model_2, plot.TPP = T, buffer = 0.1)


###############################################################################

# Resampling datasets and creating simple scripts to parallel MCMC runs


# The last step of data curation is to resample the raw data provided 
# as time intervals for each fossil occurrence and generate point-estimates 
# for each occurrence in replicated datasets. We do this with the function 
# extract.ages. The argument states the maximum resolution (in million years) 
# which is accepted in your analysis. Any occurrence with a timespan larger 
# than the argument will be removed from the dataset before runing 
# the MCMC algorithm. The larger the number of replicates, the better we can 
# explore the possibilities in our fossil data, but also the higher 
# the computational work needed, as PyRate can only run 
# one replicate per computational core.

###############################################################################

head(PyRate_input)

PyRate_input=PyRate_input

PyRate_input=na.omit(PyRate_input)

# We can save our data
write.table(PyRate_input, 
            file = "LINEAGENAME_LOCATION_data_final_now_&_pbdb.txt", 
            sep=" ", 
            row.names = F, 
            quote = F)


# And then resample it
extract.ages(obj=PyRate_input, 
             replicates = 50, 
             cutoff = 15, 
             dataset_name="LINEAGENAME_LOCATION", 
             print.out=T)

# This step creates the .py object we need to run the PyRate analysis.

# Then we should save the TPP intervals:

intervals=sort(model[-c(1, length(model))]) 
# Removing zero and Inf and changing the order in the file

write.table(data.frame(intervals), 
            file = "epochs.txt", 
            row.names = F, 
            col.names = F)

# Now we can use the replicates to run a simple PyRate MCMC estimation, 
# using the commmand list to adjust properly the MCMC integrator parameters.
# Once we decided for a specific list of comands we can generate an script to
# parallel the many runs (one for each replicate) PyRates. We do this as
# the following:

run <- "python3 PyRate.py Barbourofelidae_eurasia_PyRate.py -mG -A 4 -qShift epochs_modelo_2.txt -n=30000000 -s 10000 -log_sp_q_rates"


parallel.pyrate(command_line = run, replicates=1:20, n_cores=1, folder = "PATH")
# Note that you can actually run less replicas than you actually replicated,
# or can run only specific replicates.


# Have fun with PyRate!

