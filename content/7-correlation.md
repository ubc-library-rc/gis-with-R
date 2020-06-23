---
layout: default
title: Spatial correlation
parent: Outline
nav_order: 6
---

## Income for every Neighbourhood


R Code
{: .label .label-green }
```R
brks <- classIntervals(vancouver_boundaries$income_100k, n = 5, style = "quantile")
plt1 <- tm_shape(vancouver_boundaries) + 
  tm_polygons("income_100k", border.col = "white", palette = "GnBu", breaks= brks$brks, title="Income") +
  tm_text("mapid", just = "center", size = 0.8) +
  tm_legend(outside=TRUE)
plt1
```


## Services for every Neighbourhood

R Code
{: .label .label-green }
```R
brks <- classIntervals(vancouver_boundaries$all_services, n = 5, style = "quantile")
plt2 <- tm_shape(vancouver_boundaries) + 
  tm_polygons("all_services", border.col = "white", palette = "Oranges", breaks= brks$brks, title="Services") +
  tm_text("all_services", just = "center", size = 0.8) +
  tm_legend(outside=TRUE)
plt2
```


## Images side by side

Output
{: .label .label-yellow }
<img src="{{site.baseurl}}/content/fig/plot8.png">





TODO
{: .label .label-green }






### Recap

- `filter` filter a dataset based on some condition
- `st_intersects` binds a polygon area to a set of points
- `classIntervals` divides data into buckets
