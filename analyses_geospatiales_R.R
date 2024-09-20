
# <<<<<<<<<<<<< Analyses géospatiales avec R >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# <<<<<<<<<<<<<<<< Cartes statistiques et interactives >>>>>>>>>>>>>>>>>>>>>>>>>>>

# Librairies 

library(readxl)
library(sf)
library(cartography)
library(tmap)
library(leaflet)
library(mapview)
library(mapsf)


# Création de données 

regions_cameroun <- tibble(
  Région = c("Adamaoua", "Centre", "Est", "Extrême-Nord", "Littoral", 
             "Nord", "Nord-Ouest", "Ouest", "Sud", "Sud-Ouest"),
  Taux_de_pauvreté = c(30, 25, 40, 50, 20, 35, 45, 28, 32, 38),  # Taux de pauvreté fictifs
  nombre_entreprises = c(1200, 5400, 800, 2300, 6700, 1500, 2100, 3100, 950, 1800)
)

# Base de données des régions et des indicateurs (Importation)

regions_cameroun <- read_excel("C:/Users/Julien/Desktop/JULIEN/CARTOGRAPHIE/regions_cameroun_pauvrete.xlsx")


# Données shapefile du Cameroun (géodonnées)

shapefile_cameroun <- st_read("C:/Users/Julien/Desktop/JULIEN/CARTOGRAPHIE/gadm41_CMR_shp/gadm41_CMR_1.shp")


# Fusion de la base de données des régions avec les géodonnées
cameroun_data <- merge(shapefile_cameroun, regions_cameroun, by.x = "NAME_1", by.y = "Région")


# 1. Cartographie avec le package cartography

# Carte thématique des taux de pauvreté par région du Cameroun

cartography::choroLayer(
  x = cameroun_data, 
  var = "Taux de pauvreté (%)", 
  method = "quantile", 
  nclass = 5, 
  col = carto.pal(pal1 = "multi.pal", n1 = 5), 
  border = "grey", 
  lwd = 0.5, 
  legend.title.txt = "Taux de pauvreté (%)",
  legend.pos = "bottomleft"
)
layoutLayer(title = "Taux de pauvreté par région au Cameroun", 
            author = "Source: Auteur", 
            scale = NULL, frame = TRUE,
            north = TRUE,         # Ajouter de la boussole de navigation à gauche
            #compass.pos = "left", # Boussole à gauche
            #density = TRUE,       # Indicateur de densité
            posscale= "bottomleft",
            postitle = "center"
            )

# Ajout des noms des régions 

cartography::labelLayer(
  x = cameroun_data, 
  txt = "NAME_1",            # noms des régions
  col = "white",             # Couleur des étiquettes
  cex = 0.8,                 # Taille des étiquettes
  #halo = TRUE,               # Pour améliorer la visibilité
  #overlap = FALSE            # Pour Empêcher les étiquettes de se chevaucher
)


######### Carte choroplèthe avec les nombres d'entreprises #################


# Carte des taux de pauvreté par région

cartography::choroLayer(
  x = cameroun_data, 
  var = "Taux de pauvreté (%)", 
  method = "quantile", 
  nclass = 5, 
  col = carto.pal(pal1 = "green.pal", n1 = 10), 
  border = "grey", 
  lwd = 0.5, 
  legend.title.txt = "Taux de pauvreté (%)",
  legend.pos = "bottomleft"
)

# Mise en page avec la boussole et l'échelle

layoutLayer(
  title = "Taux de pauvreté par région au Cameroun", 
  author = "Source: Auteur", 
  scale = NULL, 
  frame = TRUE, 
  north = TRUE,             # Ajout de la boussole de navigation à gauche
  posscale = "bottomleft",  # Ajout de l'échelle en bas à gauche
  postitle = "center"       # Titre centré
)

# Ajout des noms des régions 

cartography::labelLayer(
  x = cameroun_data, 
  txt = "NAME_1",            # noms des régions
  col = "black",             # Couleur des étiquettes
  cex = 1,                 # Taille des étiquettes
  #halo = TRUE,               # Pour améliorer la visibilité
  #overlap = FALSE            # Pour Empêcher les étiquettes de se chevaucher
)


# Ajout des centroids représentant le nombre d'entreprises

cartography::propSymbolsLayer(
  x = cameroun_data, 
  var = "nombre_entreprises",   # Nombre d'entreprises par région
  symbols = "circle",           # Utilisation des cercles comme symboles
  col =rgb(1, 0, 0, 0.5),                # Couleur des cercles
  inches = 0.2,                 # Taille des cercles proportionnelle
  legend.pos = "bottomright",   # Légende des cercles à droite
  legend.title.cex=0.5,
  legend.title.txt = "Nombre d'entreprises"
)

# Optionnel : on peut ajouter des labels pour indiquer les nombres d'entreprises sur les centroids

labelLayer(
  x = cameroun_data, 
  txt = "nombre_entreprises",  # Nombre d'entreprises
  col = "black",               # Couleur des labels
  cex = 0.8,                   # Taille des labels
  halo = TRUE,                 
  overlap = FALSE
)

# 2. Cartographie avec le package tmap

tm_shape(cameroun_data) + 
  tm_polygons("Taux de pauvreté (%)", 
              style = "quantile",
              palette = "Oranges", 
              title = "Taux de pauvreté (%)",
              interactive = TRUE) +
  tm_layout(title = "Carte des taux de pauvreté au Cameroun",
            legend.position = c("left", "top"),   # Légende à droite
            compass.type = "8star",                   # Type de boussole
            frame = FALSE) +
  tm_compass(position = c("left", "top"), size = 1) + # Boussole à gauche
  tm_scale_bar(position = c("left", "bottom"))  +
  tm_text("NAME_1", size = 0.7, col = "black", shadow = TRUE)


# Pour cette partie vous pouvez  faire un mail à l'adresse : 

# julienbidias246@gmail.com


# 3. Cartes interactives avec leaflet
  
# Récupération des centroids 
  




# 4. Carte interactive avec mapview

mapview()
