# Chart 2. Created to show affect genre has on gross of a disney movie.


#Loading packages
library("dplyr")
library("ggplot2")

# First turn empty values to NA 
# Select genre and inflation_adjusted_gross
# Remove NA values in genre
# Remove values of 0 in gross
box_plot_adjusted <- function(disney_movies){
  df <- na_if(disney_movies, "") %>%
    select(genre, inflation_adjusted_gross) %>%
    filter(!is.na(genre)) %>% 
    filter(inflation_adjusted_gross != 0) 
# Now create a box plot  
  plot <- ggplot(df, aes(y = inflation_adjusted_gross)) +
    geom_boxplot(aes(x = genre))
# Box plot is hard to read so the foloeing code will limit the 
# y value to make the box plot readable.
# Formatting is included to make the plot look nicer
  ylim1 <-
    boxplot.stats(df$inflation_adjusted_gross)$stats[c(1, 5)]
  plot_adjusted <- plot + coord_cartesian(ylim = ylim1 * 1.25) +
  labs(title = "Amount of Money Different Genre Makes",
       x = "Genre",
       y = "Inflation Adjusted Gross"
      )
  return(plot_adjusted)
}