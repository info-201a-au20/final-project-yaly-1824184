# Chart 2. Created to show affect genre has on gross of a disney movie.


# Creating Data Frame
disney_movies <- read.csv("data/disney_movies.csv",
  stringsAsFactors = FALSE, na.strings = c("", " ", "NA")
)

# Loading packages
library("dplyr")
library("ggplot2")



# Manipulting Data Frame
disney_movies_genre <-
  select(disney_movies, genre, inflation_adjusted_gross) %>%
  filter(!is.na(genre)) %>% # Remove NA values
  filter(inflation_adjusted_gross != 0) # Remove values of 0


# Creating a box and whisker plot
box_plot <- ggplot(disney_movies_genre, aes(y = inflation_adjusted_gross)) +
  geom_boxplot(aes(x = genre))

# plot with outliers is hard to read
ylim1 <-
  boxplot.stats(Disney_Movies_Genre$inflation_adjusted_gross)$stats[c(1, 5)]
box_plot_adjusted <- box_plot + coord_cartesian(ylim = ylim1 * 1.25)

# adjusted to leave out outliers in the plot
