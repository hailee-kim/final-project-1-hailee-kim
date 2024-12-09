### Bivariate Analysis

# Calculate summary statistics for price within each city
top_3_cities |>
  group_by(city) |>
  summarize(
    mean_price = mean(price, na.rm = TRUE),
    median_price = median(price, na.rm = TRUE),
    sd_price = sd(price, na.rm = TRUE),
    min_price = min(price, na.rm = TRUE),
    max_price = max(price, na.rm = TRUE),
    n = n()
  ) |> arrange(desc(n)) |>
  knitr::kable()

# boxplot of city vs. price 
top_3_cities |> 
  ggplot(aes(x = city, y = price)) +
  geom_boxplot(outlier.color = "red", fill = "lightblue") +
  labs(title = "Price Distribution by City", x = "City", y = "Price (in Local Currency)") +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal() + 
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.text.y = element_text(size = 10),
    plot.title = element_text(hjust = 0.5, size = 14),
    plot.margin = margin(10, 20, 10, 10)
  )

ggsave(
  filename = "plots/boxplot.png",
  width = 8,
  height = 6, 
  unit = "in",
  dpi = 300
)

# histograms of city vs. price 
## paris

paris |>
  filter(city == "Paris", price > 0) |>
  ggplot(aes(x = price)) +
  geom_histogram(binwidth = 0.1, fill = "navy", color = "white") +
  scale_x_log10() +
  labs(title = "Price Distribution in Paris", x = "Log(Price)", y = "Frequency") +
  theme_minimal()

ggsave(
  filename = "plots/price-dist-paris.png",
  width = 8,
  height = 6,
  dpi = 300
)

## new york
new_york |>
  filter(city == "New York", price > 0) |>
  ggplot(aes(x = price)) +
  geom_histogram(binwidth = 0.1, fill = "turquoise", color = "white") +
  scale_x_log10() +
  labs(title = "Price Distribution in New York", x = "Log(Price)", y = "Frequency") +
  theme_minimal()

ggsave(
  filename = "plots/price-dist-new-york.png",
  width = 8,
  height = 6,
  dpi = 300
)

## sydney
sydney |>
  filter(city == "Sydney", price > 0) |>
  ggplot(aes(x = price)) +
  geom_histogram(binwidth = 0.1, fill = "tomato", color = "white") +
  scale_x_log10() +
  labs(title = "Price Distribution in Sydney", x = "Log(Price)", y = "Frequency") +
  theme_minimal()

ggsave(
  filename = "plots/price-dist-sydney.png",
  width = 8,
  height = 6,
  dpi = 300
)

# combined overlapping histograms

combined_data <- bind_rows(
  paris |> filter(city == "Paris", price > 0) |> mutate(city_label = "Paris"),
  new_york |> filter(city == "New York", price > 0) |> mutate(city_label = "New York"),
  sydney |> filter(city == "Sydney", price > 0) |> mutate(city_label = "Sydney")
)

combined_data |>
  ggplot(aes(x = price, fill = city_label)) +
  geom_histogram(binwidth = 0.1, position = "identity", alpha = 0.5, color = "white") +
  scale_x_log10() +
  labs(title = "Overlapping Price Distributions by City", 
       x = "Log(Price)", 
       y = "Frequency") +
  theme_minimal() +
  scale_fill_manual(values = c("Paris" = "navy", "New York" = "turquoise", "Sydney" = "tomato"))

ggsave(
  filename = "plots/price-combined.png",
  width = 8,
  height = 6,
  dpi = 300
)
