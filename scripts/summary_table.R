library("dplyr")
library("knitr")

disney_movies_df <- read.csv("data/disney_movies.CSV", stringsAsFactors = FALSE)

summary_table <- disney_movies_df %>%
  group_by(movie_title) %>%
  filter (inflation_adjusted_gross == mean(inflation_adjusted_gross)) %>%
  summarize(Genre = genre,
            Mpaa = mpaa_rating,
            inflation_gross = mean (inflation_adjusted_gross)) %>%
            head(n = 10)

table <- kable(summary_table)
  