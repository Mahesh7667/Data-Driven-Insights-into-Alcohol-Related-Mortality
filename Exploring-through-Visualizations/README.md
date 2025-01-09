
## Getting Started

### Prerequisites
- Install **R** (version 4.0 or above) and RStudio.
- Install the required R libraries:
  ```R
  install.packages(c("tidyverse", "ggplot2", "dplyr", "sf", "readxl", "patchwork", "geojsonio"))
  ```

### Running the Scripts
1. Clone the repository:
   ```bash
   git clone https://github.com/username/alcohol-deaths-uk.git
   cd alcohol-deaths-uk
   ```
2. Open `visualization.R` in RStudio.
3. Run the script to generate individual visualizations.
4. To create the composite visualization, run `composite_visualization.R`.

### Viewing Outputs
Generated plots will be saved in the `outputs/` directory.

## Results
The visualizations provide actionable insights into alcohol-specific deaths:
1. Middle-aged males (40–69 years) are disproportionately affected.
2. Scotland consistently exhibits the highest death rates, followed by northern England.
3. Deaths have increased significantly over time, especially from 2015 to 2021.
4. Wales and Northern Ireland show comparatively lower death counts.

## Contributions
Contributions are welcome! Feel free to submit issues or pull requests to enhance the project.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

## References
- Public Health England. (2021). Alcohol-specific deaths in the UK.
- Beeston, C., et al. (2013). Monitoring and Evaluating Scotland’s Alcohol Strategy.
- Wilkinson, L. (2005). *The Grammar of Graphics*.
- WHO. (2018). *Global status report on alcohol and health*.

---

### Contact
For questions or collaborations, contact [your-email@example.com].

