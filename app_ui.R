library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")

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
#dataset without missing genre and inflation adjusted gross
movies_grnre_edit <- na_if(df, "") %>%
  filter(!is.na(genre)) %>%
  filter(inflation_adjusted_gross != 0)
#creating sidebarPanel
genre_plot_sidebar_content <- sidebarPanel(
  selectInput("genre", "Genre",
              list("Action" = "Action",
                   "Adventure" = "Adventure",
                   "Black Comedy" = "Black Comedy",
                   "Comedy" = "Comedy",
                   "Concert/Performance" = "Concert/Performance",
                   "Documentary" = "Documentary",
                   "Drama" = "Drama",
                   "Horror" = "Horror",
                   "Musical" = "Musical",
                   "Romantic Comedy" = "Romantic Comedy",
                   "Thriller/Suspense" = "Thriller/Suspense",
                   "Western" = "Western"),
              multiple = TRUE
  ),
  radioButtons("genre_range", "Inflation adjusted gross",
               list("6 Billion" = 6000000000,
                    "5 Billion" = 5000000000,
                    "4 Billion" = 4000000000,
                    "3 Billion" = 3000000000,
                    "2 Billion" = 2000000000,
                    "1 Billion" = 1000000000,
                    "500 Million" = 500000000,
                    "250 Million" = 250000000)
               
  )
)
#create main panel
genre_polt_main_content <- mainPanel(
  plotlyOutput("genre_plot")
)
#create the tab panel
page_three <- tabPanel(
  "Genre Plot",
  titlePanel("Genre comparison"),
  sidebarLayout(
    genre_plot_sidebar_content,
    genre_polt_main_content
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
