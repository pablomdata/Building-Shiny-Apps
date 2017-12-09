# Maps in R



# Leaflet
 
Leaflet is a very popular open-source JavaScript library for interactive maps. It's used by a number of organizations around the globe, including GIS specialists (for instance, OpenStreetMap). 

Let's load an example file (use a separate R script for this)
 
```{r, eval=TRUE, echo=TRUE}
library(leaflet)

coords <- read.csv("./dashboard_app/coords.csv")

head(coords)

```

Let's create a map out of these coordinates:

```{r}

coords %>% 
      leaflet %>% 
      addTiles() %>% 
      addMarkers(~Long, ~Lat, popup = ~as.character(Destino))

```


We can specify the zoom level and the center of the view:

```{r}

coords %>% 
      leaflet %>% 
      setView(lng=-101.1950 , lat=19.7060, zoom=6) %>%
      addTiles() %>% 
      addMarkers(~Long, ~Lat, popup = ~as.character(Destino))

```

Maps created with Leaflet can be used seamlessly in Shiny, 
using the functions `renderLeaflet` and `leafletOutput` in `server.R` and `ui.R` respectively.



