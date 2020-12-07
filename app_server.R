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
  output$genre_plot <- renderPlotly ({
    movies_genre_edit_select <- filter(movies_genre_edit, genre == input$genre)
    fig <- plot_ly(data = movies_genre_edit_select, x = ~genre, y = ~inflation_adjusted_gross, type = "box") %>%
      layout(yaxis = list(range = c(0, input$range), title = "Gross"))
    return(fig)
  })

  #scatterplot chart
 output$scatter_plot <- renderPlotly({
    plot_data <- movies_edit %>%
      filter(genre %in% input$genre_pick)
    
    plot2 <- plot_ly(data = plot_data, 
                     x = ~year, 
                     y = ~inflation_adjusted_gross, 
                     type = "scatter",
                     mode = "markers",
                     color = ~genre, colors = "Set1",
                     text = ~movie_title) %>%
      layout(title = "Disney Movies throughout the Year",
             xaxis = list(
               title = "Years"),
             yaxis = list(
               title = "Inflation Adjusted Gross"))
    
    return(plot2)
  })
}