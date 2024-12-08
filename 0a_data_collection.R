library(tidyverse)
library(purrr)

listings <- read_csv("data/raw/listings.csv")
listings_codebook <- read_csv("data/raw/listings_data_dictionary.csv")

# splitting listings data by city

clean_filename <- function(city) {
  filename <- tolower(city) %>% 
    str_replace_all(" ", "_") %>% 
    paste0("data/", ., ".csv") #
  return(filename)
}

listings %>%
  group_by(city) %>%
  group_split() %>%
  walk(function(df) {
    city_name <- df$city[1]
    print(paste("Processing city:", city_name))
    write_csv(df, clean_filename(city_name))
  })

# reading in new datasets

bangkok <- read_csv("data/bangkok.csv")
cape_town <- read_csv("data/cape_town.csv")
hong_kong <- read_csv("data/hong_kong.csv")
istanbul <- read_csv("data/istanbul.csv")
mexico_city <- read_csv("data/mexico_city.csv")
new_york <- read_csv("data/new_york.csv")
paris <- read_csv("data/paris.csv")
rio_de_janeiro <- read_csv("data/rio_de_janeiro.csv")
rome <- read_csv("data/rome.csv")
sydney <- read_csv("data/sydney.csv")


