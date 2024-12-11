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
