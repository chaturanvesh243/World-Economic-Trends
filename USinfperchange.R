#inflation percent change

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Assuming 'data' contains your dataset

# Filter the row for "United States" and "Current account balance"
row_data2 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Inflation, average consumer prices" )

row_data2<- row_data2 %>%
  filter(Units=="Percent change" )

inflation_us <- row_data2 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
inflation_us <-inflation_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

inflation_us[year_columns] <- lapply(inflation_us[year_columns], as.numeric)

# Reshape the data from wide to long format for plotting
melted_data2 <- pivot_longer(inflation_us, cols = -`Subject Descriptor`, names_to = "Year", values_to = "Value")

# Convert Year column to numeric
melted_data2$Year <- as.numeric(melted_data2$Year)

# Plot the data
ggplot(melted_data2, aes(x = Year, y = Value, color = `Subject Descriptor`)) +
  geom_line() +
  labs(x = "Year", y = "percent change", title = "Data Trends from 1980 to 2021")


