# Data-Driven Insights into Alcohol-Related Mortality

Welcome to my project page! This project explores the critical issue of alcohol-related mortality using data analysis and machine learning techniques. The focus is on identifying trends, key predictors, and insights to inform public health policies and interventions.

---

## 🌟 **Highlights of the Project**

- **Comprehensive Analysis**: Examined alcohol-specific mortality trends across age groups and regions.
- **Key Findings**:
  - Alcoholic liver disease is the leading cause of deaths related to alcohol.
  - Middle-aged individuals (ages 45–64) are at the highest risk.
  - Mortality rates have risen sharply post-2015.
  - England contributes the most deaths overall, while Scotland has a higher per-capita burden.
- **Predictive Modeling**: Built a Random Forest model to predict future mortality trends with 45% accuracy (\(R^2\)).

---

## 🎯 **Research Questions**
1. **What are the historical trends in alcohol-specific deaths by age group and geographic region?**
2. **What are the key predictors of high mortality rates, and how well can we predict future trends using historical data?**

---

## 📊 **Key Findings**

### 1. Trends in Alcohol-Specific Mortality
- **Age Groups**: Mortality is highest among individuals aged 45–64, with deaths steadily increasing post-2015.
- **Regions**:
  - England: The highest total deaths.
  - Scotland: Higher per-capita mortality rates.
  - Wales and Northern Ireland: Lower contributions but notable trends in certain age groups.
- **Causes**:
  - Alcoholic liver disease accounts for over 70% of deaths.
  - Mental and behavioral disorders due to alcohol rank second.

### 2. Predictors of Mortality
- **Top Predictors**:
  - Total deaths across all ages (`All.ages`) and age group-specific mortality (`Age_Group`) are the most critical predictors.
  - Geographic region (`Region`) also significantly influences mortality trends.
  - Gender variables (`Sex`) have a relatively smaller impact.

- **Model Performance**:
  - Random Forest Model: RMSE = 18.57, \(R^2 = 0.45\).
  - Linear Regression Model: RMSE = 19.56, \(R^2 = 0.39\).
  - **Visualizations**: Trend plots and residual analyses reveal the model's strengths and areas for improvement.

---

## 🔍 **How to Explore the Project**

This project is fully open-source and hosted on GitHub. You can explore:
1. **Key Findings and Visualizations**: Access the summary and graphs showing trends, predictors, and causes.
2. **R Code**: Download the R scripts used for data cleaning, analysis, and visualization.
3. **Step-by-Step Instructions**: Replicate the analysis or build upon it using the provided instructions.

---
