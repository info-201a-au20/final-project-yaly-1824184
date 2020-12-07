library("shiny")
library("ggplot2")
library("dplyr")
library("tidylr")

movies <- read.csv("data/disney_movies.csv", stringsAsFactors = FALSE)

#MULTIPLE TABS FORMAT
# Intro page
page_one <- tabPabel(
  "Page one",

)

# 1st chart
page_two <- tabPanel(
  "Page two",
  sidebarLayout(
    sidebarPanel(
      
    ),
    mainPanel(
      
    )
  )
)

# 2nd chart
page_three <- tabPanel(
  "Page three",
  sidebarLayout(
    sidebarPanel(
      
    ),
    mainPanel(
      
    )
  )
)

# 3rd chart
# dataset of the top 20 highest grossing films
top_20 <- movies %>%
  filter(mpaa_rating != "") %>%
  top_n(20, inflation_adjusted_gross) %>%
  mutate(year = substring(release_date, 1, 4))

# dataset of the top 10 highest gorssing disney films
top_10 <- movies %>%
  filter(mpaa_rating != "") %>%
  top_n(10, inflation_adjusted_gross) %>%
  mutate(year = substring(release_date, 1, 4))

# allows user to choose which column they want to use for fill in bar chart
bar_fill <- selectInput(
  "bar_fill",
  label = "Fill for Bar Chart",
  choices = list("mpaa_rating", "year"),
  selected = "mpaa_rating"
)

# allows user to choose to compare the top 10 or 20 highest grossing films
which_movies <- radioButtons(
  "which_set",
  label = "Top 10 or Top 20 Films?",
  choices = list("Top 10" = 1, "Top 20" = 2),
  selected = 2
)

page_four <- tabPanel(
  "Top Grossing Films",
  sidebarLayout(
    sidebarPanel(
      bar_fill,
      which_movies
    ),
    mainPanel(
      h1("Comparing the Highest-Grossing Disney Films"),
      p("This chart compares the highest grossing Disney films of all time. On
        the left hand side, choose if you want to compare the top 10 or 20 
        movies than see the genre and ratings of these films. We can study which
        types of movies are most succesful. You can also study which years these
        top movies were made."),
      plotOutput("bar")
    )
  )
)

# summarize three things
page_five <- tabPanel(
  "Page five"
)

ui <- navbarpage("Disney Data",
                 page_one,
                 page_two,
                 page_three,
                 page_four,
                 page_five)
