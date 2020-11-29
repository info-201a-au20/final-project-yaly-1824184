rm(list = ls())

library(dplyr)

library(knitr)

disney_movies_df <- read.csv("data/disney_movies.CSV", stringsAsFactors = FALSE)
