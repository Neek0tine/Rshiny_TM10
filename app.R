library(shiny)
library(shinydashboard)
library(ggplot2)



ui <- dashboardPage(
  dashboardHeader(title = "Kelompok 3"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Data", tabName = "data", icon = icon("dashboard")),
      menuItem("Visualisasi", tabName = "visualisasi", icon = icon("th"))
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "data",
              fluidRow(
                box(
                  fileInput("file1", "Choose CSV File",
                            multiple = TRUE,
                            accept = c("text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv")),
                  tags$hr(),
                  radioButtons("disp", "Display",
                               choices = c(Head = "head", All = "all"),
                               selected = 'head')
                ),
                
                box(
                  div(style = 'overflow-x: scroll', tableOutput('contents'))
                )
              )
      ),
      # Second tab content
      tabItem(tabName = "visualisasi",
              fluidRow(
                box(plotOutput("plot1")),
                
                box(
                  title = "Controls",
                  sliderInput("bins", "Number of bins:", 1, 50, 25)
                )
                ,
                
                box(
                  selectInput("variable", "Variable:",
                              c(
                                "Total" = "Total",
                                "HP" = "HP",
                                "Attack" = "Attack",
                                "Defense" = "Defense",
                                "Special Attack" = "Sp.Atk",
                                "Special Defense" = "Sp.Def",
                                "Speed" = "Speed"),
                              selected = 'Total')
                  
                )
              )
      )
    )
  )
)


options(shiny.maxRequestSize=30*1024^2)
server <- function(input, output) {
  
  output$contents = renderTable({
    req(input$file1)
    
    df = read.csv(input$file1$datapath)
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
    
  })
  
  output$plot1 = renderPlot({
    df = read.csv(input$file1$datapath)
    #data = df[[input$variable]]
    
    #bins = seq(min(data), max(data), length.out = input$bins+1)
    
    plot_histogram = ggplot(df, aes_string(x=input$variable)) + 
                    geom_histogram(bins = input$bins, fill='khaki', colour='black') + 
                    theme_bw() +
                    labs(title = paste("Distribution of Variable", input$variable)) +
                    theme(
                      plot.title = element_text(size=18, face = 'bold', hjust=0.5)
                    )
    plot_histogram
  })
  
  
  
}
shinyApp(ui, server)