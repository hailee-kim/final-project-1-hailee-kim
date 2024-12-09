# City 

listings$city <- fct_infreq(listings$city)

ggplot(listings, aes(x = city)) +
  geom_bar(fill = "blue", color = "white") +
  labs(title = "Number of Listings per City",
       x = "City",
       y = "Count of Listings") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  filename = "plots/price.png",
  width = 8,
  height = 6,
  dpi = 300
)