#inflation index

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Assuming 'data' contains your dataset

# Filter the row for "United States" and "Current account balance"
row_data2 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Inflation, average consumer prices" )

row_data3<- row_data2 %>%
  filter(Units=="Index" )

inflation_us_index <- row_data3 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
inflation_us_index <-inflation_us_index %>%
  select(`Subject Descriptor`, all_of(year_columns))

inflation_us_index[year_columns] <- lapply(inflation_us_index[year_columns], as.numeric)

# Reshape the data from wide to long format for plotting
melted_data3 <- pivot_longer(inflation_us_index, cols = -`Subject Descriptor`, names_to = "Year", values_to = "Value")

# Convert Year column to numeric
melted_data3$Year <- as.numeric(melted_data3$Year)

# Plot the data
ggplot(melted_data3, aes(x = Year, y = Value, color = `Subject Descriptor`)) +
  geom_line() +
  labs(x = "Year", y = "Index", title = "Data Trends from 1980 to 2021")


