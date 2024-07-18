# Install and load the readxl package if not already installed
install.packages("readxl")
library(readxl)

# Load data from an Excel file
data <- read_excel("C:\\Users\\chatu\\Downloads\\WEOOct2023all.xls.xlsx")
# Print the dimensions (number of rows and columns) of the dataset
data_size <- dim(data)
print(data_size)
# Print the number of rows
print(data_size[1])

# Print the number of columns
print(data_size[2])

# Get a summary of the dataset
summary(data)

# Iterate over each column in the dataset
lapply(data, function(x) {
  # Check if the column is a factor (categorical variable)
  if (is.factor(x)) {
    # If it's a factor, print the unique levels (domain) of the variable
    cat("Domain of", names(x), ":", unique(x), "\n")
  }
})


# Replace "N/A" strings with NA (missing) values
data[data == "n/a"] <- NA

# Calculate the number of missing values in each attribute
missing_values <- colSums(is.na(data))

# Print the number of missing values for each attribute
print(missing_values)
print(sum(missing_values))

head(data)




