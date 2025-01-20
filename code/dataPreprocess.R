if (!require("openxlsx")) install.packages("openxlsx")
if (!require("plyr")) install.packages("plyr")
if (!require("reshape2")) install.packages("reshape2")
if (!require("randomForest")) install.packages("randomForest")


#  Rename columns
correct_column_names <- c(
  "Year", "Sex", "code", "cause",
  "<1", "01-04", "05-09", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39",
  "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84",
  "85-89", "90+", "All ages", "Region"
)

library(openxlsx)
library(plyr)
setwd('..')
dataExcelSheet <- loadWorkbook('data/deathsbyindividualcause.xlsx')

## Load excel ----
df1 <- readWorkbook(dataExcelSheet,sheet = "Table 1")
head(df1)
df1 <- df1[-c(1:3),]
head(df1)
df1["Region"] <- "United Kingdom"
colnames(df1) <- correct_column_names

df2 <- readWorkbook(dataExcelSheet,sheet = "Table 2")
head(df2)
df2 <- df2[-c(1:3),]
head(df2)

df2["Region"] <- "England"
colnames(df2) <- correct_column_names

df3 <- readWorkbook(dataExcelSheet,sheet = "Table 3")
head(df3)
df3 <- df3[-c(1:3),]
head(df3)

df3["Region"] <- "Wales"
colnames(df3) <- correct_column_names

df4 <- readWorkbook(dataExcelSheet,sheet = "Table 4")
head(df4)
df4 <- df4[-c(1:3),]
head(df4)
df4["Region"] <- "Scotland"
colnames(df4) <- correct_column_names


df5 <- readWorkbook(dataExcelSheet,sheet = "Table 5")
head(df5)
df5 <- df5[-c(1:3),]
head(df5)
df5["Region"] <- " Northern Ireland"
colnames(df5) <- correct_column_names

data <- rbind.fill(df1,df2,df3,df4,df5)
head(data)


## load supplementary data ----

correct_column_names <- c(
  "Area_Code"	,"Area_Name",	"Sex"	,"Year" ,
  "Death_Count",
  "Age_Rate",
  "Lower_Confidence_Interval",
  "Upper_Confidence_Interval"
)

dataExcelSheet <- loadWorkbook('data/alcoholspecificdeaths2021.xlsx')

# Load supplementary dataset
supplementary_data <- readWorkbook(dataExcelSheet,sheet = "Table 1")


# View the structure of the dataset
head(supplementary_data)
supplementary_data <- supplementary_data[-c(1:4),]
colnames(supplementary_data) <- correct_column_names
head(supplementary_data)

head(supplementary_data)


# EDA ----
## clean data ----
# Assuming your data is loaded into a data frame called 'data'
# Convert numeric columns
numeric_columns <- c("Year","<1", "01-04", "05-09", "10-14", "15-19", "20-24", "25-29",
                     "30-34", "35-39", "40-44", "45-49", "50-54", "55-59",
                     "60-64", "65-69", "70-74", "75-79", "80-84", "85-89", "90+", "All ages")
data[numeric_columns] <- lapply(data[numeric_columns], as.numeric)

# Clean column names: Remove non-alphanumeric characters (including leading numbers)
colnames(data) <- make.names(colnames(data), unique = TRUE)

# Check the cleaned column names
colnames(data)

# Inspect column names
colnames(data)

# Convert columns that need to be factors (e.g., Sex, ICD-10 code, etc.)
data$Sex <- as.factor(data$Sex)
data$Region <- as.factor(data$Region)

library(tidyr)
data_long <- data %>%
  pivot_longer(cols = starts_with("X"),  # Start with columns that represent age groups
               names_to = "Age_Group",
               values_to = "Deaths")

head(data_long)
tail(data_long)


library(dplyr)
library(plyr)

## Analysis ----
# Summary statistics
summary(data_long)

# Check for missing values
colSums(is.na(data_long))

detach(package:plyr)


# Filter out the "Persons" category
data_long <- data_long %>%
  filter(Sex %in% c("Males", "Females"))

