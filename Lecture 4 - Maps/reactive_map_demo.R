library(shiny)
library(leaflet)

############################ UI LOGIC ############################
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
   leafletProxy("unescoMap", data=chosenSite())%>%
      removeMarker("chosen")%>%
      addCircleMarkers(~longitude, ~latitude,
                       color = "red", stroke = F,
                       fillOpacity = 0.7,
                       popup = ~as.character(name_en), layerId = "chosen")
  })
  
}

shinyApp(ui, server)