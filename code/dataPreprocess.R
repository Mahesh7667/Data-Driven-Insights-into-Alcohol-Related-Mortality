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

dataExcelSheet <- loadWorkbook('deathsbyindividualcause.xlsx')

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

dataExcelSheet <- loadWorkbook('alcoholspecificdeaths2021.xlsx')

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
