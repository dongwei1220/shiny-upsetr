###################################################################################################
# Author: Wei Dong
# Email: dongw26@mail2.sysu.edu.cn
# Github: https://github.com/dongwei1220
###################################################################################################
# 
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
##### Installing required packages #####
# install.packages("shiny")
# install.packages("shinydashboard")
# install.packages("UpSetR")
# install.packages("DT")
# install.packages("ggplot2")

##### Loading required packages #####
library(shiny)
library(shinydashboard)
library(UpSetR)
library(DT)
library(ggplot2)

##### Set globle options #####
options(shiny.maxRequestSize=100*1024^3) #100G
options(encoding = "UTF-8")
options(stringsAsFactors = FALSE)
rm(list=ls())

input_data <- read.table("data/moive.txt", header = T,sep = "\t")
#input_data <- read.csv( system.file("extdata", "movies.csv", package = "UpSetR"), header=TRUE, sep=";" )

###################################################################################################
### dashboardHeader for header ----
header <- dashboardHeader(
  title = "Shiny UpSetR",
  titleWidth = 300,
  disable = F)

# dashboardSiderbar for inputs ----
sidebar <- dashboardSidebar(
  width = 300,
  collapsed = FALSE,
  
  fileInput(
    inputId = 'infile', 
    label = h5('Choose Multiple Set File'),
    multiple = F,
    accept=c('.txt', 'txt'),
    buttonLabel = "Browse",
    placeholder = "No file selected"
  ),
  
  sliderInput(
    inputId = "nSets",
    label = h5("Number of sets to look at"),
    min = 1,
    max = 10,
    value = 5,
    step = 1,
    round = T,
    ticks = T,
    animate = T,
    width = NULL
  ),
  
  radioButtons(
    inputId = "keepOrder",
    label = h5("Keep order"),
    choices = c("TRUE","FALSE"),
    selected = "FALSE"
  ),
  
  selectInput(
    inputId = "orderBy", 
    label = h5("Order by:"), 
    choices = c("freq","degree"), 
    multiple = F,
    selected = "freq"
  ),
  
  selectInput(
    inputId = "groupBy", 
    label = h5("Group by:"), 
    choices = c("degree","sets"), 
    multiple = F,
    selected = "degree"
  ),
  
  textInput(
    inputId = "yLabel",
    label = h5("Y-axis Label:"),
    value = "Genre Intersections",
    width = NULL,
    placeholder = "Please input y-axis title"
  ),
  
  textInput(
    inputId = "xLabel",
    label = h5("X-axis Label:"),
    value = "Movies Per Genre",
    width = NULL,
    placeholder = "Please input x-axis title"
  ),
  
  selectInput(
    inputId = "sets", 
    label = h5('Selected Sets:'), 
    choices = names(input_data), 
    multiple = TRUE
  ),
  
  tags$div(
    actionButton(
      inputId = "submitButton", 
      label = "Submit", 
      icon= icon("arrow-up"),
      style="color:#fff;background-color:#337ab7;border-color:#2e6da4"), 
    align="center"),
  
  tags$p(
    helpText("Click the button to update the value displayed in the plot."), 
    align="center")
)

### dashboardBody for displaying outputs ----
body <- dashboardBody(
  style = "background-color:#ffffff;padding:10px;",
  fluidRow(
    ### Plot panel ###
    box(title = "Plot panel", 
        solidHeader = TRUE, 
        status = "primary",
        width = 10, height = 850, 
        collapsible = TRUE,
        tabsetPanel(
          tabPanel(title = "Plot",
                   fluidRow(
                     column(width = 12,
                            plotOutput(
                              outputId = "Plot",
                              height = 720),
                            #helpText("download the plot!"),
                            tags$p(
                              downloadButton(
                                outputId = "download1",
                                label = "Download"),
                              align="right")
                            )
                     )
                   ),
          tabPanel(title = "DataSet",
                   fluidRow(
                     column(width = 12,
                            DT::dataTableOutput('dataSet'),
                            hr(),
                            tags$p(
                              downloadButton(
                                outputId = "download2",
                                label = "Download"),
                              align="right")
                            )
                     )
                   )
          )
        ),
    ### Parameter panel ###
    box(title = "Parameter panel", 
        solidHeader = TRUE, status = "warning", 
        collapsible = TRUE, width = 2, height = 850,
        
        sliderInput(
          inputId = "size1", 
          label = h4("Point size:"),
          min = 0,
          max = 5,
          value = 3,
          step = 0.5),
        
        sliderInput(
          inputId = "size2", 
          label = h4("Line size:"),
          min = 0,
          max = 2,
          value = 1,
          step = 0.2),
        
        sliderInput(
          inputId = "size3", 
          label = h4("Font size:"),
          min = 0,
          max = 2,
          value = 1.4,
          step = 0.2),
        
        selectInput(
          inputId = "color1", 
          label = h4("Main bar color:"),
          choices = c(
            "Red" = "red","Blue" = "blue","Green" = "green",
            "Pink" = "pink","Purple" = "purple","Yellow" = "yellow",
            "Cyan" = "cyan","Maroon" = "maroon","Orange" = "orange",
            "Black" = "black","Magenta" = "magenta","Orchid" = "orchid",
            "Brown" = "brown","Grey" = "grey","Salmon"="salmon"), 
          selected = "black"),

        selectInput(
          inputId = "color2", 
          label = h4("Sets bar color:"),
          choices = c(
            "Red" = "red","Blue" = "blue","Green" = "green",
            "Pink" = "pink","Purple" = "purple","Yellow" = "yellow",
            "Cyan" = "cyan","Maroon" = "maroon","Orange" = "orange",
            "Black" = "black","Magenta" = "magenta","Orchid" = "orchid",
            "Brown" = "brown","Grey" = "grey","Salmon"="salmon"), 
          selected = "red"),

        selectInput(
          inputId = "color3",
          label = h4("Matrix color:"),
          choices = c(
            "Red" = "red","Blue" = "blue","Green" = "green",
            "Pink" = "pink","Purple" = "purple","Yellow" = "yellow",
            "Cyan" = "cyan","Maroon" = "maroon","Orange" = "orange",
            "Black" = "black","Magenta" = "magenta","Orchid" = "orchid",
            "Brown" = "brown","Grey" = "grey","Salmon"="salmon"), 
          selected = "blue"),
        
        selectInput(
          inputId = "color4",
          label = h4("Matrix shading color:"),
          choices = c(
            "Red" = "red","Blue" = "blue","Green" = "green",
            "Pink" = "pink","Purple" = "purple","Yellow" = "yellow",
            "Cyan" = "cyan","Maroon" = "maroon","Orange" = "orange",
            "Black" = "black","Magenta" = "magenta","Orchid" = "orchid",
            "Brown" = "brown","Grey" = "grey","Salmon"="salmon"), 
          selected = "purple")
    )
  ),
  # set the footer
  tags$footer(
    p(strong(h4("Contact: Wei Dong <dongw26@mail2.sysu.edu.cn>"))), 
    align="center")
)

