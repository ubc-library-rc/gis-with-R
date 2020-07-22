---
layout: default
title: Setup
nav_order: 0
---
## Introduction to Spatial Data Analysis with R

Do you want to learn Spatial Data Analysis but don't know where to start? This workshop is for you! 


R is a popular programming language for data analysis specially suited for statistical computing and data plotting.  This introductory level workshop discusses basic commands of the programming language and it is specially tailored 
for using R in conjunction with Geographic Information Systems, e.g., [QGIS](https://www.qgis.org/en/site/).




## Goal of this workshop

Our goal is to **begin** to understand and use R for spatial data analysis. You will not be an expert by the end of the class. You will probably not even feel very comfortable using R. This is okay. We want to make a start but, as with any skill, using R takes practice.


At the end of the workshop, we expect that you can:

* understand the basic commands of R and how to use RStudio environment;

* know the basic data structures available for GIS;

* load, preprocess, and explore spatial data in R; and

* apply basic operations for creating and extending map data with R

* recognize how the methodology hereby applied extend to other disciplines


__

### Pre-workshop setup 

Have your laptop with the R and RStudio installed **before** the workshop.

*1*{: .circle .circle-blue} Download and install R:

* Visit [R-project](https://www.r-project.org) to learn about R versions.

* Download and install R from your preferred [CRAN Mirror here](https://cran.r-project.org/mirrors.html).

If you already have R installed, make sure it is the R version 4.0.2
{: .danger}

*2*{: .circle .circle-blue} Download and install RStudio:

* Visit the [RStudio](https://www.rstudio.com/products/rstudio/download/#download) web page to choose the RStudio version you want to download and install.

*3*{: .circle .circle-blue} Download and install RStudio:

* On Windows make sure you have the newest version of R available `R version 4.0.2`

* On MacOS install it with `brew install libxml2` and `brew install gdal`

* On Linux follow [this tutorial](https://geocompr.github.io/post/2020/installing-r-spatial-ubuntu/)

*4*{: .circle .circle-blue} Install the required packages:

* Open R studio

* Copy the command below
```
list.of.packages <- c(
    "dplyr", "ggplot2", "raster", "rgdal", "rasterVis", "sf", "tmap", "spatstat", 
    "maptools", "spdep", "classInt", "RColorBrewer", "maptools"
)
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
```

<img src="{{site.baseurl}}/content/fig/packages.png">

* Press `enter` and make sure to check for installation options, e.g., having to type `Y` to accept some software license

    * If you encounter problems installing `tmap` on Windows, try a fresh install of the R environment.

* Verify if everything was installed correctly by running `library(tmap)`

    * If there is an error message, you might want to troubleshoot your installation.

*5*{: .circle .circle-blue} Take a look at this video on [Getting started with R and RStudio](https://www.youtube.com/watch?v=lVKMsaWju8w) 

*6*{: .circle .circle-blue} Download the data required [Download](https://github.com/ubc-library-rc/gis-with-R/raw/master/gis_with_R.zipp){: .btn .btn-blue } 

