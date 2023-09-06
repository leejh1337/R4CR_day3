ui <- page_sidebar(
  title = 'app',
  sidebar = sidebar(
    sliderInput(
      inputId = 'weight',
      label = 'select weight', 
      value = 50,
      min = 20, 
      max = 80, 
      step = 1
    ),
    actionButton(
      inputId = 'btn', 
      label = 'Calculate'
    )
  ),
  card(
    p('expected height is '),
    textOutput(outputId = 'result')
  )
)

server <- function(input, output, session) {
  load('model.Rdata')
  observeEvent(input$btn, {
    value <- input$weight
    
    newData <- data.frame(weight = value)
    height <- predict(model, newData)
    
    output$result <- renderText(
      round(height, 1)
    )
  })
}


shinyApp(ui, server)