###################################################################################################
# Define UI for Shiny UpSetR
ui <- dashboardPage(
  skin = "green",
  header, 
  sidebar, 
  body
  )

###################################################################################################
# Define server logic to plot various plots ----
server <- function(input, output){
  
  setsSelected <- eventReactive(
    input$submitButton, {
      input$sets
    })

  dataContent <- reactive({
    inFile <- input$infile
    
    if (is.null(inFile)){
      input_data <- input_data
      #return(NULL)
    }else{
      input_data <- read.table(inFile$datapath,header = T,sep = "\t",check.names = F)
    }
    input_data
  })
  
  ##################################################################################
  ##### Basic plots #####
  # Plot the Basic Plot
  output$Plot <- renderPlot({
    if (is.null(input$sets)){
      p <- upset(data = input_data, 
                 nsets = input$nSets,
                 number.angles = 30,
                 keep.order = input$keepOrder,
                 point.size = input$size1,
                 line.size = input$size2, 
                 mainbar.y.label = input$yLabel, 
                 sets.x.label = input$xLabel, 
                 mb.ratio = c(0.6, 0.4), 
                 main.bar.color = input$color1,
                 sets.bar.color = input$color2,
                 matrix.color = input$color3,
                 shade.color = input$color4,
                 text.scale = input$size3,
                 order.by = input$orderBy,
                 group.by = input$groupBy)
    }else{
      p <- upset(data = input_data, 
                 sets = setsSelected(),
                 number.angles = 30, 
                 keep.order = input$keepOrder,
                 point.size = input$size1,
                 line.size = input$size2, 
                 mainbar.y.label = input$yLabel,
                 sets.x.label = input$xLabel,
                 mb.ratio = c(0.6, 0.4), 
                 main.bar.color = input$color1,
                 sets.bar.color = input$color2,
                 matrix.color = input$color3,
                 shade.color = input$color4,
                 text.scale = input$size3,
                 order.by = input$orderBy,
                 group.by = input$groupBy)
    }
    p
  })
  
  # Download the Basic Plot
  output$download1 <- downloadHandler(
    filename = function(){
      paste0("UpSetPlot-", Sys.Date(), ".pdf")
    },
    contentType = "image/pdf",
    content = function(file){
      pdf(file, onefile = F,width = 16,height = 8)
      if (is.null(input$sets)){
        p <- upset(data = input_data, 
                   nsets = input$nSets,
                   number.angles = 30,
                   keep.order = input$keepOrder,
                   point.size = input$size1,
                   line.size = input$size2, 
                   mainbar.y.label = input$yLabel, 
                   sets.x.label = input$xLabel, 
                   mb.ratio = c(0.6, 0.4), 
                   main.bar.color = input$color1,
                   sets.bar.color = input$color2,
                   matrix.color = input$color3,
                   shade.color = input$color4,
                   text.scale = input$size3,
                   order.by = input$orderBy,
                   group.by = input$groupBy)
      }else{
        p <- upset(data = input_data, 
                   sets = setsSelected(),
                   number.angles = 30, 
                   keep.order = input$keepOrder,
                   point.size = input$size1,
                   line.size = input$size2, 
                   mainbar.y.label = input$yLabel,
                   sets.x.label = input$xLabel,
                   mb.ratio = c(0.6, 0.4), 
                   main.bar.color = input$color1,
                   sets.bar.color = input$color2,
                   matrix.color = input$color3,
                   shade.color = input$color4,
                   text.scale = input$size3,
                   order.by = input$orderBy,
                   group.by = input$groupBy)
      }
      print(p)
      dev.off()
  })
  
  # View ad download the DateSets
  output$dataSet <- DT::renderDataTable({
    dataContent()
  },
  options = list(
    pageLength = 15,
    lengthMenu = c("10","25","50","100"),
    initComplete = I("function(settings, json) {alert('Done.');}")
  )
  )
  
  output$download2 <- downloadHandler(
    filename = function(){
      paste0("UpSetDataSet-", Sys.Date(), ".csv")
    },
    content = function(file){
      write.csv(dataContent(), file, row.names = FALSE)
    }
  )
}

###################################################################################################
### Create Shiny app ----
shinyApp(ui = ui, server = server)

