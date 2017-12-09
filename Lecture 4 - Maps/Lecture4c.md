---
title: "Choropleths"
output: html_notebook
---

**Chropleths** are maps in which the areas are shaded (or something is drawn into them) in proportion of a measurement being displayed.

```{r}

library(rgdal)
library(rgeos)
library(maptools)



## TRENDS BY STATE (Lecture 4)
mexico <- readOGR(dsn="./dashboard_app/",layer ="mexstates", encoding = "UTF-8")
hoteles <- read.csv("./dashboard_app/hoteles.csv") 
hoteles[3:9] <- sapply(hoteles[3:9], function(x) as.numeric(as.character(x))/1000)

```


## Shapefiles

This file format was introduced with ArcView GIS in the early 90s. On its current iteration is possible to read and write geographical datasets 
with a variety of software, including open-source software like R.

The term "shapefile" is a bit misleading, because the file format consists of actually three compulsory files:

- *.shp*: The shapefile, the geometry features itself.
- *.shx*: A positional index of the feature geometry that allows to look information backward and forward quickly.
- *.dbf*: Columnar attributes for each shape, in dBase IV format (one of the oldest database formats!). 

Other files might be present, which describe other geographical indices and other information.

Let's take a look at the data we loaded:

```{r}
head(hoteles)
```

We will keep 

```{r}
## POZOR: Use mutate_ in Shiny!

hotels2014 <- hoteles%>% 
          filter(Ano==2014) %>%
          rename(id=Estado) %>% 
          mutate(indicator = Total_Visitors)

head(hotels2014)

```


The shapefile object has a data frame, which is accessible via `@data`:

```{r}
head(mexico@data)
```

## Choropleth maps in Leaflet

It often happens, as in this case, that we do not have the data we want to plot readily available in the shapefile, so we need to get it somehow. This is simple to do:

```{r, warning=FALSE}

mexico@data <- left_join(mexico@data,hotels2014, by= c("ADMIN_NAME"="id"))
```

Now we are ready to plot. Note that we can add custom HTML formating to our map.

```{r}

state_popup <- paste0("<strong>Estado: </strong>", 
                      mexico@data$ADMIN_NAME, 
                      "<br><strong>Total Visitors in 2014: </strong>", 
                      mexico@data$Total_Visitors)

leaflet(data=mexico)%>%
  addProviderTiles("CartoDB.Positron")%>%
  addPolygons(fillColor = ~pal(as.numeric(as.character(mexico$Occupation_Pct))), 
              fillOpacity = 0.8, 
              color = "#BDBDC3", 
              weight = 1, 
              popup = state_popup)
  
```


## Choropleth maps in ggplot2

It's also possible to use the geographic information from the shapefile to get non-interactive maps in `ggplot`. 

```{r}

library(ggplot2)
library(plotly)
library(rgdal)
library(rgeos)
library(maptools)


## TRENDS BY STATE (Lecture 4)
mexico <- readOGR(dsn="./dashboard_app/",layer ="mexstates", encoding = "UTF-8")
hoteles <- read.csv("./dashboard_app/hoteles.csv") 
hoteles[3:9] <- sapply(hoteles[3:9], function(x) as.numeric(as.character(x))/1000)
mx <- fortify(mexico, region = "ADMIN_NAME" ) # Convert object to data frame

plotData <- left_join(mx,hotels2014)

head(plotData)
    
    
```

And now we can generate the map as any other `ggplot` object!




```{r}
    gg <- plotData %>% 
      ggplot(aes(x=long, y=lat, group=group, fill=indicator))+
      geom_polygon()+
      theme(axis.line=element_blank(),axis.text.x=element_blank(),
            axis.text.y=element_blank(),axis.ticks=element_blank(),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(), #legend.position="none",
            panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),plot.background=element_blank())
    
    ggplotly(gg)
```


