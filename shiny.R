## First Shiny

library(shiny)
runExample("01_hello")


## Shiny App의 구조

library(shiny)

ui <- fluidPage(
  titlePanel("Hello Shiny!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(...)
    ),
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({...})
}

shinyApp(ui = ui, server = server)


## R에서 기능 만들기

library(dplyr)
library(ggplot2)

fileURL <- "https://github.com/zarathucorp/R4CR-content/raw/main/example_g1e.csv"
v <- read.csv(fileURL)

summary(v$EXMD_BZ_YYYY)

selectYear = 2010
v2 <- v %>% 
  filter(EXMD_BZ_YYYY == selectYear)

summary(v2$HGHT)

v2 %>% 
  ggplot(aes(x = HGHT, y = WGHT)) +
  geom_point()


## UI 만들기 3

ui <- fluidPage(
  fileInput(
    inputId = 'file', # 입력값 구분
    label = 'upload' # 어떻게 보일지
  ),
  selectInput(
    inputId = 'year', 
    label = 'select Year',
    choices = 2009:2015
  )
)

server<- function(input, output, session){
  
}

shinyApp(ui = ui, server = server)


## UI 만들기 4

server<- function(input, output, session){
  observeEvent(input$file, {
    fileObj <- input$file
    v <- read.csv(fileObj$datapath)
    print(dim(v))
  })
}

shinyApp(ui = ui, server = server)

## UI 만들기 5

server<- function(input, output, session){
  v <- ''
  
  observeEvent(input$file, {
    fileObj <- input$file
    v <<- read.csv(fileObj$datapath)
    print(dim(v))
  })
  
  observeEvent(input$year, {
    req(v)
    print(input$year)
    v2 <- v %>% 
      filter(EXMD_BZ_YYYY == input$year)
    print(head(v2))
  })
  
}

shinyApp(ui = ui, server = server)

## UI 만들기 6

ui <- fluidPage(
  fileInput(
    inputId = 'file', # 입력값 구분
    label = 'upload' # 어떻게 보일지
  ),
  selectInput(
    inputId = 'year', 
    label = 'select Year',
    choices = 2009:2015
  ),
  plotOutput(outputId = 'plot')
)

server<- function(input, output, session){
  v <- ''
  
  observeEvent(input$year, {
    req(v)
    
    v2 <- v %>% 
      filter(EXMD_BZ_YYYY == input$year)
    
    output$plot <- renderPlot({
      v2 %>%
        ggplot(aes(x = HGHT, y = WGHT)) +
        geom_point()
    })
    
  })
  
}

shinyApp(ui = ui, server = server)

## Layout

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h3("Sidebar Panel"),
      fileInput(
        inputId = 'file', 
        label = 'upload'
      ),
      selectInput(
        inputId = 'year', 
        label = 'select Year',
        choices = 2009:2015
      )
    ),
    mainPanel(
      h3("Main Panel"),
      plotOutput(
        outputId = 'plot'
      )
    )
  )
)

shinyApp(ui = ui, server = server)


## Reactivity

ui <- fluidPage(
  textInput('input', "label"),
  textOutput('output')
)

server <- function(input, output, session){
  observeEvent(input$input, { # 1.
    output$output <- renderText(input$input) # 3.
  })
}

server <- function(input, output, session){
  inputText <- reactive({ # 2.
    input$input
  })
  output$output <- renderText(inputText()) # 3.
}



## APP.R

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      h3("Sidebar Panel"),
      fileInput(
        inputId = 'file', 
        label = 'upload'
      ),
      selectInput(
        inputId = 'year', 
        label = 'select Year',
        choices = 2009:2015
      )
    ),
    mainPanel(
      h3("Main Panel"),
      plotOutput(
        outputId = 'plot'
      )
    )
  )
)

server<- function(input, output, session){
  v <- ''
  
  observeEvent(input$year, {
    req(v)
    
    v2 <- v %>% 
      filter(EXMD_BZ_YYYY == input$year)
    
    output$plot <- renderPlot({
      v2 %>%
        ggplot(aes(x = HGHT, y = WGHT)) +
        geom_point()
    })
    
  })
  
}

shinyApp(ui = ui, server = server)