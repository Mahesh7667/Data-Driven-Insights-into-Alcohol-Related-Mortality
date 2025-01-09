# Alcohol-Specific Deaths in the UK: A Data Visualization Project

## Overview
This repository contains a comprehensive analysis of alcohol-specific deaths in the UK, focusing on their variation across age, sex, region, and time. The project uses data from public health sources, such as Public Health England and the Office for National Statistics (ONS), to generate insightful visualizations. These visualizations aim to inform public health policies and interventions, highlighting critical trends and disparities.

## Key Features
- **Heatmap**: Visualizes temporal trends in alcohol-specific deaths across age groups from 2001 to 2021.
- **Geospatial Map**: Displays regional disparities in alcohol-specific deaths for a baseline year (2001).
- **Scatter Plot**: Illustrates age-sex distributions of deaths, highlighting demographic disparities.
- **Bubble Plot**: Combines regional and sex-based differences in mortality rates.

## Contents
### **1. Data**
- **`data/`**: Contains cleaned and preprocessed datasets used for the visualizations.
  - `deathsbyindividualcause.xlsx`: Primary dataset.
  - `alcoholspecificdeaths2021.xlsx`: Supplementary dataset.
  - `uk_regions.geojson`: Geospatial data for mapping.

### **2. Code**
- **`scripts/`**: R scripts for data cleaning, analysis, and visualization.
  - `data_preprocessing.R`: Code for cleaning and reshaping the datasets.
  - `visualization.R`: Code for generating the visualizations.
  - `composite_visualization.R`: Combines all visualizations into a single dashboard.

### **3. Visualizations**
- **`outputs/`**: Contains generated plots and composite visualizations.
  - `heatmap.png`
  - `scatter_plot.png`
  - `bubble_plot.png`
  - `geospatial_map.png`
  - `composite_visualization.png`

### **4. Documentation**
- **`docs/`**: Project documentation and report sections.
  - `knowledge_building.md`: Explains the significance of the topic and insights gained.
  - `theoretical_frameworks.md`: Discusses the ASSERT framework and grammar of graphics.
  - `accessibility.md`: Evaluates the accessibility of the visualizations.
  - `visualization_choice.md`: Justifies visualization choices and discusses alternatives.
  - `implications_and_improvements.md`: Reflects on insights and proposes enhancements.
