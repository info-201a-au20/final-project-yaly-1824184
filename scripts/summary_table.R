library(dplyr)


#Takes a dataset and reteurns a summary table
summary_table <- function(dataset){
  table <- group_by(dataset, genre) %>%
    na_if("") %>%
    filter(!is.na(genre)) %>% 
    summarize(number = n()) %>%
    arrange(-number) %>%
    rename("Number of Movies" = number)
  return(table)
}