# Master script to run all R scripts in the correct order

# Step 1: Setup, Load Data, and Clean Data
source("dataPreprocess.R")

# Step 2: Analysis
source("dataAnalysis.R")

# Step 3: Visualization
source("Visualisations.R")

# Step 4: Modeling
source("modeling.R")

# (Optional) Add a completion message
cat("All scripts executed successfully!\n")
