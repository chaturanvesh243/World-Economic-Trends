library(dplyr)

# Define the list of countries
countries <- c("United States", "China", "India", "Germany", "Brazil", "Japan", 
               "United Kingdom", "South Africa", "Australia", "France", 
               "Italy", "Canada", "Korea", "Spain", "Mexico", "Indonesia", 
               "Türkiye", "Saudi Arabia", "Netherlands", "Argentina")

# Filter data for GDP in U.S. dollars for the specified countries
countries_gdp_data <- data %>%
  filter(`Subject Descriptor` == "Gross domestic product, current prices" &
           Units == "U.S. dollars" &
           Country %in% countries)

# Select 'Country' and columns for years 1980 to 2021
selected_columns <- c("Country", as.character(1980:2021))
countries_gdp_data <- countries_gdp_data %>%
  select(all_of(selected_columns))


library(ggplot2)


# Melt the dataset to long format for easier plotting
melted_countries_gdp_data <- reshape2::melt(countries_gdp_data, id.vars = "Country")

# Add a grouping variable
melted_countries_gdp_data <-melted_countries_gdp_data %>%
  group_by(Country) %>%
  mutate(group = row_number())

# Plot the graph
ggplot(melted_countries_gdp_data, aes(x = variable, y = value, color = Country, group = group)) +
  geom_line() +
  labs(x = "Year", y = "GDP (U.S. dollars)", color = "Country") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability


# Plot the graph
ggplot(melted_countries_gdp_data, aes(x = variable, y = value, color = Country, group=1)) +
  geom_line() +
  labs(x = "Year", y = "GDP (U.S. dollars)", color = "Country") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability


library(ggplot2)

# Convert 'value' column to numeric
melted_countries_gdp_data$value <- as.numeric(as.character(melted_countries_gdp_data$value))

# Convert 'variable' column to numeric
melted_countries_gdp_data$variable <- as.numeric(as.character(melted_countries_gdp_data$variable))

# Plot the graph
ggplot(melted_countries_gdp_data, aes(x = variable, y = value, color = Country)) +
  geom_line() +
  labs(x = "Year", y = "GDP (U.S. dollars)", color = "Country") +
  facet_wrap(~ Country, scales = "free_y", ncol = 5) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        axis.text.y = element_text(size = 8, angle = 0, hjust = 1)) +
  scale_x_continuous(breaks = seq(1980, 2021, by = 5)) +  # Set x-axis breaks every 5 years
  scale_y_continuous(breaks = scales::pretty_breaks(n = 5))  # Use 5 labels on the y-axis
