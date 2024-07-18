library(ggplot2)
library(dplyr)
library(tidyr)


# Define the list of Subject Descriptors and corresponding Units
subject_units <- c("Gross domestic product, constant prices" = "National currency",
                   "Gross domestic product per capita, constant prices" = "National currency",
                   "Total investment" = "Percent of GDP",
                   "Gross national savings" = "Percent of GDP",
                   "Inflation, average consumer prices" = "Index",
                   "Volume of imports of goods and services" = "Percent change",
                   "Volume of exports of goods and services" = "Percent change",
                   "Population" = "Persons",
                   "General government revenue" = "National currency",
                   "General government total expenditure" = "National currency",
                   "General government net lending/borrowing" = "National currency",
                   "General government structural balance" = "National currency",
                   "General government gross debt" = "National currency",
                   "Current account balance" = "U.S. dollars")

# Filter the rows based on Subject Descriptor and corresponding Units
india_correlogram <- data_india %>%
  filter(`Subject Descriptor` %in% names(subject_units),
         Units == subject_units[`Subject Descriptor`])


india_correlogram <- india_correlogram %>%
  select(`Subject Descriptor`, `2001`:`2021`)


# Install and load the corrplot package
install.packages("corrplot")
library(corrplot)

# Transpose the data
transposed_india_correlogram <- t(india_correlogram)

# Convert the transposed data to a data frame
transposed_india_correlogram <- as.data.frame(transposed_india_correlogram)


# Remove the first row (it contains the indicator names)
transposed_india_correlogram <- transposed_india_correlogram[-1, ]

# Convert the data to numeric
transposed_india_correlogram <- apply(transposed_india_correlogram, 2, as.numeric)

# Compute the correlation matrix
correlation_matrix_india <- cor(transposed_india_correlogram)

# Create the correlogram
corrplot(correlation_matrix_india, method = "color", type = "upper", 
         order = "hclust", tl.col = "black", tl.srt = 45)

corrplot(correlation_matrix_india)
