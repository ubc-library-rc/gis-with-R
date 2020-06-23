---
layout: default
title: Numerical data
parent: Outline
nav_order: 4
---

## Census Data

Nothing stops us from adding more data to our variables. 
In this section, we will make use of data from the [2016 census](https://opendata.vancouver.ca/explore/dataset/census-local-area-profiles-2016/information/) 
containing the information about income for certain salary ranges.

The 2016 Census data is quite verbose, so I took the liberty to pre-process and normalize the data in the two variables below, `income_100k` and `income_30k`. 
These variables represent the ratio of people in a certain neighborhood from a certain age group who reported having salaries above 100K or below 30K, respectively.


R Code
{: .label .label-green }
```R
income_100k <- c(
  0.18, 0.19, 0.15, 0.09, 0.08, 0.09, 0.15, 
  0.25, 0.11, 0.10, 0.24, 0.21, 0.08, 0.18, 
  0.18, 0.06, 0.08, 0.13, 0.15, 0.05, 0.06, 
  0.23)

income_30k <- c(0.15, 0.11, 0.11, 0.18, 0.23, 
  0.20, 0.15, 0.11, 0.27, 0.17, 0.11, 0.14, 
  0.20, 0.12, 0.14, 0.25, 0.21, 0.13, 0.16, 
  0.25, 0.25, 0.11)
```



R Code
{: .label .label-green }
```R
library(classInt)
library(RColorBrewer)
```


## Adding Census Data to our Variable



R Code
{: .label .label-green }
```R
vancouver_boundaries$income_100k <- income_100k * 100
vancouver_boundaries$income_30k <- income_30k * 100
```


## Dividing Data into Buckets


R Code
{: .label .label-green }
```R
brks <- classIntervals(vancouver_boundaries$income_100k, n = 5, style = "quantile")
brks
```

Output
{: .label .label-yellow }
```R
> brks
style: quantile
  one of 715 possible partitions of this variable into 5 classes
    [5,8)  [8,10.4) [10.4,15) [15,18.8) [18.8,25] 
        3         6         2         6         5 
```


## Plotting Income Data



R Code
{: .label .label-green }
```R
tm_shape(vancouver_boundaries) + 
  tm_polygons("income_100k",
              palette = "RdYlGn",  breaks= brks$brks, 
              title="Income (%)", border.col = "white") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside=TRUE)
```

Output
{: .label .label-yellow }
<img src="{{site.baseurl}}/content/fig/plot3.png">



These are examples of **choropleth maps** (choro = area and pleth = value) where some attribute is aggregated over a defined area
{: .note}


### Is anything Wrong with this Map?

<img src="{{site.baseurl}}/content/fig/watch.png" width="200">

<img src="{{site.baseurl}}/content/fig/colour-blind.png" width="300">

[source](https://en.wikipedia.org/wiki/Color_blindness)


### Consider colour-blind or printer-friendly palettes


R Code
{: .label .label-green }
```R
display.brewer.all(n = NULL, type = "all", select = NULL, colorblindFriendly = TRUE)
```


R Code
{: .label .label-green }
```R
tm_shape(vancouver_boundaries) + 
  tm_polygons("income_100k",
              palette = "GnBu",  breaks= brks$brks, 
              title="Income (%)", border.col = "white") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside=TRUE)
```


### Recap

- `tm_shape` defines the dataset for plotting
- `tm_polygons` draws polygon shapes based on the dataset provided
- `tm_lines` draws lines based on the dataset provided
- `tm_dots` draws dot shapes based on the dataset provided
- `tm_text` adds text in the map
- `tm_add_legend` manually add labels and text for the legend component of the map