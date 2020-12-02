library("shiny")
library("ggplot2")
library("dplyr")
library("tidylr")

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
