library(shiny)

ui <- fluidPage(
  h1("Example app 4"),
  sidebarLayout(
    sidebarPanel(
      actionButton("rnorm", "Normal"),
      actionButton("runif", "Uniform")
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  # Assignment: When "rnorm" button is clicked, the plot should
  # show a new batch of rnorm(100). When "runif" button is clicked,
  # the plot should show a new batch of runif(100).
  
  values = reactiveValues(x = NULL)
  
  observeEvent(input$rnorm, { values$x <- rnorm(100) })
  
  observeEvent(input$runif, { values$x <- runif(100) })
  
  output$plot <- renderPlot({
    req(values$x)
    #if (is.null(values$x)) return()
    hist(values$x)
  })
}

shinyApp(ui, server)
