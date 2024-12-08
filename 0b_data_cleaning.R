# Convert each amenity into its own binary column
## paris
paris <- read_csv("data/paris.csv")
paris_amenities <- paris |>
  mutate(amenities = str_replace_all(amenities, "\\[|\\]|\"", "") |> 
           str_split(", ")) |>
  unnest(amenities) |>
  mutate(amenities = str_trim(amenities)) |>
  mutate(amenities = if_else(amenities == "", "No Amenities", amenities)) |>
  mutate(amenity_present = 1) |> 
  group_by(listing_id, amenities) |>
  distinct() 

paris_amenities <- paris_amenities |>
  pivot_wider(
    id_cols = listing_id,
    names_from = amenities,
    values_from = amenity_present,
    values_fill = list(amenity_present = 0)
  )

paris <- left_join(paris, paris_amenities, by = "listing_id")

## new york 
new_york <- read_csv("data/new_york.csv")
new_york_amenities <- new_york |>
  mutate(amenities = str_replace_all(amenities, "\\[|\\]|\"", "") |> 
           str_split(", ")) |>
  unnest(amenities) |>
  mutate(amenities = str_trim(amenities)) |>
  mutate(amenities = if_else(amenities == "", "No Amenities", amenities)) |>
  mutate(amenity_present = 1) |>
  group_by(listing_id, amenities) |>
  distinct() 

new_york_amenities <- new_york_amenities |>
  pivot_wider(
    id_cols = listing_id,
    names_from = amenities,
    values_from = amenity_present,
    values_fill = list(amenity_present = 0)
  )

new_york <- left_join(new_york, new_york_amenities, by = "listing_id")

## sydney
sydney <- read_csv("data/sydney.csv")
sydney_amenities <- sydney |>
  mutate(amenities = str_replace_all(amenities, "\\[|\\]|\"", "") |> 
           str_split(", ")) |>
  unnest(amenities) |>
  mutate(amenities = str_trim(amenities)) |>
  mutate(amenities = if_else(amenities == "", "No Amenities", amenities)) |>
  mutate(amenity_present = 1) |>
  group_by(listing_id, amenities) |>
  distinct() 

sydney_amenities <- sydney_amenities |>
  pivot_wider(
    id_cols = listing_id,
    names_from = amenities,
    values_from = amenity_present,
    values_fill = list(amenity_present = 0)
  )

sydney <- left_join(sydney, sydney_amenities, by = "listing_id")

# combine three datasets
top_3_cities <- bind_rows(paris, new_york, sydney)
write_csv(top_3_cities, "data/top_3_cities.csv")
top_3_cities <- read_csv("data/top_3_cities.csv")
