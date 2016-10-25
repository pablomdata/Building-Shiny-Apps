#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Diamond data"),
   
   
   sidebarLayout(
      sidebarPanel(
         selectInput("cut", "Select cut: ", choices = as.character(levels(diamonds$cut)), selected = "Ideal"), 
         sliderInput("bins", "Select number of bins", min=5, max=50, value=20)
      ),
      
      
      mainPanel(
        plotlyOutput("priceDist")
              )
   )
))


# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
   
   output$priceDist <- renderPlotly({
     g <- diamonds %>% filter(cut==input$cut) %>% ggplot(aes(x=price, fill=color))+geom_histogram(bins=input$bins)
     ggplotly(g)
     

   })
})

# Run the application 
shinyApp(ui = ui, server = server)




