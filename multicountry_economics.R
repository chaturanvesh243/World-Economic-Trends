library(readxl)
# Load necessary libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(cluster) # For clustering algorithms

# Load data from an Excel file
economic_data <- read_excel("C:\\Users\\chatu\\Downloads\\WEOOct2023all.xls.xlsx")

# View the structure of the dataset
str(economic_data)

economic_data<-economic_data[-(1:3)]
economic_data<-economic_data[-(3)]
economic_data<-economic_data[-(4:5)]

economic_data<-economic_data[-(49:53)]
economic_data<-economic_data[-(46:48)]

# Replace "N/A" strings with NA (missing) values
economic_data[economic_data == "n/a"] <- NA

# Define the list of Subject Descriptors and corresponding Units
subject_units <- c("Gross domestic product, constant prices" = "National currency",
                   "Gross domestic product per capita, constant prices" = "National currency",
                   "Total investment" = "Percent of GDP",
                   "Gross national savings" = "Percent of GDP",
                   "Inflation, average consumer prices" = "Index",
                   "Volume of imports of goods and services" = "Percent change",
                   "Volume of exports of goods and services" = "Percent change",
                   "Unemployment rate" = "Percent of total labor force",
                   "Employment" = "Persons",
                   "Population" = "Persons",
                   "General government revenue" = "National currency",
                   "General government total expenditure" = "National currency",
                   "General government net lending/borrowing" = "National currency",
                   "General government structural balance" = "National currency",
                   "General government net debt" = "National currency",
                   "General government gross debt" = "National currency",
                   "Current account balance" = "U.S. dollars")

# Filter the rows based on Subject Descriptor and corresponding Units
economic_data <- economic_data %>%
  filter(`Subject Descriptor` %in% names(subject_units),
         Units == subject_units[`Subject Descriptor`])

countries <- c("United States", "China", "India", "Germany", "Brazil", "Japan", 
               "United Kingdom", "South Africa", "Australia", "France", 
               "Italy", "Canada", "Korea", "Spain", "Mexico", "Indonesia", 
               "Türkiye", "Saudi Arabia", "Netherlands", "Argentina")

economic_data <- economic_data %>%
  filter(Country %in% countries)





#-----------------------------------------------------------------------------
economic_data <- economic_data %>%
  mutate(across(starts_with("19"), as.character)) %>%
  mutate(across(starts_with("20"), as.character))

# Pivot the data from wide to long format
economic_data_long <- economic_data %>%
  pivot_longer(cols = -c(Country, `Subject Descriptor`), names_to = "Year", values_to = "Value") %>%
  mutate(Year = as.numeric(Year))

# Check the transformed data
head(economic_data_long)

# Spread the data to have one row per country per year with each indicator as a column
economic_data_wide <- economic_data_long %>%
  pivot_wider(names_from = `Subject Descriptor`, values_from = Value)

# Check the wide format data
head(economic_data_wide)


# Prepare data for clustering analysis
clustering_data <- economic_data_wide %>%
  select(Country, Year, 'Gross domestic product, constant prices', `Unemployment rate`, `Inflation, average consumer prices`, `Volume of imports of goods and services`, `Volume of exports of goods and services`, Population, 'Current account balance') %>%
  na.omit()

# Rename columns for simplicity
colnames(clustering_data) <- c("Country", "Year", "GDP", "Unemployment_Rate", "Inflation", "Imports", "Exports", "Population","Current account balance")

str(clustering_data)

clustering_data[, -(1:2)] <- lapply(clustering_data[, -(1:2)], as.numeric)


# Scale the data (excluding the Country and Year columns)
scaled_data <- clustering_data %>%
  select(-Country, -Year) %>%
  scale()

scaled_data <- na.omit(scaled_data)

clustering_data <- na.omit(clustering_data)

# Perform K-means clustering
set.seed(123)
kmeans_result <- kmeans(scaled_data, centers = 3)

# Add cluster assignment to the original data
clustering_data$Cluster <- kmeans_result$cluster

# View the data with cluster assignments
head(clustering_data)


# Visualize clusters
ggplot(clustering_data, aes(x = GDP, y = Unemployment_Rate, color = factor(Cluster), label = Country)) +
  geom_point() +
  geom_text(vjust = -0.5, hjust = 0.5) +
  labs(title = "Cluster Analysis of Economic Indicators", x = "GDP", y = "Unemployment Rate", color = "Cluster") +
  theme_minimal()

####### Visualize clusters
ggplot(clustering_data, aes(x = GDP, y = Unemployment_Rate, shape = factor(Cluster), color = Country)) +
  geom_point(size = 4) +
  labs(title = "Cluster Analysis of Economic Indicators", x = "GDP", y = "Unemployment Rate", color = "Country", shape = "Cluster") +
  theme_minimal() +
  scale_shape_manual(values = c(1, 2, 3)) +
  scale_color_manual(values = rainbow(length(unique(clustering_data$Country))))


# Visualize clusters
ggplot(clustering_data, aes(x = GDP, y = Unemployment_Rate, shape = factor(Cluster), color = factor(Cluster))) +
  geom_point(size = 4) +
  labs(title = "Cluster Analysis of Economic Indicators", x = "GDP", y = "Unemployment Rate", color = "Cluster", shape = "Cluster") +
  theme_minimal() +
  scale_shape_manual(values = c(16, 17, 18)) +  # Different point shapes for clusters
  scale_color_manual(values = c("blue", "green", "red"))  # Different colors for clusters


install.packages("plotly")
library(plotly)

# Visualize clusters with plotly
plot_ly(clustering_data, x = ~GDP, y = ~Unemployment_Rate, color = ~factor(Cluster), shape = ~factor(Cluster), text = ~Country, type = "scatter", mode = "markers") %>%
  layout(title = "Cluster Analysis of Economic Indicators",
         xaxis = list(title = "GDP"),
         yaxis = list(title = "Unemployment Rate"),
         showlegend = FALSE)

