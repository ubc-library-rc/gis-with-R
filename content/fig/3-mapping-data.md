---
layout: default
title: Mapping data in R
parent: Outline
nav_order: 3
---

## Plotting a Basic Map


R Code
{: .label .label-green }
```R
tm_shape(vancouver_boundaries) + 
  tm_polygons(col="grey", border.col = "white")
```



## Adding Meta-Data


What data is available?

R Code
{: .label .label-green }
```R
colnames(vancouver_boundaries)
```

R Code
{: .label .label-green }
```R
tm_shape(vancouver_boundaries) + 
  tm_polygons(col="name", border.col = "white") +
  tm_legend(outside=TRUE)
```

Output
{: .label .label-yellow }
<img src="{{site.baseurl}}/content/fig/plot1.png">


## Improving Aesthetics

Step-by-step:


R Code
{: .label .label-green }
```R
# adding meaningfull names
tm_shape(vancouver_boundaries) + 
  tm_polygons(col="name", border.col = "white", title="neighbourhood") +
  tm_legend(outside=TRUE) +
  tm_layout(main.title="City of Vancouver", main.title.position = "left")
```


R Code
{: .label .label-green }
```R
# changing the colour palette
tm_shape(vancouver_boundaries) + 
  tm_polygons(col="name", border.col = "white", title="neighbourhood", palette = "Pastel1") +
  tm_legend(outside=TRUE) +
  tm_layout(main.title="City of Vancouver", main.title.position = "left")
```


R Code
{: .label .label-green }
```R
tm_shape(vancouver_boundaries) +
  tm_polygons(col="name", border.col = "white", title="neighbourhood", palette = "Pastel1") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside=TRUE) +
  tm_layout(main.title="City of Vancouver", main.title.position = "left")
```


## Combining Layers



R Code
{: .label .label-green }
```R
tm_shape(vancouver_boundaries) +
  tm_polygons(col="name", border.col = "white", title="neighbourhood", palette = "Pastel1") +
tm_shape(transit_routes) +
  tm_lines(col="grey70", size=.1) +
  tm_legend(outside=TRUE) +
  tm_layout(main.title="City of Vancouver", main.title.position = "left")
```



Output
{: .label .label-yellow }
<img src="{{site.baseurl}}/content/fig/plot2.png">


R Code
{: .label .label-green }
```R
tm_shape(vancouver_boundaries) +
  tm_polygons(col="name", border.col = "white", title="neighbourhood", palette = "Pastel1") +
tm_shape(schools) + 
  tm_dots(col="red", size=.1, shape=18) +
  tm_legend(outside=TRUE) +
  tm_add_legend(
    type = "symbol", 
    shape=c(18), 
    labels=c("Schools"),
    col=c("red")) +  
  tm_layout(main.title="City of Vancouver", main.title.position = "left")
```

Shape codes
{: .label .label-yellow }

<img src="{{site.baseurl}}/content/fig/shapes.png" width="300">

[source](http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r)


### Recap

- `tm_shape` defines the dataset for plotting
- `tm_polygons` draws polygon shapes based on the dataset provided
- `tm_lines` draws lines based on the dataset provided
- `tm_dots` draws dot shapes based on the dataset provided
