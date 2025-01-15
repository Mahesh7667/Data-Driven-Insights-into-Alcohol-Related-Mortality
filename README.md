# The Fatal Sip: Alcohol-Related Mortality Uncovered

## Overview
This project analyzes alcohol-specific deaths and causes of death data to uncover trends, generate insights, and build predictive models. The project workflow includes data preprocessing, exploratory data analysis (EDA), visualization, and modeling.

---
### **Visit the GitHub Pages Site**
You can view the live project results and additional resources here:  

🔗 [Trends and Future Prediction](https://mahesh7667.github.io/Data-Driven-Insights-into-Alcohol-Related-Mortality/Trends-and-Future-Prediction)
🔗 [Exploring through Visualizations](https://mahesh7667.github.io/Data-Driven-Insights-into-Alcohol-Related-Mortality/Exploring-through-Visualizations)



### **What You’ll Find**
- **Interactive Visualizations**: Explore the graphs and insights generated from the data analysis.
- **Documentation**: Read the full project overview and methodology.
- **Downloadable Outputs**: Access processed data or model results.

---
## 📂 Project File Structure

The repository is organized into the following folders and files:

```plaintext
Alcohol-Mortality-Analysis/
├── code/                     # All R scripts for the project
│   ├── dataPreprocess.R    # Script for cleaning and preprocessing the data
│   ├── dataAnalysis.R      # Statistical and predictive modeling analysis
│   ├── Visualisations.R    # Script for generating visualizations
│   ├── modeling.R          # Script for building predictive model
│   ├── runScripts.R          # Script for running all the above scripts
├── data/                     # Data used for the project
├── notebooks/                # Jupyter or Google Colab notebooks
│   ├── Alcohol_Mortality_Notebook.ipynb  # Main notebook for running the project
├── README.md                 # Project overview and details
├── LICENSE                   # License for the project
```

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

2. **Run the Notebooks**:
   - Navigate to the `notebooks/` folder and open `Alcohol_Mortality_Notebook.ipynb`:
     ```bash
     jupyter notebook notebooks/Alcohol_Mortality_Notebook.ipynb
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
