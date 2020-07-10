---
layout: default
title: Data Types
nav_order: 4
---

## Spatial Data

GIS often represents data in a 2 dimensional plane or using some coordinate reference system

<img src="{{site.baseurl}}/content/fig/vector_vs_raster.jpg">

[source](https://mgimond.github.io/Spatial/feature-representation.html)

Vector
{: .label .label-yellow }
Vector data is simpler, it encompasses points, lines, and polygons of any shape.

Raster
{: .label .label-yellow }
Raster data uses pixels (many of them!) to represent real-world images, e.g., a satellite picture.


<img src="{{site.baseurl}}/content/fig/sphere.png">

[source](https://www.diffen.com/difference/Latitude_vs_Longitude)

Coordinate Reference System
{: .label .label-yellow }
A spatial reference system or coordinate reference system is a coordinate-based local, regional or global system used to locate geographical entities. For example, 
Latitude and Longitude can represent spatial data for virtually any point on earth!


## *1*{: .circle .circle-blue} Loading Spatial Data in R

For this workshop, we will focus on **vector** data. 
Similar operations exist for raster, we have provided multiple links under resources. 

R Code
{: .label .label-green }
```R
# load vector
vancouver_boundaries <- st_read("local-area-boundary.shp")
```

## Inspecting a file's meta-data


### *2*{: .circle .circle-blue} Coordinate Reference System

R Code
{: .label .label-green }
```R
st_crs(vancouver_boundaries)$proj4string
```

### *3*{: .circle .circle-blue} Types of Geometry

R Code
{: .label .label-green }
```R
st_geometry_type(vancouver_boundaries)
unique(st_geometry_type(vancouver_boundaries))
```

### *4*{: .circle .circle-blue} Bounding Boxes

R Code
{: .label .label-green }
```R
st_bbox(vancouver_boundaries)
```

## Converting Tabular Data to Spatial Data

In certain cases, you may not have access to vector or raster files. Nonetheless, you have recorded some geo spatial feature as part of your data collection methodology. 

<img src="{{site.baseurl}}/content/fig/schools.png">


R Code
{: .label .label-green }
```R
# Load tabular data
tbl <- read.csv("schools.csv", header=TRUE, sep=";")
```

*5*{: .circle .circle-blue} Provided that you have some geo spatial feature, e.g., postal codes, you can convert your data 
accordingly. 

R Code
{: .label .label-green }
```R
crs_vancouver <- st_crs(vancouver_boundaries)
schools <- st_as_sf(tbl, coords = c("LON", "LAT"), crs = crs_vancouver) 
```


## Data Needed for this Workshop



R Code
{: .label .label-green }
```R
transit_routes <- st_read("Shapes_Trips_Routes.shp")
schools <- st_read("schools.shp")
libraries <- st_read("libraries.shp")
community_centres <- st_read("community-centres.shp")
disability_parkings <- st_read("disability-parking.shp")
```

___


### Recap

*1*{: .circle .circle-blue} `st_read` reads a shape file

*2*{: .circle .circle-blue} `st_crs` views coordinates of shape data

*3*{: .circle .circle-blue} `st_geometry_type` views geometry of the data, e.g., polygons, lines, dots, etc.

*4*{: .circle .circle-blue} `st_bbox` views boundaries of data

*5*{: .circle .circle-blue} `st_as_sf` converts from tabular to spatial data
