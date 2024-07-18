library(tidyr)
library(dplyr)
library(ggplot2)
# Filter the dataset to include data only for the India
data_india <- data %>%
  filter(Country == "India")

# Filter the dataset to include data only for the United states
data_us <- data %>%
  filter(Country == "United States")

# Filter the dataset to include data only for the japan
data_japan <- data %>%
  filter(Country == "Japan")

# Filter the dataset to include data only for the United kingdom
data_uk <- data %>%
  filter(Country == "United Kingdom")

# Filter the dataset to include data only for the france
data_france <- data %>%
  filter(Country == "France")

# Filter the dataset to include data only for the china
data_china <- data %>%
  filter(Country == "China")

# Filter the dataset to include data only for the germany
data_germany <- data %>%
  filter(Country == "Germany")

# Filter the dataset to include data only for the russia
data_russia <- data %>%
  filter(Country == "Russia")

# Filter the dataset to include data only for the south africa
data_SouthAfrica <- data %>%
  filter(Country == "South Africa")

# Filter the dataset to include data only for the australia
data_australia <- data %>%
  filter(Country == "Australia")

# Filter the dataset to include data only for the canada
data_canada <- data %>%
  filter(Country == "Canada")

# Filter the dataset to include data only for the italy
data_italy <- data %>%
  filter(Country == "Italy")

# Filter the dataset to include data only for the brazil
data_brazil <- data %>%
  filter(Country == "Brazil")

# Filter the dataset to include data only for the south korea
data_southkorea <- data %>%
  filter(Country == "Korea")

# Filter the dataset to include data only for the spain
data_spain <- data %>%
  filter(Country == "Spain")

# Filter the dataset to include data only for the mexico
data_mexico <- data %>%
  filter(Country == "Mexico")

# Filter the dataset to include data only for the indonesia
data_indonesia <- data %>%
  filter(Country == "Indonesia")

# Filter the dataset to include data only for the turkey
data_Türkiye <- data %>%
  filter(Country == "Türkiye")

# Filter the dataset to include data only for the saudi arabia
data_saudiarabia <- data %>%
  filter(Country == "Saudi Arabia")

# Filter the dataset to include data only for the netherlands
data_netherlands <- data %>%
  filter(Country == "Netherlands")

# Filter the dataset to include data only for the argentina
data_argentina <- data %>%
  filter(Country == "Argentina")