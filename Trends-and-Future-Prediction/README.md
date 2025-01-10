# Alcohol-Related Mortality Analysis: Trends, Predictors, and Future Insights

This repository contains the complete code and analysis for exploring alcohol-related mortality trends, identifying key predictors, and building predictive models. The project leverages statistical methods and machine learning (Random Forest) to uncover insights into alcohol-specific deaths across regions and demographics.

---

## **Contents**
1. [Introduction](#introduction)
2. [Research Questions](#research-questions)
3. [Datasets Used](#datasets-used)
4. [Methodology](#methodology)
5. [Results](#results)
6. [Run the Code](#run-the-code)
   - [Option 1: Google Colab](#option-1-google-colab)
   - [Option 2: Clone Repository](#option-2-clone-repository)
7. [Key Libraries](#key-libraries)

---

## **Introduction**
This project investigates alcohol-specific mortality trends and predictors using datasets on alcohol-related deaths in the United Kingdom. The aim is to provide actionable insights into public health policies by leveraging statistical modeling and machine learning techniques.

---

## **Research Questions**
1. **What are the historical trends in alcohol-specific deaths by age group and geographic region?**
2. **What are the key predictors of high mortality rates, and how well can we predict future death trends using historical data?**

---

## **Datasets Used**
1. **Alcohol-Specific Deaths Dataset**:
   - Source: National health data records (synthetic data for analysis purposes).
   - Includes variables like `Year`, `Sex`, `Region`, `Age_Group`, `Deaths`, and `Cause`.
   - Processed across regions: England, Scotland, Wales, Northern Ireland, and the United Kingdom as a whole.

2. **Supplementary Dataset**:
   - Includes age-standardized mortality rates (`Age_Rate`) and confidence intervals.

---

## **Methodology**
The following steps were performed to clean, preprocess, analyze, and model the data:

### 1. **Data Preprocessing**
- Imported raw data from Excel files using `openxlsx`.
- Cleaned data by:
  - Renaming columns for consistency.
  - Removing missing and irrelevant rows.
  - Converting relevant variables to numeric or factor types.
- Combined datasets across regions and reshaped them for analysis using `dplyr` and `tidyr`.

### 2. **Exploratory Data Analysis (EDA)**
- Analyzed trends in alcohol-specific deaths across years, regions, age groups, and causes.
- Used summary statistics, correlation matrices, and visualizations.

### 3. **Predictive Modeling**
- Built two models to predict alcohol-specific mortality:
  - **Linear Regression**:
    - RMSE: 19.56
    - \(R^2 = 0.39\)
  - **Random Forest**:
    - RMSE: 18.57
    - \(R^2 = 0.45\)
  - Key predictors: `All.ages`, `Age_Group`, and `Region`.
- Evaluated model performance using residual analysis and feature importance plots.

### 4. **Visualization**
- Created visualizations using `ggplot2` for:
  - Top 10 causes of alcohol-specific deaths.
  - Mortality trends by region and age group.
  - Actual vs. predicted mortality for Random Forest and Linear Regression models.

---

## **Results**
1. **Key Trends**:
   - Alcoholic liver disease accounts for over 70% of deaths.
   - Middle-aged individuals (ages 45–64) are at the highest risk.
   - Mortality rates have increased sharply post-2015.

2. **Model Performance**:
   - **Random Forest**:
     - Outperformed Linear Regression with RMSE = 18.57 and \(R^2 = 0.45\).
   - **Feature Importance**:
     - `All.ages` and `Age_Group` were the most important predictors, followed by `Region`.

3. **Regional Analysis**:
   - England contributes the largest share of deaths.
   - Scotland shows higher per-capita mortality rates.

---

## **Run the Code**

### **Option 1: Google Colab**
Run the project code directly in your browser using Google Colab. This option requires no setup.

1. Open the Colab notebook:  
   [![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/your-colab-notebook-link)

2. Follow the instructions in the notebook to run each section of the code:
   - Data Cleaning
   - Data Analysis
   - Visualization
   - Predictive Modeling

3. Output visualizations and results will be displayed directly in the notebook.

---

### **Option 2: Clone Repository**
You can also clone the repository and run the code locally:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/Alcohol-Mortality-Analysis.git
