library(sf)
library(geodata)
library(RColorBrewer)
library(raster)

gdm_cmr <- gadm("CMR", level = 0,
               path = "C:\\Users\\Julien\\Desktop\\JULIEN\\CARTOGRAPHIE" ,
               version = 'latest', resoultion = 1)

plot(gdm_cmr)



gdm_cmr1 <- gadm("CMR", level = 1,
                path = "C:\\Users\\Julien\\Desktop\\JULIEN\\CARTOGRAPHIE" ,
                version = 'latest', resoultion = 1)

plot(gdm_cmr1)


colors = brewer.pal(n = length(unique(gdm_cmr1$NAME_1)),  name = "Set1")


plot(gdm_cmr1, col = colors)


# Ajoutons les régions 

gdm_sf <-  st_as_sf(gdm_cmr1)

centre <-  st_centroid(gdm_sf)

# On ajoute 

text(st_coordinates(centre), labels = gdm_cmr1$NAME_1, cex=0.7, col = "black")

scalebar(d = 200, xy = c(5,42), type = "bar",
         below = "km",lwd = 5, divs = 2, col = "black", cex = 1, lonlat = T)





