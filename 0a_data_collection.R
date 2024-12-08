# reading package
library(tidyverse)
library(purrr)

# reading data 
listings <- read_csv("data/raw/listings.csv")
listings_codebook <- read_csv("data/raw/listings_data_dictionary.csv")

# checking variables 
table(sapply(listings, class)) |>
  knitr::kable()

# checking missingness 
skimr::skim_without_charts(listings) |>
  filter(n_missing != 0) |>
  arrange(desc(complete_rate)) |>
  knitr::kable()

# separating data by each city
clean_filename <- function(city) {
  filename <- tolower(city) |> 
    str_replace_all(" ", "_") |> 
    paste0("data/", ., ".csv")
  return(filename)
}

# Separate data by city and write to separate CSV files with print statement
listings |>
  group_by(city) |>
  group_split() |>
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


