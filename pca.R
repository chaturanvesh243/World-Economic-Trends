# Prepare data for PCA
pca_data <- merged_data %>%
  select(Year, GDP_Growth_Rate, Unemployment_Rate, Inflation_Rate.x, Current_acc, Exports, Population) %>%
  na.omit()

# Perform PCA
pca_result <- prcomp(pca_data, scale. = TRUE)

# Visualize PCA results
install.packages("ggfortify")
library(ggfortify)


# Extract non-NA rows used for PCA from the original merged_data
merged_data_non_na <- merged_data %>%
  filter(complete.cases(select(., GDP_Growth_Rate, Unemployment_Rate, Inflation_Rate.x, Current_acc, Exports, Population)))

#visualize PCA results
autoplot(pca_result, data = merged_data_non_na, colour = 'Year', label = TRUE, label.size = 3)


# Annotate PCA plot with key years
library(ggplot2)
library(ggfortify)

autoplot(pca_result, data = pca_data, colour = 'Year', label = TRUE, label.size = 3) +
  scale_color_gradient(low = "blue", high = "lightblue") +
  labs(title = "PCA of Economic Indicators Over Time",
       x = paste("PC1 (", round(summary(pca_result)$importance[2,1] * 100, 2), "%)", sep = ""),
       y = paste("PC2 (", round(summary(pca_result)$importance[2,2] * 100, 2), "%)", sep = "")) +
  geom_text(aes(label = ifelse(Year %in% c(1990:1995, 2008, 2009, 2010, 2011), as.character(Year), "")), 
            hjust = 0, vjust = -0.5, color = "red") +
  theme_minimal()
