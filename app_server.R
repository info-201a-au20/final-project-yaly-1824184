library("shiny")
library("ggplot2")
library("dplyr")

# Final Project
server <- function(input, output) {
  # creates bar chart
  output$bar <- renderPlot({
    title <- "Genre V.S. Count of the Highest Grossing Disney Films"
    
    if (input$which_set == 1) {
      p <- ggplot(top_10) 
    } else {
      p <- ggplot(top_20) 
    }
    p <- p + geom_bar(mapping = aes_string(x = "genre", fill = input$bar_fill), 
                      position = "stack") +
      labs(title = title, x = "Genre", fill = input$bar_fill, y = "Count")
    p
  })
}