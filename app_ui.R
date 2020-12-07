library("shiny")
library("ggplot2")
library("dplyr")
library("tidylr")

#MULTIPLE TABS FORMAT
# Intro page
page_one <- tabPanel (
  tags$body( "Summary",
             
             mainPanel(
               h1("Disney Movies"),
               
               img(src="Walt-Disney-Pictures-Logo.jpg", width = "1050px", 
                   height = "521px"),
               
               p("We are interested in exploring the domain of entertainment 
               because it is a very broad field with lots of available data in 
               part due to the rise of streaming services. There are many 
               different ways people use their free time on entrainment today.
               Such as TV, Netflix, Spotify, YouTube, Disney +, Movies, 
               Podcasts, Games, Twitter, etc. We have all been consuming a lot
               of entertainment recently because of COVID-19.")
               ,
               
               h2("Summary"),
               
               p("We are interested in exploring the domain of entertainment 
               because it is a very broad field with lots of available data in 
               part due to the rise of streaming services. There are many 
               different ways people use their free time on entrainment today. 
               Such as TV, Netflix, Spotify, YouTube, Disney +, Movies, 
               Podcasts, Games, Twitter, etc. We have all been consuming a lot 
               of entertainment recently because of COVID-19."),
               
               h2("Major Questions"),
               
               p("These are questions we seek to answer:"),
               
               tags$ol(
                 
                 tags$li("What characteristics of a video make it go viral? 
                 Analysis of viral videos to compare length, titles, title 
                 length, genre, language, etc."),
                 
                 
                 tags$li("How does a type of entertainment keep audiences 
                 engaged? Changing seasons, new cast, how often, adding 
                 challenges?"),
                 
                 
                 tags$li("What type of entertainment is most popular from over 
                 the years? Comparison of money involved or amount of time 
                 people spend on a certain type etc.")
               ),
               
               
               h2("Data used to Answer"),
               
               p("We will be using the tags$em", tags$em("disney_movies"), "data
               set to answer our major questions about", tags$b("Disney"), 
               "movies. This data set includes all", tags$b("Disney"), "movies 
               up to 2016. It has  their release dates, genre, rating, total 
               gross and inflation adjusted gross(2016).")
             )
      )
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
page_four <- tabPanel(
  "Page four",
  sidebarLayout(
    sidebarPanel(
      
    ),
    mainPanel(
      
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
