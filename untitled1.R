# Load required libraries
install.packages("tidyr")
install.packages("ggplot2")
install.packages("dplyr")

# Load required libraries
library(tidyr)
library(dplyr)
library(ggplot2)

# Assuming your dataset is named 'data'

# Filter the dataset to include data only for the United States
data_us <- data %>%
  filter(Country == "United States")

# Filter the dataset to extract rows for Inflation Rate and General Government Gross Debt
data_filtered <- data_us %>%
  filter(`WEO Subject Code` %in% c("PCPI", "GGXWDG"))

print(data_filtered)


plot_data <- data_filtered %>%
  select(-`WEO Country Code`:-`2000`)

# Print the modified dataset
print(plot_data)

plot_data <- plot_data %>%
  select(-`2022`:-`Estimates Start After`)

# Print the modified dataset
print(plot_data)

