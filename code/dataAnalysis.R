
str(data)
str(supplementary_data)

# Calculate the mean age-standardized rate for each area
regional_analysis <- supplementary_data %>%
  group_by(Area_Name) %>%
  summarize(
    mean_rate = mean(Age_Rate, na.rm = TRUE),
    total_deaths = sum(Death_Count, na.rm = TRUE)
  ) %>%
  arrange(desc(mean_rate))

# View the top 10 high-risk areas
head(regional_analysis, 10)

# Plot age-standardized rates with confidence intervals over time for a selected area
selected_area <- "England"  # Change this to any area you want to analyze

# Compare age-standardized rates between males and females
gender_analysis <- supplementary_data %>%
  group_by(Sex, Year) %>%
  summarize(mean_rate = mean(Age_Rate, na.rm = TRUE))

total_deaths_summary <- data_long %>%
  group_by(Region, Age_Group, Sex) %>%
  dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()
print(total_deaths_summary)



# Plot top 10 regions by age-standardized rate

library(ggplot2)

top_regions <- regional_analysis %>%
  top_n(10, mean_rate)


# Top 10 causes of death
top_causes <- data_long %>%
  group_by(cause) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(Total_Deaths)) %>%
  slice(1:10)  # Select top 10 causes


numeric_data <- data_long %>% select_if(is.numeric)
cor_matrix <- cor(numeric_data, use = "complete.obs")

print(cor_matrix)

# Ensure Year is numeric
gender_analysis$Year <- as.numeric(gender_analysis$Year)

# Filter relevant genders
gender_analysis_filtered <- gender_analysis %>%
  filter(Sex %in% c("Males", "Females"))

# RQ 1 ----
library(dplyr)
library(ggplot2)
library(tidyr)
# Data Preprocessing: Aggregating by Year, Age Group, and Sex, and summing the Deaths
agg_data <- data_long %>%
  group_by(Year, Age_Group, Sex) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()

# Checking out the top causes of death (Alcohol-related)
top_causes <- data_long %>%
  group_by(cause) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  arrange(desc(Total_Deaths))

unique(data_long$Region)
unique(data_long$Age_Group)
unique(data_long$Sex)

sum(is.na(data_long$Region))
sum(is.na(data_long$Age_Group))
sum(is.na(data_long$Sex))

str(data_long$Region)
str(data_long$Age_Group)
str(data_long$Sex)


library(dplyr)
library(ggplot2)

# Assuming 'data' is your pivoted dataframe
age_group_region_trends <- data_long %>%
  group_by(Year, Age_Group, Region) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()

ggplot(age_group_region_trends, aes(x = Year, y = Total_Deaths, color = Region)) +
  geom_line() +
  facet_wrap(~ Age_Group, scales = "fixed", ncol = 4) +
  scale_x_continuous(breaks = seq(2000, 2020, by = 5)) +
  labs(title = "Age-Specific Mortality Trends by Region",
       x = "Year",
       y = "Total Alcohol-Specific Deaths",
       color = "Region") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Convert Sex to numeric values for correlation
data_long$Sex_numeric <- as.numeric(data_long$Sex)

# Calculate correlation matrix
cor_data <- data_long %>%
  select(Deaths, Sex_numeric, Year,All.ages) %>%
  cor(method = "pearson")

print(cor_data)

# Summarize total deaths by year and region
yearly_deaths_summary <- data_long %>%
  group_by(Year, Region) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE))

# Print the yearly summary table
print(yearly_deaths_summary)

# Summarize deaths by Year and Age Group
age_group_contribution <- data_long %>%
  group_by(Year, Age_Group) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()

# Summarize the proportion of alcohol-specific deaths by sex
sex_proportions <- data_long %>%
  group_by(Sex) %>%
  dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  mutate(Proportion = Total_Deaths / sum(Total_Deaths))

# Print the proportions table
print(sex_proportions)


# Summarizing total deaths by Region and Year
heatmap_data <- data_long %>%
  group_by(Year, Region) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()

print(heatmap_data)


# Summarizing deaths by Cause, Region, and Age Group
cause_analysis <- data_long %>%
  group_by(cause, Region, Age_Group) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  filter(Total_Deaths > 100) %>%
  ungroup()


# Summarize total deaths by cause
top_causes <- data_long %>%
  group_by(cause) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(Total_Deaths)) %>%
  slice(1:10)  # Select the top 10 causes

print(top_causes )

# Identify the major cause in each region
major_cause_by_region <- data_long %>%
  group_by(Region, cause) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE), .groups = "drop") %>%
  arrange(Region, desc(Total_Deaths)) %>%
  slice_max(order_by = Total_Deaths, n = 1, by = "Region")  # Top cause per region

