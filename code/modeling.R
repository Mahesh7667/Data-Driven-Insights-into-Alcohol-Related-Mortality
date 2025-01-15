# Predictive modeling ----
library(randomForest)
## split the dataset ----
set.seed(123)

# Split data into training (80%) and testing (20%) sets
train_index <- sample(1:nrow(data_long), 0.8 * nrow(data_long))
train_data <- data_long[train_index, ]
test_data <- data_long[-train_index, ]

## lrm ----
# Linear Regression Model
lm_model <- lm(Deaths ~ ., data = train_data)

# Predictions on Test Data
lm_predictions <- predict(lm_model, newdata = test_data)

# Evaluate Performance of Linear Regression
lm_rmse <- sqrt(mean((test_data$Deaths - lm_predictions)^2))
lm_r2 <- 1 - sum((test_data$Deaths - lm_predictions)^2) / sum((test_data$Deaths - mean(test_data$Deaths))^2)

# Print Performance Metrics
cat("Linear Regression RMSE:", lm_rmse, "\n")
cat("Linear Regression R-squared:", lm_r2, "\n")

# Visualization: Actual vs Predicted for Linear Regression
ggplot(data = data.frame(Actual = test_data$Deaths, Predicted = lm_predictions), aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  labs(
    title = "Actual vs Predicted Deaths (Linear Regression)",
    x = "Actual Deaths",
    y = "Predicted Deaths"
  ) +
  theme_minimal()

# Plotting residuals for Linear Regression
lm_residuals <- test_data$Deaths - lm_predictions
ggplot(data = test_data, aes(x = lm_predictions, y = lm_residuals)) +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residuals Plot (Linear Regression)",
       x = "Predicted Deaths", y = "Residuals")


## RF ----
# Train the Random Forest model using the training data
rf_model <- randomForest(Deaths ~ .,
                         data = train_data[, !names(train_data) %in% c("Year", "cause", "code")]
                    ,importance = TRUE)

# Print the model summary
print(rf_model)
importance(rf_model)

# Make predictions on the test set
rf_predictions <- predict(rf_model, newdata = test_data)

# Calculate RMSE (Root Mean Squared Error)
rf_rmse <- sqrt(mean((rf_predictions - test_data$Deaths)^2))
cat("Random Forest RMSE:", rf_rmse, "\n")

# Calculate R-squared
rf_r2 <- 1 - sum((rf_predictions - test_data$Deaths)^2) / sum((test_data$Deaths - mean(test_data$Deaths))^2)
cat("Random Forest R-squared:", rf_r2, "\n")



# Feature Importance Plot from Random Forest Model
importance_df <- data.frame(Feature = rownames(rf_model$importance),
                            Importance = rf_model$importance[, 1])



# Residuals Plot
residuals <- rf_predictions - test_data$Deaths
ggplot(data.frame(residuals), aes(x = residuals)) +
  geom_histogram(binwidth = 50, fill = "lightblue", color = "black", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Residuals of Random Forest Predictions",
       x = "Residuals", y = "Frequency")



# Feature importance plot for Random Forest model
importance_rf <- importance(rf_model)
varImpPlot(rf_model, main = "Random Forest Feature Importance")




# Predicted vs Actual for Random Forest
plot(test_data$Deaths, rf_predictions,
     main = "Random Forest: Predicted vs Actual",
     xlab = "Actual Deaths", ylab = "Predicted Deaths",
     col = "blue", pch = 16)
abline(0, 1, col = "red")

# Visualization: Actual vs Predicted for Linear Regression
ggplot(data = data.frame(Actual = test_data$Deaths, Predicted = rf_predictions), aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  labs(
    title = "Actual vs Predicted Deaths - Random Forest",
    x = "Actual Deaths",
    y = "Predicted Deaths"
  ) +
  theme_minimal()

# Plotting residuals for Linear Regression
rf_residuals <- test_data$Deaths - rf_predictions
ggplot(data = test_data, aes(x = rf_predictions, y = rf_residuals)) +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residuals Plot - Random Forest",
       x = "Predicted Deaths", y = "Residuals")

