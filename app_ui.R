library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")

movies <- read.csv("data/disney_movies.csv", stringsAsFactors = FALSE)


# Intro page
page_one <- tabPanel ("Summary",
  tags$body(
             mainPanel(
               h1("Disney Movies"),
               
               img(src="Walt-Disney-Pictures-Logo.jpg", width = "1050px", 
                   height = "521px"),
               
               p("Our domain of interest is entertainment so in this report,
               we'll be studying a data set comparing all of the movies made by 
               Disney. We are interested in exploring the domain of 
               entertainment because it is a very broad field with lots of 
               available data in part due to the rise of streaming services. 
               This data set includes all", tags$b("Disney"), "movies up to 
               2016."),
               
               h2("Summary"),
               
               p("We are interested in exploring the domain of entertainment 
               because it is a very broad field with lots of available data in 
               part due to the rise of streaming services. There are many 
               different ways people use their free time on entrainment today. 
               Such as", tags$em("TV, Netflix, Spotify, YouTube, Disney +, 
               Movies, Podcasts, Games, Twitter, etc."), "We have all been 
               consuming a lot of entertainment recently because of COVID-19."),
               
               h2("Major Questions"),
               
               p("These are questions we seek to answer:"),
               
               tags$ol(
                 
                 tags$li("What are the particular movie trends that affect the 
                 yearly gross income of Disney movies over time?"),
                 
                 
                 tags$li("How does the genre of a Disney movie affect the amount
                         of gross income the film will produce?"),
                 
                 
                 tags$li("What trends do we notice in the top 20 
                 highest-grossing films in the Disney data set?")
               ),
               
               
               h2("Data used to Answer"),
               
               p("We will be using the", tags$em("disney_movies"), "data
               set to answer our major questions about", tags$b("Disney"), 
               "movies. This data set includes all", tags$b("Disney"), "movies 
               up to 2016. It has  their release dates, genre, rating, total 
               gross and inflation adjusted gross(2016).")
             )
      )
)


 # 1st chart
# mutated movies dataframe
movies_edit <- na_if(movies, "") %>%
  filter(!is.na(genre)) %>%
  filter(inflation_adjusted_gross != 0) %>%
  mutate("year" = substring(release_date, 1, 4)) %>%
  mutate(year = as.numeric(year))

#data from disney dataset
genre_unique <- unique(movies$genre) 

# selectInput drop down menu to select a single genre
genre_pick <- selectInput(inputId = "genre_pick",
                          label = "Select Genre",
                          choices = genre_unique,
                          selected = genre_unique[1],
                          multiple = FALSE)

page_two <-
 tabPanel("Disney Scatter Plot",
          sidebarLayout(
            sidebarPanel(genre_pick),
            mainPanel(plotlyOutput("scatter_plot")),
          ))



# 2nd chart
#dataset without missing genre and inflation adjusted gross
movies_genre_edit <- na_if(movies, "") %>%
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
genre_plot_main_content <- mainPanel(
  plotlyOutput("genre_plot")
)
#create the tab panel
page_three <- tabPanel(
  "Genre Plot",
  titlePanel("Genre comparison"),
  sidebarLayout(
    genre_plot_sidebar_content,
    genre_plot_main_content
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

ui <- navbarPage("Disney Data",
                 page_one,
                 page_two,
                 page_three,
                 page_four,
                 page_five)
