### Bivariate Analysis

# Calculate summary statistics for price within each city
summary_stats <- listings |>
  group_by(city) |>
  summarize(
    mean_price = mean(price, na.rm = TRUE),
    median_price = median(price, na.rm = TRUE),
    sd_price = sd(price, na.rm = TRUE),
    min_price = min(price, na.rm = TRUE),
    max_price = max(price, na.rm = TRUE),
    n = n()
  ) |> arrange(desc(n))

# Visualize price distribution using boxplots or histograms
listings |> 
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

cities <- unique(listings$city)

for (city_name in cities) {
  p <- listings |>
    filter(city == city_name, price > 0) |>
    ggplot(aes(x = price)) +
    geom_histogram(binwidth = 0.1, fill = "blue", color = "white") +
    scale_x_log10() +
    labs(
      title = str_glue("Price Distribution in {city_name}"),
      x = "Log(Price)",
      y = "Frequency"
    ) +
    theme_minimal()
  
  ggsave(
    filename = str_glue("plots/price-dist-{tolower(gsub(' ', '-', city_name))}.png"),
    plot = p,
    width = 8,
    height = 6,
    dpi = 300
  )
}

listings |>
  filter(city == "New York", price > 0) |>
  ggplot(aes(x = price)) +
  geom_histogram(binwidth = 0.1, fill = "turquoise", color = "white") +
  scale_x_log10() +
  labs(title = "Price Distribution in New York", x = "Log(Price)", y = "Frequency") +
  theme_minimal()

listings |>
  filter(city == "Sydney", price > 0) |>
  ggplot(aes(x = price)) +
  geom_histogram(binwidth = 0.1, fill = "tomato", color = "white") +
  scale_x_log10() +
  labs(title = "Price Distribution in Sydney", x = "Log(Price)", y = "Frequency") +
  theme_minimal()
