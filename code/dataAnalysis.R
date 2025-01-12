# Analyze total deaths by region, age group, and sex
total_deaths_summary <- data_long %>%
  group_by(Region, Age_Group, Sex) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  arrange(desc(Total_Deaths))
print(total_deaths_summary)

# Summary statistics for deaths by region and age group
grouped_summary <- data_long %>%
  group_by(Region, Age_Group) %>%
  summarise(
    Total_Deaths = sum(Deaths, na.rm = TRUE),
    Mean_Deaths = mean(Deaths, na.rm = TRUE),
    Median_Deaths = median(Deaths, na.rm = TRUE)
  )
print(grouped_summary)

# Correlation matrix for numeric variables
numeric_data <- data_long %>% select_if(is.numeric)
cor_matrix <- cor(numeric_data, use = "complete.obs")
print(cor_matrix)
