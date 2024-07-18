#Gross domestic product, constant prices

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Assuming 'data' contains your dataset

# Filter the row for "United States" and "Current account balance"
gdp_usa_exp<- data %>%
  filter(Country == "United States" & `Subject Descriptor` == "Gross domestic product, constant prices" )

gdp_usa_exp<- gdp_usa_exp %>%
  filter(Units=="National currency" )

gdp_usa_exp<- gdp_usa_exp[-(1:9)]
gdp_usa_exp<- gdp_usa_exp[-(43:50)]


# Convert the data to a time series
gdp_usa_exp_ts <- ts(as.numeric(unlist(gdp_usa_exp)), start = 1980)  # Assuming 1980 is the starting year


install.packages("forecast")
library(forecast)


# Fit an ARIMA model
arima_model <- auto.arima(gdp_usa_exp_ts)

# Make forecasts
forecast_values <- forecast(arima_model, h = 5)  # Forecast for the next 5 years

# Print forecasts
print(forecast_values)


install.packages("keras")
install.packages("reticulate")


# Load required libraries
library(keras)
library(reticulate)

# Set seed for reproducibility
set.seed(42)


gdp_usa_exp<-as.numeric(gdp_usa_exp)
gdp_us_norm<-scale(gdp_usa_exp)


# Step 3: Create input-output sequences
input_length <- 10  # Define the length of input sequences
output_length <- 1  # Define the length of output sequences

train_data <- list()

for (i in 1:(length(gdp_usa_exp) - input_length - output_length + 1)) {
  input_seq <- gdp_usa_exp[i:(i + input_length - 1)]
  output_seq <- gdp_usa_exp[(i + input_length):(i + input_length + output_length - 1)]
  train_data[[i]] <- list(input_seq, output_seq)
}

# Convert train_data to array format (required for LSTM input)
X_train <- array(unlist(lapply(train_data, function(x) x[[1]])), dim = c(length(train_data), input_length, 1))
y_train <- array(unlist(lapply(train_data, function(x) x[[2]])), dim = c(length(train_data), output_length))

# Print dimensions of X_train and y_train to verify
print(dim(X_train))
print(dim(y_train))


install_tensorflow()



# Define the LSTM model
model <- keras_model_sequential() %>%
  layer_lstm(units = 50, input_shape = c(input_length, 1)) %>%
  layer_dense(units = output_length)


