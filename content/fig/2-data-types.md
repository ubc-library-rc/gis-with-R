---
layout: default
title: Data Types
parent: Outline
nav_order: 2
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


## Loading Spatial Data in R

For this workshop, we will focus on **vector** data. 
Similar operations exist for raster, we have provided multiple links under resources.

R Code
{: .label .label-green }
```R
# load vector
vancouver_boundaries <- st_read("local-area-boundary.shp")
```

## Inspecting a file's meta-data


R Code
{: .label .label-green }
```R
st_crs(vancouver_boundaries)$proj4string
```


R Code
{: .label .label-green }
```R
st_geometry_type(vancouver_boundaries)
unique(st_geometry_type(vancouver_boundaries))
```

R Code
{: .label .label-green }
```R
st_bbox(vancouver_boundaries)
```


## Converting Tabular Data to Spatial Data

In certain cases, you may not have access to vector or raster files. Nonetheless, you have recorded some geo spatial feature as part of your data collection methodology. 

<img src="{{site.baseurl}}/content/fig/schools.png">

Provided that you have some geo spatial feature, e.g., postal codes, you can convert your data 
accordingly.


R Code
{: .label .label-green }
```R
# Load tabular data
tbl <- read.csv("schools.csv", header=TRUE, sep=";")
```

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



### Recap

- `st_read` reads a shape file
- `st_crs` views coordinates of shape data
    - Not problematic in this workshop because everything is in the same CRS
- `st_geometry_type` views geometry of the data, e.g., polygons, lines, dots, etc.
- `st_bbox` views boundaries of data. 
    - Not problematic in this workshop because everything is inside Metro Vancouver
    - More challenging when working with real data
