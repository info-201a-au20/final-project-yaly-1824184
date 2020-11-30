# Chart 1 - line graph
# load packages
library("dplyr")
library("tidyr")
library("ggplot2")
library("leaflet")
library("plotly")
library("knitr")
library("stringr")

# Describe the pattern of the gross (total gross and infaltion adjusted gross)
# over time (years)
make_1st_chart <- function(dataset) {
  info_disney <- dataset %>%
    mutate(year = format(as.Date(release_date, format = "%m/%d/%Y"), "%Y")) %>%
    group_by(year) %>%
    summarise(
      total_gross = sum(total_gross, na.rm = TRUE),
      inflation_adj_gross = sum(inflation_adjusted_gross, na.rm = TRUE)) %>%
    gather("key", "value", total_gross, inflation_adj_gross) %>%
    mutate(label = str_to_title(gsub("_", " ", key)))
# Create the line graph on ggplot
  line_graph_disney <- ggplot(data = info_disney) +
    geom_point(mapping = aes(
      x = factor(year),
      y = value, color = label, group = label,
     )) +
    geom_line(mapping = aes(
      x = factor(year),
      y = value, color = label, group = label,
      )) +
    labs(title = "The Yearly Gross of Disney Movies Over Time",
      x = "Year",
      y = "Value (USD)"
  )
  return(line_graph_disney)
}