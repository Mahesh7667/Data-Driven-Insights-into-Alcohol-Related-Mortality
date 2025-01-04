
#part 1 ----
# Load required libraries
library(tidyverse)
library(readxl)
library(knitr)  # For creating nicely formatted tables


if (!require("kableExtra")) install.packages("kableExtra")

library(kableExtra)  # For enhanced table formatting

# Load the Excel data
file_path <- "final xl.xlsx"  # Set the correct path to your file
data <- read_excel(file_path, sheet = "Sheet1")

# Reshape data into long format for easier analysis
age_columns <- colnames(data)[grepl("^[<0-9]", colnames(data))]
long_data <- data %>%
  select(Year = `Year [note 3]`, Sex, all_of(age_columns)) %>%
  pivot_longer(
    cols = all_of(age_columns),
    names_to = "Age_Group",
    values_to = "Deaths"
  )

# Summarize total deaths by year and age group
summary_table <- long_data %>%
  group_by(Year, Age_Group) %>%
  summarize(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()

# Generate a pivot table: Year vs Age Groups
pivot_table <- summary_table %>%
  pivot_wider(names_from = Age_Group, values_from = Total_Deaths, values_fill = 0)

# Print pivot table
kable(pivot_table, caption = "Alcohol-Specific Deaths by Year and Age Group") %>%
  kable_styling(full_width = TRUE)

# Plot trends over time for each age group
ggplot(summary_table, aes(x = Year, y = Total_Deaths, color = Age_Group)) +
  geom_line(size = 1) +
  labs(
    title = "Trends in Alcohol-Specific Deaths by Age Group",
    x = "Year",
    y = "Total Deaths",
    color = "Age Group"
  ) +
  theme_minimal()

# Optional: Trends by sex
sex_summary <- long_data %>%
  group_by(Year, Sex, Age_Group) %>%
  summarize(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()

# Plot trends by sex and age group
ggplot(sex_summary, aes(x = Year, y = Total_Deaths, color = Age_Group, linetype = Sex)) +
  geom_line(size = 1) +
  labs(
    title = "Alcohol-Specific Deaths by Age Group and Sex",
    x = "Year",
    y = "Total Deaths",
    color = "Age Group",
    linetype = "Sex"
  ) +
  theme_minimal()






















# part 2 ----



# Load necessary libraries
library(dplyr)

# Compute multiple EDA metrics and combine them into a single table
eda_summary_table <- data_long %>%
  group_by(  Age_Group) %>%
  summarise(
    Total_Deaths = sum(Deaths, na.rm = TRUE),
    Mean_Deaths = mean(Deaths, na.rm = TRUE),
    Median_Deaths = median(Deaths, na.rm = TRUE),
    SD_Deaths = sd(Deaths, na.rm = TRUE),
    Variance_Deaths = var(Deaths, na.rm = TRUE),
    CV_Deaths = ifelse(Mean_Deaths != 0, (SD_Deaths / Mean_Deaths) * 100, NA), # Coefficient of Variation
    Min_Deaths = min(Deaths, na.rm = TRUE),
    Max_Deaths = max(Deaths, na.rm = TRUE),
    Deaths_Per_Year = Total_Deaths / n_distinct(Year), # Average deaths per year
    Outliers_Lower = sum(Deaths < (quantile(Deaths, 0.25, na.rm = TRUE) - 1.5 * IQR(Deaths, na.rm = TRUE)), na.rm = TRUE),
    Outliers_Upper = sum(Deaths > (quantile(Deaths, 0.75, na.rm = TRUE) + 1.5 * IQR(Deaths, na.rm = TRUE)), na.rm = TRUE)
  ) %>%
  ungroup()

# View the resulting table
head(eda_summary_table, 10)


# part 3 ----.


summary_stats <- data_long %>%
  group_by(Sex, Age_Group) %>%
  summarise(
    Total_Deaths = sum(Deaths, na.rm = TRUE),
    Mean_Deaths = mean(Deaths, na.rm = TRUE),
    Median_Deaths = median(Deaths, na.rm = TRUE),
    SD_Deaths = sd(Deaths, na.rm = TRUE)
  )

# View the top 10 rows of summary
head(summary_stats, 10)




# Year-over-year growth rate
growth_rate <- data_long %>%
  group_by(Year) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  mutate(
    Growth_Rate = (Total_Deaths - lag(Total_Deaths)) / lag(Total_Deaths) * 100
  )

# View growth rate table
head(growth_rate, 10)

# Create contingency table for Age_Group and Deaths
age_deaths_table <- table(data_long$Age_Group, data_long$Deaths > 0)

# Chi-Square Test
chisq.test(age_deaths_table)


anova_test <- aov(Deaths ~ Sex, data = data_long)
summary(anova_test)


# Correlation between Deaths and All.ages
cor_test <- cor.test(data_long$Deaths, data_long$All.ages, use = "complete.obs")

# Display correlation result
cor_test


# K-means clustering for regions based on total deaths
region_cluster <- data_long %>%
  group_by(Age_Group) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  mutate(Cluster = kmeans(Total_Deaths, centers = 3)$cluster)

# View clusters
head(region_cluster, 10)



iqr_values <- data_long %>%
  group_by(Age_Group) %>%
  summarise(
    Q1 = quantile(Deaths, 0.25, na.rm = TRUE),
    Q3 = quantile(Deaths, 0.75, na.rm = TRUE),
    IQR = Q3 - Q1
  ) %>%
  mutate(
    Lower_Bound = Q1 - 1.5 * IQR,
    Upper_Bound = Q3 + 1.5 * IQR
  )

# Filter outliers
outliers <- data_long %>%
  inner_join(iqr_values, by = "Age_Group") %>%
  filter(Deaths < Lower_Bound | Deaths > Upper_Bound)

# View outliers
head(outliers, 10)


# part 3 ----

# Load necessary libraries
library(corrplot)

str(data_long)


data_long$Sex_numeric <- as.numeric(data_long$Sex) # Male = 1, Female = 2, Persons = 3

# Subset the dataset to include only numeric columns
numeric_data <- data_long %>%
  select_if(is.numeric) # Select only numeric columns

# Compute the correlation matrix
correlation_matrix <- cor(numeric_data, use = "complete.obs")

# Display the correlation matrix
print(correlation_matrix)

# Visualize the correlation matrix
corrplot(correlation_matrix, method = "circle", type = "upper",
         title = "Correlation Matrix", tl.cex = 0.8, addCoef.col = "black",
         mar = c(0, 0, 1, 0)) # Add title
 
