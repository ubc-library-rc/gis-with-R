---
layout: default
title: Numerical data
has_children: true
has_toc: false
nav_order: 6
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




## Adding Census Data to our Variable

When we write `vancouver_boundaries$ ... ` you can replace the `...` by a field available in your dataset to check its values.

You can also create a new field if it doesn't exist:

R Code
{: .label .label-green }
```R
vancouver_boundaries$income_100k <- income_100k * 100
vancouver_boundaries$income_30k <- income_30k * 100
```


## *1*{: .circle .circle-blue} Dividing Data into Buckets

We want to divide the income into buckets so it is easier to identify different populations. We can do that with the `classIntervals` function

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


## *2*{: .circle .circle-blue} Plotting Income Data

Now that we have intervals and numerical data, i.e., `income_100k`, we can use that in our plot to quickly identify regions 
in each bucket.


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


Choropleth maps
{: .label .label-yellow }
**Choropleth maps** (choro = area and pleth = value)  aggregates some attribute (e.g., income) over a defined area (e.g., neighborhoods)

___


### Is anything Wrong with this Map?

<img src="{{site.baseurl}}/content/fig/watch.png" width="200">

<br>
<br>
<br>

<img src="{{site.baseurl}}/content/fig/colour-blind.png" width="300">

[source](https://en.wikipedia.org/wiki/Color_blindness)


### *3*{: .circle .circle-blue} Consider colour-blind or printer-friendly palettes


R Code
{: .label .label-green }
```R
display.brewer.all(n = NULL, type = "all", select = NULL, colorblindFriendly = TRUE)
```

*4*{: .circle .circle-blue} We can change the `palette` of our map accordingly 


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

___

### Recap

*1*{: .circle .circle-blue} `classIntervals` divides the data into intervals

*2*{: .circle .circle-blue} `tm_polygons` can use numerical data as one of its parameters, the `breaks` parameter divides the data according to the intervals we have defined

*3*{: .circle .circle-blue} `display.brewer.all` displays different colours palettes

*4*{: .circle .circle-blue} `palette` sets a specific palette to our plot