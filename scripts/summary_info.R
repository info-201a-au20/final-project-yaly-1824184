rm(list = ls())

library(dplyr)

# data set
disney_movies_df <- read.csv("data/disney_movies.CSV", stringsAsFactors = FALSE)

Highest_Gross_Movie <- disney_movies_df %>% 
  filter(total_gross == max(total_gross, na.rm = TRUE)) %>%
  pull(movie_title)

Lowest_Gross_Movies <- disney_movies_df %>% 
  filter(total_gross == min(total_gross, na.rm = TRUE)) %>%
  pull(movie_title)

Most_Common_Genre <- disney_movies_df %>%
  filter(genre == max(genre, na.rm = TRUE)) %>%
  head(n = 1) %>%
  pull(genre)

 Most_Common_Release_Year <- disney_movies_df %>%
  mutate("years" = substring(release_date, 5, 8)) %>%
  filter(release_date == max(release_date, na.rm = TRUE)) %>%
  pull(years)

Total_Movies <- nrow(disney_movies_df)

summary_info <- function(df) {
  Info <- list(Highest_Gross_Movie = df %>% 
                 filter(total_gross == max(total_gross, na.rm = TRUE)) %>%
                 pull(movie_title),
               Lowest_Gross_Movies = df %>% 
                 filter(total_gross == min(total_gross, na.rm = TRUE)) %>%
                 pull(movie_title),
               Most_Common_Genre = df %>%
                 filter(genre == max(genre, na.rm = TRUE)) %>%
                 head(n = 1) %>%
                 pull(genre),
               Most_Common_Release_Year = df %>%
                 mutate("years" = substring(release_date, 5, 8)) %>%
                 filter(release_date == max(release_date, na.rm = TRUE)) %>%
                 pull(years),
               Total_Movies = nrow(df))
  return (Info)
} 

summary <- summary_info(disney_movies_df)
