### Multivariate Analysis
# Examine how various factors (e.g., accommodates, property_type) relate to price within cities.

cor_results <- listings |>
  group_by(city) |>
  summarise(
    cor_accommodates = cor(accommodates, price, use = "complete.obs"),
    cor_bedrooms = cor(bedrooms, price, use = "complete.obs"),
    cor_minimum_nights = cor(minimum_nights, price, use = "complete.obs")
  )
print(cor_results)

# Heatmap for All Correlations
cor_results_long <- cor_results |>
  pivot_longer(cols = starts_with("cor_"), names_to = "variable", values_to = "correlation")

ggplot(cor_results_long, aes(x = variable, y = city, fill = correlation)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "red", mid = "white", high = "blue", midpoint = 0, 
                       limits = c(-1, 1), name = "Correlation") +
  labs(title = "Correlation Heatmap by City and Variable", 
       x = "Variable", y = "City") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  filename = "plots/correlation-heatmap.png",  
  width = 10, 
  height = 6, 
  dpi = 300
)