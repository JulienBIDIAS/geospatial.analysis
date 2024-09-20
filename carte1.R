# <<<<<<<<<<<<<<<<<   CARTES STATIQUES SUR R >>>>>>>>>>>>>>>>>>>>>>>>>>>>

# AVEC GEODATA 


# Librairies nécessaires 

library(sf)         # Pour les cartes
library(raster)     # Donnees matricelles/ chargé des donnees integrees
library(dplyr)      # Manipulation des données
library(spData)
library(spDataLarge)
library(cartography)

#install.packages("spDataLarge", repos = "https://nowosad.github.io/drat/", type = "source")

library(tmap)    # Pour les cartes statiques 
library(leaflet) # Pour les Cartes interactives 
library(mapview) # Pour les Cartes interactives 
library(ggplot2) # Data visualisation 
library(shiny)   # Applications web 
library(geodata) # Pour avoir aussi des données geographiques des pays 


# Introduction 

# Etape 1 : On charge la librairie 

# library(raster) 
# libra

# Etape 2 : On charge les donnees

#adm_camer <- getData("GADM", country='CMR', level=2) # Pour la fonction raster

# Ou encore 

gadm_cmr <- gadm("CMR", level=0, 
                 path ="C:\\Users\\Julien\\Desktop\\JULIEN\\CARTOGRAPHIE",
                 version="latest", resolution=1)


# GADM indique que je veux des contours administratifs
# CMR est le code du Cameroun *
# level est le niveau de résolution  (1 : carte des régions - 2 : départements - 3 : communes)

# Fonctions pour connaitre la liste des pays

countries <- getData('ISO3')
print(countries)

# Etape 3 : on affiche la carte 

plot(gadm_cmr)

# On modifie le niveau 

gadm_cmr3 <- gadm("CMR", level=1, 
                 path ="C:\\Users\\Julien\\Desktop\\JULIEN\\CARTOGRAPHIE",
                 version="latest", resolution=1)
plot(gadm_cmr3)

# Des regions 

gadm_cmr3$NAME_1
plot(gadm_cmr3[gadm_cmr3$NAME_1=="Centre",]) # On plot par exemple le centre 

# Deux et + regions (littoral et centre)

littoral_centre <- gadm_cmr3[gadm_cmr3$NAME_1 %in% c("Littoral","Centre"),]
  
plot(littoral_centre, col = "gray")

# Carte du Monde 

# country_codes()


# On peut mettre les couleurs 
library(RColorBrewer)

# vecteur de couleurs avec autant de couleurs qu'il y a de régions
# Ici, nous utilisons une palette de couleurs de RColorBrewer

colors <- brewer.pal(n = length(unique(gadm_cmr3$NAME_1)), name = "Set1")

# Palettes 

#"Set1"
#"Set2"
#"Set3"
#"Paired"
#"Dark2"
#"Accent"
#"Pastel1"
#"Pastel2"

plot(gadm_cmr3, col = colors)
plot(gadm_cmr3, col = colors, bg="white",box=F, border="grey", axes = FALSE)


# Mettre les noms des régions  

# On Convertit les données en format sf pour calculer les centroïdes

gadm_sf <- st_as_sf(gadm_cmr3)

# On Calcule les centroïdes pour chaque région

centroids <- st_centroid(gadm_sf)

# Ajouter les noms des régions aux centroïdes

text(st_coordinates(centroids), labels = gadm_sf$NAME_1, cex = 0.7, col = "black")

# la légende 



# Echelle et navigation 
plot(gadm_cmr3, col = colors, bg="white",box=F, border="grey", axes = FALSE)
text(st_coordinates(centroids), labels = gadm_sf$NAME_1, cex = 0.7, col = "black")
scalebar(d = 200, xy = c(5,42), type = "bar", below = "km",lwd = 5, divs = 2, col = "black", cex = 1, lonlat = T)


# Ajouter des données statistiques 

doe <-  worldclim_country("CMR", var="prec", path="C:\\Users\\Julien\\Desktop\\JULIEN\\CARTOGRAPHIE", version="2.1")
plot(doe)

