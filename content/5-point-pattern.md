---
layout: default
title: Point pattern analysis
has_children: true
has_toc: false
nav_order: 7
---

## Point Pattern Analysis

Point pattern analysis (PPA) is the study of the spatial arrangements of points in (usually 2-dimensional) space.
For such analysis, we have to distinguish intensity, and density.
 [source](https://en.wikipedia.org/wiki/Point_pattern_analysis)



Density
{: .label .label-yellow }
Density refers to point concentration in an area.


Intensity
{: .label .label-yellow }
Intensity is estimated from the observed point concentration over the given area. 



<img src="{{site.baseurl}}/content/fig/plot4.png">     |  <img src="{{site.baseurl}}/content/fig/plot10.png">
:-------------------------:|:-------------------------:
Density  |  Intensity



- What is an example of high density and low intensity?
{: .warn}




___

## *1*{: .circle .circle-blue} Point Pattern Analysis with spatstat

`spatstat` package provides several functionalities for point pattern analysis.
However, point pattern analysis does not benefit from the multiple polygons dividing 
the neighbourhoods and we will use the city boundary instead.



`spatstat` is also designed to work with points stored as `ppp` objects, so we will have to convert from `sf` to `ppp`. This requires multiple steps, such as reading the file, removing meta-data, etc. When multiple steps are required, it might be useful to make a function that will encapsulate all of these procedures:

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


For the city boundary, we need to convert from `SpatialLinesDataFrame` to `polygonal boundary`

R Code
{: .label .label-green }
```R
aux <- readShapeSpatial("city-boundary.shp") 
aux <- st_polygonize(st_as_sf(aux))
aux <- as(aux, "Spatial")
city <- as.owin(aux)
```
[source](https://stackoverflow.com/questions/47147242/convert-spatial-lines-to-spatial-polygons)



### *2*{: .circle .circle-blue} It might also be interesting to merge the points


`superimpose.ppp` takes any number of points for merging.


R Code
{: .label .label-green }
```R
ppp_data  <- superimpose.ppp(schools_ppp, libraries_ppp, community_centres_ppp, disability_parkings_ppp)
```

### *3*{: .circle .circle-blue} Finally, we bind the city boundary to the set of points



R Code
{: .label .label-green }
```R
Window(ppp_data) <- city
```





### We can plot the point layer to ensure everything is properly set:

R Code
{: .label .label-green }
```R
plot(ppp_data, main=NULL, cols=rgb(0,0,0,.2), pch=20)
```


___


## *4*{: .circle .circle-blue} Quadrat density

A study area is divided into sub-regions (aka quadrats).
Then, the point density is computed for each quadrat by dividing the number of points in each quadrat by the quadrat’s area.
spatstat provides the `quadratcount` to obtain quadrats:



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


## *5*{: .circle .circle-blue} Quadrat intensity

Given quadrats, we obtain their itensity with `intensity`


R Code
{: .label .label-green }
```R
ppp_data.scale <- rescale(ppp_data, .01, "log10")
Q   <- quadratcount(ppp_data.scale, nx= 6, ny=2)


plot(intensity(Q, image=TRUE), main=NULL, las=1)  # Plot density raster
plot(ppp_data.scale, pch=20, cex=0.6, col=rgb(0,0,0,.5), add=TRUE)  # Add points
```

Output
{: .label .label-yellow }
<img src="{{site.baseurl}}/content/fig/plot10.png">


## *6*{: .circle .circle-blue} Kernel Density

Like the quadrat density, the kernel approach computes a localized density for subsets of the study area.
Unlike its quadrat density counterpart, the sub-regions overlap, which produces a smoothly curved surface over each point. 

spatstat provides the `density` to obtain the kernel density of a set of points:



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

- Use the chat to mention a potential dataset where point pattern analysis could be used to ...
{: .warn}



___

### Recap

*1*{: .circle .circle-blue} `as.ppp` and `as.owin` respectively convert points and polygons to the spatstat format (ppp)

*2*{: .circle .circle-blue} `superimpose.ppp` merges different point variables

*3*{: .circle .circle-blue} `Window` assigns a polygon area to a set of points

*4*{: .circle .circle-blue} `quadratcount` counts the density of points in a given area

*5*{: .circle .circle-blue} `intensity` computes the intensity of points in a given area

*6*{: .circle .circle-blue} `density` computes the kernel density of a set of  points 