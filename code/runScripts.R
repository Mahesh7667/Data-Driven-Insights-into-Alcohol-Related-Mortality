# Master script to run all R scripts in the correct order

# Step 1: Setup, Load Data, and Clean Data
source("data_setup_and_cleaning.R")

# Step 2: Analysis
source("analysis.R")

# Step 3: Visualization
source("visualization.R")

# Step 4: Modeling
source("modeling.R")

# (Optional) Add a completion message
cat("All scripts executed successfully!\n")
