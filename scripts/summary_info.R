library("dplyr")

# data set

summary_info <- function(df) {
  Info <- list(Highest_Gross_Movie = df %>% 
                 filter(inflation_adjusted_gross == 
                        max(inflation_adjusted_gross, na.rm = TRUE)) %>%
                 pull(movie_title),
               Lowest_Gross_Movies = df %>% 
                 filter(inflation_adjusted_gross == 
                        min(inflation_adjusted_gross, na.rm = TRUE)) %>%
                 pull(movie_title),
               Most_Common_Genre = df %>%
                 group_by(genre) %>%
                 summarise(number = n()) %>%
                 filter(number == max(number, na.rm = TRUE)) %>%
                 pull(genre),
               Most_Common_Release_Year = df %>%
                 mutate("years" = substring(release_date, 1, 4)) %>%
                 group_by(years) %>%
                 summarise(number = n()) %>%
                 filter(number == max(number, na.rm = TRUE)) %>%
                 pull(years),
               Total_Movies = nrow(df))
  return(Info)
} 

