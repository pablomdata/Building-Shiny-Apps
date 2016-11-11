---
title: "Lecture 4b: Reactive expressions in maps"
output: html_notebook
---

Let's try something else with the maps, to complete the next part of the wireframe.


```{r}
library(leaflet)
library(dplyr)
unesco <- read.csv('./dashboard_app/unesco.csv')
unesco %>% select(name_en, longitude,latitude)%>%head
```


So we can very easily create the map with markers as before.


```{r}
unesco %>% 
      leaflet %>% setView(lng = -99.1013, lat = 19.2465, zoom = 5) %>%
      addTiles() %>%
      addMarkers(~longitude, ~latitude #, popup = ~as.character(name_en)
                 )
    
```

The tiles for these maps are coming from OpenStreetMaps. Since it's quite heavy to load over and over again we need to "preload" the map if we would like this map to change the map to user's reaction. In code, we need to do something like this:


```{r, eval=F, echo=T}

library(shiny)
library(leaflet)

############################  UI LOGIC ############################
ui <- fluidPage(
      leafletOutput("unescoMap"), selectInput("site", 
                            "Select a site", 
                            choices = levels(unesco$name_en), 
                            selected = levels(unesco$name_en)[2]))

############################  SERVER LOGIC ############################
server <- function(input,output,session){
 # The standard map we had, no surprises
  output$unescoMap <- renderLeaflet({
    unesco %>% 
      leaflet %>% setView(lng = -99.1013, lat = 19.2465, zoom = 5) %>%
      addTiles() %>%
      addMarkers(~longitude, ~latitude, popup = ~as.character(name_en))
    
  })
  
  ## A reactive object: filtering out the data from the chosen site
  chosenSite <- reactive({
    desc <- unesco%>%filter(name_en==input$site)
    desc
  })
  
  
  ## An observer event for the map: This looks on what has changed on the map and redraws accordingly
  observe({
    proxy <- leafletProxy("unescoMap", data=chosenSite())%>%
        removeMarker("chosen")%>%
      addCircleMarkers(~longitude, ~latitude,
                       color = "red", stroke = F,
                       fillOpacity = 0.7,
                       popup = ~as.character(name_en), layerId = "chosen")
  })
 
}

shinyApp(ui, server)

```


