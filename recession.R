# Load necessary libraries if not already loaded
library(dplyr)

# Transpose the data for easier handling
gdp_us_t <- as.data.frame(t(gdp_us[,-1]))
colnames(gdp_us_t) <- gdp_us$`Subject Descriptor`
gdp_us_t$Year <- as.numeric(rownames(gdp_us_t))
colnames(gdp_us_t)[1] <- "GDP"

# Calculate GDP growth rate
gdp_us_t <- gdp_us_t %>%
  arrange(Year) %>%
  mutate(GDP_Growth_Rate = (GDP - lag(GDP)) / lag(GDP))

# Identify recession periods (two consecutive years of negative GDP growth)
recession_periods <- which(diff(gdp_us_t$GDP_Growth_Rate < 0) == 1)
recession_years <- gdp_us_t$Year[recession_periods + 1]

# Print recession years
print(recession_years)



# Load necessary libraries
library(ggplot2)
library(dplyr)

# Plot GDP Growth Rate with Recession Periods Highlighted
gdp_us_t <- gdp_us_t %>%
  mutate(Recession = ifelse(Year %in% recession_years, "Recession", "Non-Recession"))


# Plot GDP growth rate
p1<-ggplot(gdp_us_t, aes(x = Year, y = GDP_Growth_Rate, color = Recession)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Recession" = "red", "Non-Recession" = "black")) +
  labs(title = "GDP Growth Rate Over Time with Recession Periods",
       x = "Year",
       y = "GDP Growth Rate",
       color = "Period") +
  theme_minimal()
print(p1)

install.packages("gridExtra")
library(ggplot2)
library(dplyr)
library(tidyr)
library(gridExtra)


# Transpose unemployment_us
unemp_us_t <- unemp_us %>%
  pivot_longer(-"Subject Descriptor", names_to = "Year", values_to = "Unemployment_Rate") %>%
  select(-"Subject Descriptor") %>%
  mutate(Year = as.numeric(Year))

# Identify recession periods using unemployment rate
unemp_us_t <- unemp_us_t %>%
  arrange(Year) %>%
  mutate(Unemployment_Change = Unemployment_Rate - lag(Unemployment_Rate))

recession_years_unemployment <- unemp_us_t %>%
  filter(Unemployment_Change > 1 & lag(Unemployment_Change) > 1) %>%
  pull(Year)

# Add recession column
unemp_us_t <- unemp_us_t %>%
  mutate(Recession = ifelse(Year %in% recession_years_unemployment, "Recession", "Non-Recession"))

print(recession_years_unemployment)


# Plot unemployment rate with recession periods highlighted
p4 <- ggplot(unemp_us_t, aes(x = Year, y = Unemployment_Rate, color = Recession)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Recession" = "red", "Non-Recession" = "black")) +
  labs(title = "Unemployment Rate Over Time with Recession Periods",
       x = "Year",
       y = "Unemployment Rate (%)",
       color = "Period") +
  theme_minimal()

print(p4)

# Merge with gdp_us_t data
merged_data <- merge(gdp_us_t, unemp_us_t, by = "Year")

# Plot unemployment rate with recession periods highlighted
p2 <- ggplot(merged_data, aes(x = Year, y = Unemployment_Rate, color = Recession)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Recession" = "red", "Non-Recession" = "black")) +
  labs(title = "Unemployment Rate Over Time with Recession Periods",
       x = "Year",
       y = "Unemployment Rate (%)",
       color = "Period") +
  theme_minimal()

# Display the plot
print(p2)

# Arrange the plots side by side
grid.arrange(p1, p2, ncol = 2)


# Transpose inflation_us
inflation_us_t <- inflation_us_index %>%
  pivot_longer(-"Subject Descriptor", names_to = "Year", values_to = "Inflation_Rate") %>%
  select(-"Subject Descriptor") %>%
  mutate(Year = as.numeric(Year))

# Merge with existing data
merged_data <- merge(merged_data, inflation_us_t, by = "Year")

p3 <- ggplot(merged_data, aes(x = Year, y = Inflation_Rate.x, color = Recession)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  scale_color_manual(values = c("Recession" = "red", "Non-Recession" = "black")) +
  labs(title = "Inflation Rate Over Time with Recession Periods",
       x = "Year",
       y = "Inflation Rate (%)",
       color = "Period") +
  theme_minimal()

# Display the plot
print(p3)
