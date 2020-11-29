# load packages
library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("plotly")
library("knitr")
library("stringr")

# load data
data <- read.csv("data/disney_movies.csv", stringsAsFactors = FALSE)

# Describe the pattern of the gross (total gross and infaltion adjusted gross) 
# over time (years)
  info_disney <- data %>%
    mutate(year = format(as.Date(release_date), "%Y")) %>%
    group_by(year) %>% 
    summarise(
      total_gross = sum(total_gross, na.rm = TRUE),
      inflation_adj_gross = sum(inflation_adjusted_gross, na.rm = TRUE)) %>%
    gather("key", "value", total_gross, inflation_adj_gross) %>%
    mutate(label = str_to_title(gsub( "_", " ", key))) 

# Create the line graph on ggplot
  line_graph_disney <- ggplot(data = info_disney) +
    geom_point(mapping = aes(
      x = factor(year),
      y = value, color = label, group = label,
      text = paste0(year, "<br>", label, ": ", value)),
      size = .5) +
    geom_line(mapping = aes(
      x = factor(year),
      y = value, color = label, group = label,
      text = paste0(year, "<br>", label, ": ", value)),
      size = .5) +
    labs(title = "The Yearly Gross of Disney Movies Over Time",
      x = "Year",
      y = "Value (USD)" 
  )

plot_line_graph <- ggplotly(line_graph_disney, tooltip = "text")

# Two Important Inforation 
# Highest inflation adjusted gross
highest_inf_adj_gross <- data %>%
  mutate(year = format(as.Date(release_date), "%Y")) %>%
  group_by(year) %>%
  summarise(highest_inflation = sum(inflation_adjusted_gross, na.rm = TRUE)) %>%
  filter(highest_inflation == max(highest_inflation)) %>%
  pull(year)

# Lowest inflation adjusted gross
lowest_inf_adj_gross <- data %>%
  mutate(year = format(as.Date(release_date), "%Y")) %>%
  group_by(year) %>%
  summarise(lowest_inflation = sum(inflation_adjusted_gross, na.rm = TRUE)) %>%
  filter(lowest_inflation == min(lowest_inflation)) %>%
  pull(year)

# Top 10 years with the highest adjusted inflation
top_10_years <- data %>%
  mutate(year = format(as.Date(release_date), "%Y")) %>%
  group_by(year) %>%
  summarise(highest_inflation = sum(inflation_adjusted_gross, na.rm = TRUE)) %>%
  arrange(desc(highest_inflation)) %>%
  head(10) %>%
  pull(year)


# Question: How is the trend of the yearly gross of Disney movies changing over time between between 1937-2016? 
Over time, 
  
