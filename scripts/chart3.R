# Chart 3 - stacked bar chart of top 20 movies
library("dplyr")
library("ggplot2")

make_3rd_chart <- function(dataset) {
  # filters passed in dataset to the top 20 
  top_20 <- dataset %>%
              filter(mpaa_rating != "") %>%
              top_n(20, inflation_adjusted_gross) %>%
              group_by(genre)
  
  # creates bar chart to represent the dataset 
  chart <- ggplot(data = top_20) +
             geom_bar(mapping = aes(fill = mpaa_rating, x = genre), 
                      position = "stack") +
             labs(title = "Comparing the 20 Highest-Grossing Disney Films",
                  x = "Genre",
                  y = "Number of Movies",
                  fill = "Movie Rating")
  return(chart)
} 

