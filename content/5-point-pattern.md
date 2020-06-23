---
layout: default
title: Point pattern analysis
parent: Outline
nav_order: 5
---

## spatstat

`spatstat` package provides several functionalities for point pattern analysis.
However, point pattern analysis does not benefit from the multiple polygons dividing 
the neighbourhoods and we will use the city boundary instead.



`spatstat` is also designed to work with points stored as `ppp` objects, so we will have to convert from `sf` to `ppp`. This requires multiple steps, such as reading the file, removing meta-data, etc. So it might be nice to make a function that will encapsulate all of these procedures for us.

R Code
{: .label .label-green }
```R
convert2ppp <- function(input_file){
  x <- readShapeSpatial(input_file)
  y <- as.ppp(x)
  # Note that a ppp object may or may not have meta-data information (also referred to as marks). 
  # We'll therefore remove all marks from the point object.
  marks(y) <- NULL
  return(y)
}
```



R Code
{: .label .label-green }
```R
schools_ppp <- convert2ppp("schools.shp")
libraries_ppp <- convert2ppp("libraries.shp")
community_centres_ppp <- convert2ppp("community-centres.shp")
disability_parkings_ppp <- convert2ppp("disability-parking.shp")
```




### It might also be interesting to merge the points




R Code
{: .label .label-green }
```R
schools_ppp <- convert2ppp("schools.shp")
libraries_ppp <- convert2ppp("libraries.shp")
community_centres_ppp <- convert2ppp("community-centres.shp")
disability_parkings_ppp <- convert2ppp("disability-parking.shp")
```

### Finally, we bind the city boundary to the set of points


Because of the shape file available, we need to convert from `SpatialLinesDataFrame` to `polygonal boundary`

R Code
{: .label .label-green }
```R
aux <- readShapeSpatial("city-boundary.shp") 
aux <- st_polygonize(st_as_sf(aux))
aux <- as(aux, "Spatial")
city <- as.owin(aux)

Window(ppp_data) <- city
```
[source](https://stackoverflow.com/questions/47147242/convert-spatial-lines-to-spatial-polygons)


### We can plot the point layer to ensure everything is properly set:

R Code
{: .label .label-green }
```R
plot(ppp_data, main=NULL, cols=rgb(0,0,0,.2), pch=20)
```

## Density Based Analysis


###  quadrat count

A study area is divided into sub-regions (aka quadrats).
Then, the point density is computed for each quadrat by dividing the number of points in each quadrat by the quadrat’s area

R Code
{: .label .label-green }
```R
Q <- quadratcount(ppp_data, nx= 6, ny=2)
plot(ppp_data, pch=20, cols="grey70", main=NULL)  
plot(Q, add=TRUE)  
```

Output
{: .label .label-yellow }
<img src="{{site.baseurl}}/content/fig/plot4.png">


### intensity

R Code
{: .label .label-green }
```R
ppp_data.scale <- rescale(ppp_data, .01, "log10")
Q   <- quadratcount(ppp_data.scale, nx= 6, ny=2)

# Plot the density
plot(intensity(Q, image=TRUE), main=NULL, las=1)  # Plot density raster
plot(ppp_data.scale, pch=20, cex=0.6, col=rgb(0,0,0,.5), add=TRUE)  # Add points
```

### Density

Like the quadrat density, the kernel approach computes a localized density for subsets of the study area.
Unlike its quadrat density counterpart, the sub-regions overlap one another providing a moving sub-region window, which is defined by a kernel.

R Code
{: .label .label-green }
```R
K2 <- density(ppp_data.scale) 
plot(K2, main=NULL, las=1)
contour(K2, add=TRUE)
```


Output
{: .label .label-yellow }
<img src="{{site.baseurl}}/content/fig/plot5.png">




## Exercise

- Use the chat to mention a dataset and how point pattern analysis could be used to ...
{: .warn}


### Recap

- `spatstat` works with `spatial` data (`ppp` and `owin`)
- `Window` binds a polygon area to a set of points
- `quadratcount` computes quadrat density
- `density` computes kernel density