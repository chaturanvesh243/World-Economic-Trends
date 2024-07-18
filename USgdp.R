#Gross domestic product, current prices

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Assuming 'data' contains your dataset

# Filter the row for "United States" and "Current account balance"
row_data1 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Gross domestic product, current prices" )

row_data1<- row_data1 %>%
  filter(Units=="U.S. dollars" )

gdp_us <- row_data1 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
gdp_us <-gdp_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

gdp_us[year_columns] <- lapply(gdp_us[year_columns], as.numeric)

# Reshape the data from wide to long format for plotting
melted_data1 <- pivot_longer(gdp_us, cols = -`Subject Descriptor`, names_to = "Year", values_to = "Value")

# Convert Year column to numeric
melted_data1$Year <- as.numeric(melted_data1$Year)

# Plot the data
ggplot(melted_data1, aes(x = Year, y = Value, color = `Subject Descriptor`)) +
  geom_line() +
  labs(x = "Year", y = "Value in US Dollars", title = "Data Trends from 1980 to 2021")


