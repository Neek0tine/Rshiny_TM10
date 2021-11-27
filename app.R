  library(shiny)
  library(shinydashboard)
  library(shinythemes)
  
  
  
  ui <- dashboardPage(skin = "green",
      dashboardHeader(title = "Kelompok 3"),
      
      dashboardSidebar(
        sidebarMenu(
        
          menuItem("Data", 
            tabName = "data", 
            icon = icon("database")
          ),
        
          menuItem("Visualisasi", 
            tabName = "visualisasi", 
            icon = icon("th")
          ),
        
          menuItem("Interpretasi", 
            tabName = "interpretasi", 
            icon = icon("align-left")
          )
        ) # sidebar menu closing
      ), # dashboard sidebar closing
      
  
      dashboardBody(
      
        tabItems(
          tabItem("data",
                  
            fluidPage(
              title = "Dataset",
                
              fluidRow(
                imageOutput("picture", height="auto"),
                h1("Pokemon Dataset"),
                br(),
                p("Paragraph")
              )
            )
          ),
          
          tabItem("visualisasi"),
          
          tabItem("interpretasi")
          
        ) # tabItems closing
      ) # dashboardBody closing
    ) # dashboardPage closing
          
  
  server <- function(input, output) {
    
    output$picture <- renderImage({
      list(src = ".//dataset-cover.png",
           contentType = 'image/png',
           alt = paste("Test"))
      
    }, deleteFile = FALSE)
  }
  
  shinyApp(ui, server)
  
