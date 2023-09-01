library(bslib)
bslib::bs_theme_preview()


## bslib dashboard 만들기

library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "My dashboard",
  sidebar = "Sidebar",
  "Main content area"
)

server <- function(input, output, session){
  
}

shinyApp(ui, server)

## layout

ui <- page_sidebar(
  title = "My dashboard",
  sidebar = "Sidebar",
  fluidRow(
    column(
      width = 4,
      card("A simple card")
    ),
    column(
      width = 8,
      card("A simple card")
    )
  )
)

# layout_columns(
#   card("A simple card"), 
#   card("A simple card"), 
#   card("A simple card"),
#   col_widths = c(6, 6, 12),
#   row_heights = c(2, 1)
# )

shinyApp(ui, server)


## multi-page

ui <- page_navbar(
  title = "Title",
  sidebar = 'sidebar',
  nav_panel("Page A", card("A simple card 1")),
  nav_panel("Page B", card("A simple card 2")),
  nav_panel("Page C", card("A simple card 3"))
)

shinyApp(ui, server)

## multi-panel 

ui <- page_sidebar(
  title = "Title",
  sidebar = 'sidebar',
  navset_card_tab(
    title = "multi-panel",
    nav_panel("Page A", card("A simple card 1")),
    nav_panel("Page B", card("A simple card 2")),
    nav_panel("Page C", card("A simple card 3"))
  )
)

shinyApp(ui, server)


## components
ui <- page_sidebar(
  title = "Title",
  sidebar = 'sidebar',
  card(
    full_screen = TRUE,
    card_header("This is the header"),
    card_body("This is the body."),
    card_footer("This is the footer")
  )
)

# value_box(
#   title = "Average bill length",
#   value = scales::unit_format(unit = "mm")(44),
#   showcase = bsicons::bs_icon("align-bottom")
# )


## Height / Weight dashboard

set.seed(123)

myData <- data.frame(
  height = round(rnorm(n = 100, mean = 180, sd = 5), 1),
  weight = round(rnorm(n = 100, mean = 65, sd = 5), 1)
)

model <- lm(data = myData, formula = height ~ weight)

save(model, file = 'model.Rdata')

value <- 35

newData <- data.frame(weight = value)
predict(model, newData)

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