# set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# elegant way to install all packages
list.of.packages <- c(
  "dplyr", "ggplot2", "raster", "rgdal", "rasterVis", "sf", "tmap",
  "spatstat", "maptools", "spdep", "classInt", "RColorBrewer", "maptools"
)

new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]

if(length(new.packages)) install.packages(new.packages)

# Loading the packages needed for this workshop
library(dplyr)
library(ggplot2)
library(raster)
library(rgdal)
library(rasterVis)
library(sf)
library(tmap)
library(spatstat)
library(maptools)
library(classInt)
library(RColorBrewer)

vancouver_boundaries <- st_read("data/local-area-boundary.shp")
transit_routes <- st_read("data/Shapes_Trips_Routes.shp")
schools <- st_read("data/schools.shp")
libraries <- st_read("data/libraries.shp")
community_centres <- st_read("data/community-centres.shp")
disability_parkings <- st_read("data/disability-parking.shp")

tm_shape(vancouver_boundaries) +
  tm_polygons(col = "grey", border.col = "white")

tm_shape(vancouver_boundaries) +
  tm_polygons(col = "name", border.col = "white") +
  tm_legend(outside = TRUE)

tm_shape(vancouver_boundaries) +
  tm_polygons(col = "name", border.col = "white", title = "neighbourhood") +
  tm_legend(outside = TRUE) +
  tm_layout(main.title = "City of Vancouver", main.title.position = "left")

# changing the colour palette
tm_shape(vancouver_boundaries) +
  tm_polygons(col = "name", border.col = "white", title = "neighbourhood", palette = "Pastel1") +
  tm_legend(outside = TRUE) +
  tm_layout(main.title = "City of Vancouver", main.title.position = "left")

tm_shape(vancouver_boundaries) +
  tm_polygons(col = "name", border.col = "white", title = "neighbourhood", palette = "Pastel1") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside = TRUE) +
  tm_layout(main.title = "City of Vancouver", main.title.position = "left")

tm_shape(vancouver_boundaries) +
  tm_polygons(col = "name", border.col = "white", title = "neighbourhood", palette = "Pastel1") +
  tm_shape(transit_routes) +
  tm_lines(col = "grey70", size = .1) +
  tm_legend(outside = TRUE) +
  tm_layout(main.title = "City of Vancouver", main.title.position = "left")

tm_shape(vancouver_boundaries) +
  tm_polygons(col = "name", border.col = "white", title = "neighbourhood", palette = "Pastel1") +
  tm_shape(schools) +
  tm_dots(col = "red", size = .1, shape = 18) +
  tm_legend(outside = TRUE) +
  tm_add_legend(
    type = "symbol",
    shape = c(18),
    labels = c("Schools"),
    col = c("red")) +
  tm_layout(main.title = "City of Vancouver", main.title.position = "left")

tm_shape(vancouver_boundaries) +
  tm_polygons(col = "name", border.col = "white", title = "neighbourhood", palette = "Pastel1") +
  tm_shape(schools) + tm_dots(col = "red", size = .1, shape = 18) +
  tm_shape(libraries) + tm_dots(col = "yellow", size = .1, shape = 16) +
  tm_shape(community_centres) + tm_dots(col = "blue", size = .1, shape = 15) +
  tm_shape(disability_parkings) + tm_dots(col = "black", size = .1, shape = 17) +
  tm_legend(outside = TRUE) +
  tm_add_legend(type = "symbol",
                shape = c(18, 16, 15, 17),
                labels = c("Schools", "Libraries", "Community Centres", "Disability Parking"),
                col = c("red", "yellow", "blue", "black")) +
  tm_layout(main.title = "City of Vancouver", main.title.position = "left")

income_100k <- c(
  0.18, 0.19, 0.15, 0.09, 0.08, 0.09, 0.15, 0.25, 0.11, 0.10, 0.24,
  0.21, 0.08, 0.18, 0.18, 0.06, 0.08, 0.13, 0.15, 0.05, 0.06, 0.23
)

income_30k <- c(
  0.15, 0.11, 0.11, 0.18, 0.23, 0.20, 0.15, 0.11, 0.27, 0.17, 0.11,
  0.14, 0.20, 0.12, 0.14, 0.25, 0.21, 0.13, 0.16, 0.25, 0.25, 0.11
)

vancouver_boundaries$income_100k <- income_100k * 100
vancouver_boundaries$income_30k <- income_30k * 100

brks <- classIntervals(
  vancouver_boundaries$income_100k, n = 5, style = "quantile"
)

brks

tm_shape(vancouver_boundaries) +
  tm_polygons("income_100k",
              palette = "RdYlGn",  breaks = brks$brks,
              title = "Income (%)", border.col = "white") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside = TRUE)

display.brewer.all(n = NULL, type = "all", select = NULL,
                   colorblindFriendly = TRUE)

