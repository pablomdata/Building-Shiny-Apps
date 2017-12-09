dashboardPage(skin = "green",

  dashboardHeader(title = "Tourism in Mexico")
  
  , dashboardSidebar(
    sidebarMenu(
      menuItem("NEXT TIME", tabName = "tab1", icon = icon("archive"))
      , menuItem("Beach Tourism", tabName = "tab2", 
                 icon = icon("camera",  lib="glyphicon"))
      , selectInput("year", "Select year", 
                    choices = c("2016","2015","2014","2013"), selected = "2016")
    )  
  )
  
  , dashboardBody(
    tabItems(
      
      tabItem(tabName = "tab1"
              
      )
      
      , tabItem(tabName = "tab2", 
              fluidRow(
                  tabBox(
                    title = "Occupation"
                    , tabPanel("Absolute", 
                               plotlyOutput("bpDV"))
                    , tabPanel("Relative",
                               plotlyOutput("pctChart"))
                    , tabPanel("Domestic vs Foreign", plotlyOutput("barPlots"))
                  )
                  , 
                  box(status="danger",solidHeader = T,
                      title = "Revenue in USD", plotlyOutput("revPlot")
                  )
                  
                , box(status = "danger",  solidHeader = T, title = "Occupation by State")
              )
              
      )
      
      
    )  
  )  
  
)

