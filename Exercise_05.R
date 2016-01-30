library(shiny)

ui <- fillPage(
  plotOutput("plot", click = "click", height = "100%")
)

# Assignment: This app doesn't work! It's supposed to let
# the user click on the plot, and have a data point appear
# where the click occurs. But as written, the data point
# only appears for a moment before disappearing.
# 
# This happens because each time the plot is re-rendered,
# the value of input$click is reset to NULL, and thus
# userPoint() becomes NULL as well.
# 
# Can you get a single user-added data point to stay?
# 
# Bonus points: Can you include not just the single most
# recent click, but ALL clicks made by the user?
# 
# Hint: You'll need to replace reactive() with a combo
# of reactiveValues() and observeEvent().

server <- function(input, output, session) {
  # Either NULL, or a 1-row data frame that represents
  # the point that the user clicked on the plot
  
  values = reactiveValues(x = NULL, y = cars)
  
  observeEvent(input$click, {
    click <- input$click
    values$x = data.frame(speed = click$x, dist = click$y)
  })
  
  observeEvent(values$x, {
    values$y = rbind(values$y, values$x)
  })
  
  output$plot <- renderPlot({
    # Before plotting, combine the original dataset with
    # the user data. (rbind ignores NULL args.)
    df <- values$y
    rbind(cars, values$y)
    plot(values$y, pch = 19)
    
    model <- lm(dist ~ speed, df)
    abline(model)
  })
}

shinyApp(ui, server)