supplementary_data <- supplementary_data %>%
  filter(Sex %in% c("Males", "Females"))

# Filter out the "United Kingdom" region
data_long <- data_long %>%
  filter(!Region %in% c("United Kingdom"))



total_deaths_summary <- data_long %>%
  group_by(Region, Age_Group, Sex) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  arrange(desc(Total_Deaths))
print(total_deaths_summary)

avg_deaths_summary <- data_long %>%
  group_by(Region, Age_Group) %>%
  summarise(Avg_Deaths = mean(Deaths, na.rm = TRUE)) %>%
  arrange(desc(Avg_Deaths))
print(avg_deaths_summary)

yearly_deaths_region <- data_long %>%
  group_by(Year, Region) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE))
print(yearly_deaths_region)

yearly_deaths_region <- data_long %>%
  group_by(Year, Region) %>%
  mutate(Total_Deaths = sum(Deaths, na.rm = TRUE))
print(yearly_deaths_region)

yearly_deaths_age <- data_long %>%
  group_by(Year, Age_Group) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE))
print(yearly_deaths_age)

deaths_distribution <- data_long %>%
  group_by(Region, Age_Group) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  pivot_wider(names_from = Age_Group, values_from = Total_Deaths)
print(deaths_distribution)

sex_proportion <- data_long %>%
  group_by(Sex) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  mutate(Proportion = Total_Deaths / sum(Total_Deaths))
print(sex_proportion)

regional_sex_disparity <- data_long %>%
  group_by(Region, Sex) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  arrange(Region, desc(Total_Deaths))
print(regional_sex_disparity)

# Summarize deaths by Age Group and Region
total_deaths_summary <- data_long %>%
  group_by(Age_Group, Region) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE),
            Mean_Deaths = mean(Deaths, na.rm = TRUE),
            Median_Deaths = median(Deaths, na.rm = TRUE),
            SD_Deaths = sd(Deaths, na.rm = TRUE),
            Min_Deaths = min(Deaths, na.rm = TRUE),
            Max_Deaths = max(Deaths, na.rm = TRUE)) %>%
  arrange(Region, Age_Group)

# Print the summary table
print(total_deaths_summary)

# Summarize deaths by Age Group and Region
total_deaths_summary <- data_long %>%
  group_by( Region) %>%
  summarise(Total_Deaths = sum(Deaths, na.rm = TRUE),
            Mean_Deaths = mean(Deaths, na.rm = TRUE),
            Median_Deaths = median(Deaths, na.rm = TRUE),
            SD_Deaths = sd(Deaths, na.rm = TRUE),
            Min_Deaths = min(Deaths, na.rm = TRUE),
            Max_Deaths = max(Deaths, na.rm = TRUE)) %>%
  arrange(Region)

# Print the summary table
print(total_deaths_summary)


library(dplyr)

# Convert relevant columns to appropriate data types
supplementary_data <- supplementary_data %>%
  mutate(
    Year = as.numeric(Year),
    Death_Count = as.numeric(Death_Count),
    Age_Rate = as.numeric(Age_Rate),
    Lower_Confidence_Interval = as.numeric(Lower_Confidence_Interval),
    Upper_Confidence_Interval = as.numeric(Upper_Confidence_Interval),
    Sex = as.factor(Sex)
  )



# Filter out the "Persons" category
data_long_filtered <- data_long %>%
  filter(Sex %in% c("Males", "Females"))


data_long_filtered <- data_long_filtered %>%
  mutate(Region = recode_factor(Region,
                                ` Northern Ireland` = "NI",
                                `United Kingdom` = "UK",
                                Scotland = "SCT",
                                England = "ENG",
                                Wales = "WLS"
  ))

# Aggregate the data by Area (sum the number of deaths)
aggregated_data <- supplementary_data %>% 
  filter(Sex %in% c("Males", "Females")) %>%
  group_by(Area_Code) %>%
  summarise(
    Total_Deaths = sum(Death_Count, na.rm = TRUE)
  )

setwd('code/')