tm_shape(vancouver_boundaries) +
  tm_polygons("income_100k",
              palette = "GnBu",  breaks = brks$brks,
              title = "Income (%)", border.col = "white") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside = TRUE)

convert2ppp <- function(input_file){
  x <- readShapeSpatial(input_file)
  y <- as.ppp(x)
  # Note that a ppp object may or may not have meta-data information (also referred to as marks).
  # We'll therefore remove all marks from the point object.
  marks(y) <- NULL
  return(y)
}

schools_ppp <- convert2ppp("data/schools.shp")
libraries_ppp <- convert2ppp("data/libraries.shp")
community_centres_ppp <- convert2ppp("data/community-centres.shp")
disability_parkings_ppp <- convert2ppp("data/disability-parking.shp")

aux <- readShapeSpatial("data/city-boundary.shp")
aux <- st_polygonize(st_as_sf(aux))
aux <- as(aux, "Spatial")
city <- as.owin(aux)

ppp_data  <- superimpose.ppp(schools_ppp, libraries_ppp, community_centres_ppp, disability_parkings_ppp)
Window(ppp_data) <- city

plot(ppp_data, main = NULL, cols = rgb(0, 0 , 0, 0.2), pch = 20)

Q <- quadratcount(ppp_data, nx = 6, ny = 2)

plot(ppp_data, pch = 20, cols = "grey70", main = NULL)

plot(Q, add = TRUE)

ppp_data.scale <- rescale(ppp_data, 0.01, "log10")

Q   <- quadratcount(ppp_data.scale, nx = 6, ny = 2)

# Plot density raster
plot(intensity(Q, image = TRUE), main = NULL, las = 1)

# Add points
plot(ppp_data.scale, pch = 20, cex = 0.6, col = rgb(0,0,0,.5), add = TRUE)

K2 <- density(ppp_data.scale)
plot(K2, main = NULL, las = 1)
contour(K2, add = TRUE)

filtered <- vancouver_boundaries %>% filter(mapid == "MP")

st_intersects(filtered, schools)
lengths(st_intersects(filtered, schools))

lst_cnt <- c()
for (neighbourhood in vancouver_boundaries$mapid) {
  neighbourhood_polygon <- vancouver_boundaries %>%
    filter(mapid == neighbourhood)
  cnt <- lengths(st_intersects(neighbourhood_polygon, schools))
  lst_cnt <- c(cnt, lst_cnt)
}

lst_cnt

vancouver_boundaries$schools <- lst_cnt

vancouver_boundaries %>% pull(mapid, schools)

brks <- classIntervals(
  vancouver_boundaries$schools, n = 5, style = "quantile"
)

tm_shape(vancouver_boundaries) +
  tm_polygons("schools",
              breaks = brks$brks, title = "Services",
              border.col = "white", palette = "GnBu") +
  tm_text("schools", just = "center", size = 0.8) +
  tm_legend(outside = TRUE)

cnt_services <- function(point_data) {
  lst_cnt <- c()
  for (neighbourhood in vancouver_boundaries$mapid) {
    neighbourhood_polygon <-
      vancouver_boundaries %>% filter(mapid == neighbourhood)
    cnt <- lengths(st_intersects(neighbourhood_polygon, point_data))
    lst_cnt <- c(cnt, lst_cnt)
  }
  return(lst_cnt)
}

vancouver_boundaries$schools <- cnt_services(schools)
vancouver_boundaries$libraries <- cnt_services(libraries)
vancouver_boundaries$community_centres <- cnt_services(community_centres)
vancouver_boundaries$all_services <-
  vancouver_boundaries$schools +
  vancouver_boundaries$libraries +
  vancouver_boundaries$community_centres

brks <- classIntervals(
  vancouver_boundaries$all_services, n = 5, style = "quantile"
)

tm_shape(vancouver_boundaries) +
  tm_polygons("all_services",
              breaks = brks$brks, title = "Services",
              border.col = "white", palette = "GnBu") +
  tm_text("all_services", just = "center", size = 0.8) +
  tm_legend(outside = TRUE)

brks <- classIntervals(vancouver_boundaries$income_100k, n = 5, style = "quantile")
plt1 <- tm_shape(vancouver_boundaries) +
  tm_polygons("income_100k", border.col = "white", palette = "GnBu", breaks = brks$brks, title = "Income") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside = TRUE)
plt1

brks <- classIntervals(
  vancouver_boundaries$all_services, n = 5, style = "quantile"
)

plt2 <- tm_shape(vancouver_boundaries) +
  tm_polygons("all_services", border.col = "white", palette = "Oranges", breaks = brks$brks, title = "Services") +
  tm_text("all_services", just = "center", size = 0.8) +
  tm_legend(outside = TRUE)

plt2

current.mode <- tmap_mode("plot")
tmap_arrange(plt1, plt2)
tmap_mode(current.mode)

cor.test(
  vancouver_boundaries$income_100k, vancouver_boundaries$all_services, method = "pearson"
)
