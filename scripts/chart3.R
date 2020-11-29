# Chart 3 - stacked bar chart of top 20 movies
library("dplyr")
library("ggplot2")
setwd("~/exercises-siyas16/final-project/data")
movies <- read.csv("disney_movies.csv", stringsAsFactors = FALSE)

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
make_3rd_chart(movies)
# Intro: Our domain of interest is entertainment so in this report, we'll be 
#        studying a data set comparing all of the 
#        movies made by Disney. This data set includes all Disney movies up to 
#        2016. It can be found
#        [here](https://www.kaggle.com/prateekmaj21/disney-movies?select=disney_movies.csv).
#        We want to study this data to see what types of movies are the most 
#        successful in terms of grossing amount. These types of studies help
#        Disney plan future films in terms of the genre, ratings etc. the film
#        should stick to.

# Question: What trends do we see in the top 20 highest-grossing Disney films 
#           in Disney history?

# This bar chart compares the genres and ratings of the 20 highest-grossing 
# films in Disney's history. We made it to see if there are any trends in which
# types of movies do the best. 

# As we can see, the most popular, or highest-grossing, Disney films tend to 
# fall in the adventure genre. These movies are also often rated G. In the 
# earlier chart we did, we found that adventure movies are usually the 
# highest-grossing. I think that from these charts we've made, we can infer that 
# Disney has a good understanding of their audience. They clearly know that 
# adventure movies make the most money so they stick to those. This chart can 
# give us more confidence in our prior chart because we once again see that 
# adventure films make a lot of money. 


