# Data-Driven Insights into Alcohol-realted Mortality 

## Overview
This project analyzes alcohol-specific deaths and causes of death data to uncover trends, generate insights, and build predictive models. The project workflow includes data preprocessing, exploratory data analysis (EDA), visualization, and modeling.

---
## GitHub Pages

The project results, visualizations, and documentation are also available on **GitHub Pages**. 

### **Visit the GitHub Pages Site**
You can view the live project results and additional resources here:  

🔗 [Trends and Future Prediction](https://mahesh7667.github.io/Data-Driven-Insights-into-Alcohol-Related-Mortality/Trends-and-Future-Prediction)
🔗 [Exploring through Visualizations](https://mahesh7667.github.io/Data-Driven-Insights-into-Alcohol-Related-Mortality/Exploring-through-Visualizations)



### **What You’ll Find**
- **Interactive Visualizations**: Explore the graphs and insights generated from the data analysis.
- **Documentation**: Read the full project overview and methodology.
- **Downloadable Outputs**: Access processed data or model results.

---



## Folder Structure

## 📂 Project File Structure

The repository is organized into the following folders and files:

```plaintext
Alcohol-Mortality-Analysis/
├── code/                     # All R scripts for the project
│   ├── 1_data_cleaning.R      # Script for cleaning and preprocessing the data
│   ├── 2_data_analysis.R      # Statistical and predictive modeling analysis
│   ├── 3_visualization.R      # Script for generating visualizations
├── data/                     # Data used for the project
│   ├── raw/                   # Raw datasets (original Excel files)
│   ├── processed/             # Cleaned and transformed datasets
├── docs/                     # Documentation and outputs
│   ├── figures/               # Visualizations and plots (e.g., .png files)
│   ├── interactive/           # Interactive plots or HTML files (if applicable)
├── notebooks/                # Jupyter or Google Colab notebooks
│   ├── Alcohol_Mortality_Notebook.ipynb  # Main notebook for running the project
├── README.md                 # Project overview and details
├── LICENSE                   # License for the project
├── requirements.txt          # Required packages for Python (if applicable)


## How to Run the Project

### **Option 1: Using R Scripts** 🖥️

1. **Setup Environment**:
   - Ensure you have R installed on your machine.
   - Install the required R packages by running:
     ```R
     if (!require("openxlsx")) install.packages("openxlsx")
     if (!require("plyr")) install.packages("plyr")
     if (!require("reshape2")) install.packages("reshape2")
     if (!require("randomForest")) install.packages("randomForest")
     if (!require("ggplot2")) install.packages("ggplot2")
     if (!require("dplyr")) install.packages("dplyr")
     if (!require("tidyr")) install.packages("tidyr")
     ```

2. **Run the Project**:
   - Execute the master script:
     ```R
     source("code/runScripts.R")
     ```

3. **Outputs**:
   - Generated plots and processed datasets will be displayed in the console


   ### **Option 2: Using Jupyter Notebooks** 🐍📒
1. **Setup the Environment**:
   - Ensure you have Python and Jupyter Notebook installed. You can install Jupyter via pip:
     ```bash
     pip install notebook
     ```
   - Install required Python libraries:
     ```bash
     pip install pandas numpy matplotlib seaborn openpyxl scikit-learn
     ```

2. **Run the Notebooks**:
   - Navigate to the `notebooks/` folder and open `run_all.ipynb`:
     ```bash
     jupyter notebook notebooks/run_all.ipynb
     ```
   - Execute each cell in the notebook to run the entire workflow.

3. **View Results**:
   - Outputs such as visualizations and processed data will be in the output console.

---

## Dependencies
The following R packages are required for this project:
- `openxlsx`
- `plyr`
- `reshape2`
- `randomForest`
- `ggplot2`
- `dplyr`
- `tidyr`

Install any missing packages using:
```R
install.packages("<package_name>")
```

---


## License

This project is licensed under the **MIT License**.
