# convert to factors
glimpse(listings)

factors <- c("host_response_time", "neighbourhood", "district", "city", "property_type", "room_type", "accommodates", "bedrooms", "minimum_nights", "maximum_nights")
review_factors <- names(listings)[str_detect(names(listings), "^review_scores")]
all_factors <- c(factors, review_factors)

listings <- listings |>
  mutate(across(all_factors, as.factor))

str(listings_transformed)

# pivot amenities column
listings_transformed <- listings |>
  mutate(amenities = str_split(amenities, ",")) |>
  unnest(amenities) |>
  mutate(amenities = str_trim(str_replace_all(amenities, "\\[|\\]|\"", ""))) |>
  mutate(value = TRUE) |>
  pivot_wider(
    names_from = amenities,
    values_from = value
  ) |>
  rename_with(~paste0("amenities_", .), starts_with("amenities"))