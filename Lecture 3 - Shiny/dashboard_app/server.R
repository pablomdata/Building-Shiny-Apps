#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


shinyServer(function(input, output) {
   
  ## We use reactive objects to avoid recomputing things
  ## that did not change. This affects the performance in 
  ## more complicated apps
  
  activity <- reactive({
    act_df %>% 
      filter(grepl(input$year, Periodo))
  })
  
  ### Each output$ object is associated to a renderX function, 
  ### so for rendering ggplot/standard R plots we use renderPlot(),
  ## for plotly plots we use renderPlotly(), renderDataTable() for data tables, etc
  
  output$bpDV <- renderPlotly({
    gg <- activity()%>%
      ggplot(aes(x=Destino, y=Visitantes/1000, fill = Destino))+
      geom_boxplot()+theme_bw()
    
    ggplotly(gg)  
  })
  
  
  ############## 
  
  output$pctChart <- renderPlotly({
    gg <-  activity()%>%
      ggplot(aes(x=Destino,
                 y=Porcentaje.Ocupacion.promedio, 
                 color = Destino))+
      geom_point(position = "jitter")+theme_bw()
    ggplotly(gg)
  })
  
  avgVisitors <- reactive({
    avgVisitors <-  activity() %>%
      filter(grepl(input$year,Periodo)) %>% 
      group_by(Destino) %>%
      summarise(LocalPct=100*mean(Nacional/Visitantes)
                , ForeignPct = 100*mean(Internacional/Visitantes)) 
  })
  
  
  output$barPlots <- renderPlotly({
    
    gg <- avgVisitors() %>%
      ggplot(aes(x=LocalPct, y=ForeignPct, color=Destino))+
      geom_point()+geom_abline(intercept = 0,slope=1, linetype="dotted")+
      xlim(0,100)+ylim(0,100)+xlab("Local Visitors")+ylab("Foreign Visitors")+theme_bw()
    ggplotly(gg)
  })
  
  
  output$revPlot <- renderPlotly({
    gg <- rev_df %>% filter(!grepl("Total ",CIP), 
                            grepl(input$year,Periodo) ) %>% 
      ggplot(aes(x=Periodo,y=Millones.de.dolares, fill=CIP))+
      geom_bar(stat = 'identity')+coord_flip()+theme_bw()
    ggplotly(gg)
  })
  
})
