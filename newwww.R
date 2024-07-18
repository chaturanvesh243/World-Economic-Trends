# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)


#---------------------

# Transpose current_acc_us
current_acc_us_t <- current_acc_us %>%
  pivot_longer(-"Subject Descriptor", names_to = "Year", values_to = "Current_acc") %>%
  select(-"Subject Descriptor") %>%
  mutate(Year = as.numeric(Year))

# Assuming 'data' contains your dataset

# Filter the row for "United States" and "Population"
row_data6 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Population" )

row_data6<- row_data6 %>%
  filter(Units=="Persons" )

population_us <- row_data6 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
population_us <-population_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

population_us[year_columns] <- lapply(population_us[year_columns], as.numeric)


# Transpose population_us
population_us_t <- population_us %>%
  pivot_longer(-"Subject Descriptor", names_to = "Year", values_to = "Population") %>%
  select(-"Subject Descriptor") %>%
  mutate(Year = as.numeric(Year))

#-----------------------------------------------------------------------------------

# Filter the row for "United States" and "Employment"
row_data7 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Employment" )

row_data7<- row_data7 %>%
  filter(Units=="Persons" )

employment_us <- row_data7 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
employment_us <-employment_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

employment_us[year_columns] <- lapply(employment_us[year_columns], as.numeric)


# Transpose employment_us
employment_us_t <- employment_us %>%
  pivot_longer(-"Subject Descriptor", names_to = "Year", values_to = "Employment") %>%
  select(-"Subject Descriptor") %>%
  mutate(Year = as.numeric(Year))


#-----------------------------------------------------------------------------------

# Filter the row for "United States" and "Volume of imports of goods and services"
row_data8 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Volume of imports of goods and services" )

row_data8<- row_data8 %>%
  filter(Units=="Percent change" )

imports_us <- row_data8 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
imports_us <-imports_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

imports_us[year_columns] <- lapply(imports_us[year_columns], as.numeric)


# Transpose employment_us
imports_us_t <- imports_us %>%
  pivot_longer(-"Subject Descriptor", names_to = "Year", values_to = "Imports") %>%
  select(-"Subject Descriptor") %>%
  mutate(Year = as.numeric(Year))


#-----------------------------------------------------------------------------------

# Filter the row for "United States" and "Volume of exports of goods and services"
row_data9 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Volume of exports of goods and services" )

row_data9<- row_data9 %>%
  filter(Units=="Percent change" )

exports_us <- row_data9 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
exports_us <-exports_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

exports_us[year_columns] <- lapply(exports_us[year_columns], as.numeric)


# Transpose employment_us
exports_us_t <- exports_us %>%
  pivot_longer(-"Subject Descriptor", names_to = "Year", values_to = "Exports") %>%
  select(-"Subject Descriptor") %>%
  mutate(Year = as.numeric(Year))

#------------------------------------------------------------------------------------------

# Merge with existing data
merged_data <- merge(merged_data,imports_us_t, by = "Year")
merged_data <- merge(merged_data,exports_us_t, by = "Year")
merged_data <- merge(merged_data,employment_us_t, by = "Year")
merged_data <- merge(merged_data,population_us_t, by = "Year")
merged_data <- merge(merged_data,current_acc_us_t, by = "Year")
