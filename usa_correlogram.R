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
USA_correlogram <- data_us %>%
  filter(`Subject Descriptor` %in% names(subject_units),
         Units == subject_units[`Subject Descriptor`])


USA_correlogram <- USA_correlogram %>%
  select(`Subject Descriptor`, `2001`:`2021`)


# Install and load the corrplot package
install.packages("corrplot")
library(corrplot)

# Transpose the data
transposed_usa_correlogram <- t(USA_correlogram)

# Convert the transposed data to a data frame
transposed_usa_correlogram <- as.data.frame(transposed_usa_correlogram)


# Remove the first row (it contains the indicator names)
transposed_usa_correlogram <- transposed_usa_correlogram[-1, ]

# Convert the data to numeric
transposed_usa_correlogram <- apply(transposed_usa_correlogram, 2, as.numeric)

# Compute the correlation matrix
correlation_matrix <- cor(transposed_usa_correlogram)

# Create the correlogram
corrplot(correlation_matrix, method = "color", type = "upper", 
         order = "hclust", tl.col = "black", tl.srt = 45)

corrplot(correlation_matrix)

corrplot(correlation_matrix, method = "number")