print(major_cause_by_region)



# RQ 1 : attempt 2 ----


library(dplyr)
library(plyr)


library(dplyr)
detach(package:plyr)


View(supplementary_data)
str(supplementary_data)





# Load required libraries
library(dplyr)
library(tidyr)

main_data <- data_long
# Inspect the structure of both datasets
glimpse(main_data)
glimpse(supplementary_data)

# Check for missing values in both datasets
main_missing <- colSums(is.na(main_data))
supplementary_missing <- colSums(is.na(supplementary_data))

print("Missing Values in Main Dataset:")
print(main_missing)
print("Missing Values in Supplementary Dataset:")
print(supplementary_missing)


# Data type conversion (if not already converted)
main_data <- main_data %>%
  plyr::mutate(
    Year = as.numeric(Year),
    Deaths = as.numeric(Deaths),
    All.ages = as.numeric(All.ages),
    Sex = as.factor(Sex),
    Region = as.factor(Region)
  )

supplementary_data <- supplementary_data %>%
  plyr::mutate(
    Year = as.numeric(Year),
    Death_Count = as.numeric(Death_Count),
    Age_Rate = as.numeric(Age_Rate),
    Lower_Confidence_Interval = as.numeric(Lower_Confidence_Interval),
    Upper_Confidence_Interval = as.numeric(Upper_Confidence_Interval),
    Sex = as.factor(Sex)
  )

print(main_data)
print(supplementary_data)
# Merge datasets on Year and Sex
merged_data <- main_data %>%
  inner_join(supplementary_data, by = c("Year", "Sex"),   relationship = "many-to-many"
)

# Summarize basic statistics for numerical variables in the merged dataset
numerical_summary <- merged_data %>%
   dplyr::summarise(
    Total_Deaths = sum(Deaths, na.rm = TRUE),
    Average_Deaths = mean(Deaths, na.rm = TRUE),
    Median_Deaths = median(Deaths, na.rm = TRUE),
    Max_Deaths = max(Deaths, na.rm = TRUE),
    Min_Deaths = min(Deaths, na.rm = TRUE),
    SD_Deaths = sd(Deaths, na.rm = TRUE),
    Avg_Age_Rate = mean(Age_Rate, na.rm = TRUE),
    SD_Age_Rate = sd(Age_Rate, na.rm = TRUE)
  )
print("Numerical Summary:")
print(numerical_summary)

# # Grouped summaries by Region and Age_Group
# grouped_summary <- merged_data %>%
#   group_by(Region, Age_Group) %>%
#   dplyr::summarise(
#     Total_Deaths = sum(Deaths, na.rm = TRUE),
#     Avg_Age_Rate = mean(Age_Rate, na.rm = TRUE),
#     Deaths_Rate_Correlation = cor(Deaths, Age_Rate, use = "complete.obs")
#   ) %>%
#   arrange(desc(Total_Deaths))

print("Grouped Summary by Region and Age_Group:")
print(grouped_summary)

# Correlation Matrix for the merged dataset
numerical_cols <- merged_data %>%
  select_if(is.numeric)

correlation_matrix <- cor(numerical_cols, use = "complete.obs")
print("Correlation Matrix:")
print(correlation_matrix)

# Identify potential outliers using interquartile range (IQR) for Deaths
iqr_deaths <- IQR(merged_data$Deaths, na.rm = TRUE)
q1 <- quantile(merged_data$Deaths, 0.25, na.rm = TRUE)
q3 <- quantile(merged_data$Deaths, 0.75, na.rm = TRUE)

outlier_threshold_low <- q1 - 1.5 * iqr_deaths
outlier_threshold_high <- q3 + 1.5 * iqr_deaths

outliers <- merged_data %>%
  filter(Deaths < outlier_threshold_low | Deaths > outlier_threshold_high)

print("Outliers in Deaths:")
print(outliers)

# Analyze trends across time for Death_Count and Age_Rate
trend_analysis <- merged_data %>%
  group_by(Year) %>%
  dplyr::summarise(
    Avg_Deaths = mean(Deaths, na.rm = TRUE),
    Avg_Age_Rate = mean(Age_Rate, na.rm = TRUE),
    Total_Deaths = sum(Deaths, na.rm = TRUE)
  )
print("Trend Analysis by Year:")
print(trend_analysis)

# Check for distribution across regions
region_distribution <- merged_data %>%
  group_by(Region) %>%
  dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE))

print("Regional Death Distribution:")
print(region_distribution)

library(ggplot2)

library(reshape2)

# Convert correlation matrix to a long format for ggplot2
correlation_long <- melt(as.matrix(correlation_matrix))
