library("shiny")
library("ggplot2")
library("dplyr")
library("plotly")

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
    movies_genre_edit_select <- filter(movies_genre_edit, genre %in% input$genre)
    fig <- plot_ly(data = movies_genre_edit_select, x = ~genre, y = ~inflation_adjusted_gross, type = "box") %>%
      layout(title = "Amount Grossed Compared by Genre",
            yaxis = list(range = c(0, input$genre_range), title = "Inflation Adjusted Gross"),
            xaxis = list(title = "Genre")
            )
    
    return(fig)
  })

  #scatterplot 
 output$scatter_plot <- renderPlotly({
    plot_data <- movies_edit %>%
      filter(genre %in% input$genre_pick) %>%
      filter(mpaa_rating %in% input$rating_pick)
    
    plot2 <- plot_ly(data = plot_data, 
                     x = ~year, 
                     y = ~inflation_adjusted_gross, 
                     type = "scatter",
                     mode = "markers",
                     color = ~genre, colors = "Set3",
                     text = ~paste(movie_title, "<br>", mpaa_rating)) %>%
      layout(title = "The Gross of Disney Movies throughout the Year",
             xaxis = list(
               title = "Years"),
             yaxis = list(
               title = "Inflation Adjusted Gross (USD)"))
    
    return(plot2)
  })
}