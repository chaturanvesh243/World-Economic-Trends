# Filter the row for "United States" and "Unemployment rate"
row_data5 <- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Unemployment rate" )

row_data5<- row_data5 %>%
  filter(Units=="Percent of total labor force" )

unemp_us <- row_data5 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
unemp_us <-unemp_us %>%
  select(`Subject Descriptor`, all_of(year_columns))

unemp_us[year_columns] <- lapply(unemp_us[year_columns], as.numeric)

