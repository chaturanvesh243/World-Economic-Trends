#Gross domestic product, current prices

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)


# Filter the row for "India" and "Current account balance"
row_data10 <- data %>%
  filter(Country == "India" & `Subject Descriptor` == "Gross domestic product, current prices" )

row_data10<- row_data10 %>%
  filter(Units=="U.S. dollars" )

gdp_ind <- row_data10 %>%
  select(`Subject Descriptor`, `1980`:`2021`)

# Convert year columns to numeric
year_columns <- as.character(seq(1980, 2021))  # Assuming the year columns are named from 1980 to 2021

# Filter and select the desired columns
gdp_ind <-gdp_ind %>%
  select(`Subject Descriptor`, all_of(year_columns))

gdp_ind[year_columns] <- lapply(gdp_ind[year_columns], as.numeric)




# Transpose the data for easier handling
gdp_ind_t <- as.data.frame(t(gdp_ind[,-1]))
colnames(gdp_ind_t) <- gdp_ind$`Subject Descriptor`
gdp_ind_t$Year <- as.numeric(rownames(gdp_ind_t))
colnames(gdp_ind_t)[1] <- "GDP"

# Calculate GDP growth rate
gdp_ind_t <- gdp_ind_t %>%
  arrange(Year) %>%
  mutate(GDP_Growth_Rate = (GDP - lag(GDP)) / lag(GDP))

# Identify recession periods (two consecutive years of negative GDP growth)
recession_periods <- which(diff(gdp_ind_t$GDP_Growth_Rate < 0) == 1)
recession_years <- gdp_ind_t$Year[recession_periods + 1]

# Print recession years
print(recession_years)



# Plot GDP Growth Rate with Recession Periods Highlighted
gdp_ind_t <- gdp_ind_t %>%
  mutate(Recession = ifelse(Year %in% recession_years, "Recession", "Non-Recession"))


# Plot GDP growth rate
p1<-ggplot(gdp_ind_t, aes(x = Year, y = GDP_Growth_Rate, color = Recession)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Recession" = "red", "Non-Recession" = "black")) +
  labs(title = "GDP Growth Rate Over Time with Recession Periods",
       x = "Year",
       y = "GDP Growth Rate",
       color = "Period") +
  theme_minimal()
print(p1)
