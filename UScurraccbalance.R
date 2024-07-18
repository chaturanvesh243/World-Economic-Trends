#current account balance 

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Assuming 'data' contains your dataset

# Filter the row for "United States" and "Current account balance"
row_data <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Current account balance" )

row_data<- row_data %>%
  filter(Units=="U.S. dollars" )

current_acc_us <- row_data %>%
  select(`Subject Descriptor`, `1980`:`2021`)

library(ggplot2)

library(tidyr)
library(ggplot2)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
current_acc_us <-current_acc_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

current_acc_us[year_columns] <- lapply(current_acc_us[year_columns], as.numeric)

# Reshape the data from wide to long format for plotting
melted_data <- pivot_longer(current_acc_us, cols = -`Subject Descriptor`, names_to = "Year", values_to = "Value")

# Convert Year column to numeric
melted_data$Year <- as.numeric(melted_data$Year)

# Plot the data
ggplot(melted_data, aes(x = Year, y = Value, color = `Subject Descriptor`)) +
  geom_line() +
  labs(x = "Year", y = "Value in US Dollars", title = "Data Trends from 1980 to 2021")


