#general govt structural balance

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Assuming 'data' contains your dataset

# Filter the row for "United States" and "Current account balance"
row_data4 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "General government structural balance" )

row_data4<- row_data4 %>%
  filter(Units=="National currency" )

structural_bal_us <- row_data4 %>%
  select(`Subject Descriptor`, `2001`:`2021`)

library(ggplot2)

library(tidyr)
library(ggplot2)

# Convert year columns to numeric
year_columns1 <- as.character(seq(2001, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
structural_bal_us <-structural_bal_us %>%
  select(`Subject Descriptor`, all_of(year_columns1))

structural_bal_us[year_columns1] <- lapply(structural_bal_us[year_columns1], as.numeric)

# Reshape the data from wide to long format for plotting
melted_data4 <- pivot_longer(structural_bal_us, cols = -`Subject Descriptor`, names_to = "Year", values_to = "Value")

# Convert Year column to numeric
melted_data4$Year <- as.numeric(melted_data4$Year)

# Plot the data
ggplot(melted_data4, aes(x = Year, y = Value, color = `Subject Descriptor`)) +
  geom_line() +
  labs(x = "Year", y = "value in National currency", title = "Data Trends from 2001 to 2021")


