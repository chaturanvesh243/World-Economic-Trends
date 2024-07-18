#normalize the curr acc balance, gdp, inflation index, structural balance

min_curr_acc_bal=min(melted_data$Value)
max_curr_acc_bal=max(melted_data$Value)
melted_data$norm_value=(melted_data$Value - min_curr_acc_bal) / (max_curr_acc_bal - min_curr_acc_bal)

min_gdp=min(melted_data1$Value)
max_gdp=max(melted_data1$Value)
melted_data1$norm_value=(melted_data1$Value - min_gdp) / (max_gdp - min_gdp)

min_inf_index=min(melted_data3$Value)
max_inf_index=max(melted_data3$Value)
melted_data3$norm_value=(melted_data3$Value - min_inf_index) / (max_inf_index - min_inf_index)

min_strcbal=min(melted_data4$Value)
max_strcbal=max(melted_data4$Value)
melted_data4$norm_value=(melted_data4$Value - min_strcbal) / (max_strcbal - min_strcbal)


#plot all four

install.packages("reshape2")

library(dplyr)
library(ggplot2)

# Add a dataset identifier column to each melted dataset
melted_data$dataset <- "us_curr_acc_bal"
melted_data1$dataset <- "us_gdp"
melted_data3$dataset <- "us_inf_index"
melted_data4$dataset <- "us_strcbal"


# Combine all melted datasets into one
combined_data <- bind_rows(melted_data, melted_data1, melted_data3, melted_data4)

# Plot the graph
ggplot(combined_data, aes(x = Year, y = norm_value, color = dataset)) +
  geom_line() +
  labs(x = "Year", y = "Norm Value", color = "Dataset") +
  theme_minimal()
