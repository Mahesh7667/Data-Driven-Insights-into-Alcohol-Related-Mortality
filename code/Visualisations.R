theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5))

library(sf)
library(ggplot2)


ggplot(top_regions, aes(x = fct_reorder(Area_Name, mean_rate), y = mean_rate)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 10 Regions by Age-Standardized Mortality Rate",
       x = "Region",
       y = "Mean Age-Standardized Rate")


ggplot(top_causes, aes(x = reorder(cause, -Total_Deaths), y = Total_Deaths, fill = cause)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 Causes of Death", x = "Cause of Death", y = "Total Deaths") +
  theme_minimal() +
  theme(legend.position = "none")


ggplot(total_deaths_summary, aes(x = Age_Group, y = Total_Deaths, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Alcohol-Specific Deaths by Age Group and Region",
       x = "Age Group", y = "Total Deaths") +
  theme_minimal() +
theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Improved plot
ggplot(gender_analysis_filtered, aes(x = Year, y = mean_rate, color = Sex)) +
  geom_line(size = 1) +
  geom_smooth(se =  , linetype = "dashed", size = 0.8) +
  labs(title = "Trends in Mortality Rate by Gender",
       x = "Year",
       y = "Mean Age-Standardized Rate",
       color = "Gender") +
  scale_color_manual(values = c("Females" = "purple", "Males" = "blue", "Persons" = "green")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "top"
  )
  
  # Plot: Proportion of alcohol-specific deaths by sex
ggplot(sex_proportions, aes(x = Sex, y = Proportion, fill = Sex)) +
  geom_bar(stat = "identity") +
  labs(title = "Proportion of Alcohol-Specific Deaths by Sex",
       x = "Sex",
       y = "Proportion of Total Deaths") +
  theme_minimal()


# Visualize the total deaths by cause and region
ggplot(cause_analysis, aes(x = cause, y = Total_Deaths, fill = Region)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Alcohol-Specific Deaths by Cause and Region",
       x = "Cause of Death",
       y = "Total Deaths",
       fill = "Region") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Plot the top 10 causes
ggplot(top_causes, aes(x = reorder(cause, -Total_Deaths), y = Total_Deaths, fill = cause)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Top 10 Causes of Alcohol-Specific Deaths",
       x = "Cause of Death",
       y = "Total Deaths") +
  theme_minimal() +
  theme(legend.position = "none")


# Plot the major cause in each region
ggplot(major_cause_by_region, aes(x = reorder(Region, -Total_Deaths), y = Total_Deaths, fill = cause)) +
  geom_bar(stat = "identity") +
  labs(title = "Major Cause of Alcohol-Specific Deaths by Region",
       x = "Region",
       y = "Total Deaths",
       fill = "Cause of Death") +
  theme_minimal()


# Bar plot for total deaths by region and age group
ggplot(grouped_summary, aes(x = Age_Group, y = Total_Deaths, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Total Deaths by Region and Age Group",
    x = "Age Group",
    y = "Total Deaths",
    fill = "Region"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



# Heatmap for correlation matrix
ggplot(correlation_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(
    low = "blue", high = "red", mid = "white",
    midpoint = 0, limit = c(-1, 1),
    name = "Correlation"
  ) +
  labs(
    title = "Heatmap of Variable Correlations",
    x = "Variable",
    y = "Variable"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

setwd('..')
# Read the GeoJSON file
geo_data <- geojsonio::geojson_read("data/uk_regions.geojson", what = "sp")
setwd('code/')
# Convert to an sf object
geo_data_sf <- st_as_sf(geo_data)

# Assign a CRS if missing
st_crs(geo_data_sf) <- 4326

# Join the aggregated data with the GeoJSON spatial data
data_sf <- geo_data_sf %>%
  left_join(aggregated_data, by = c("rgn19cd" = "Area_Code"))


head(data_sf)
# Assuming df contains region and death data with geospatial geometry (e.g., a shapefile)
geospatial <- ggplot(data_sf) +
  geom_sf(aes(fill = Total_Deaths), color = "Black", size = 0.1) + 
  scale_fill_gradient(low = "#E0F7FA", high = "#B71C1C", name = "Total Deaths") +
  labs(
    title = "2. Geospatial Distribution of Alcohol-Specific Deaths \n         in the 2001 UK"  ) +
  theme_minimal() + 
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.caption = element_text(size = 10, face = "italic"),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10),
    axis.text = element_blank(),  # Remove axis labels
    axis.ticks = element_blank(),  # Remove axis ticks
    panel.grid = element_blank()  # Remove grid lines for a cleaner look
  )
  # Set a fixed aspect ratio to prevent stretching

library(plotly)

# Assuming your scatter plot is stored in `scatterPlot`
interactive_geospatial <- ggplotly(geospatial)

# Save as an HTML file
# htmlwidgets::saveWidget(interactive_geospatial, "output/geospatial.html")

heatmap_data <- data_long_filtered %>%
  filter(!Sex %in% c("<1")) %>%
  group_by(Year, Age_Group) %>%
   dplyr::summarise(Total_Deaths = sum(Deaths, na.rm = TRUE)) %>%
  ungroup()

library(grid)


heatmap <- ggplot(heatmap_data, aes(x = Year, y = Age_Group, fill = Total_Deaths)) +
  geom_tile(width = 1.1) +  # Slightly increase tile width to remove gaps
  scale_fill_gradient(low = "#E0F7FA", high = "#B71C1C", name = "Total Deaths") +
  scale_x_continuous(breaks = seq(min(heatmap_data$Year), max(heatmap_data$Year), by = 5)) +  # Label every 5th year
  scale_y_discrete(labels = c("0-0.9","1-4", "5-9", "10-14", "15-19", "20-24", "25-29", 
                              "30-34", "35-39", "40-44", "45-49", "50-54", 
                              "55-59", "60-64", "65-69", "70-74", "75-79", 
                              "80-84", "85-89", "90+")) +  # Simplify age group labels
  labs(
    title = "1. Trends in Alcohol-Related Deaths by Year and Age Group",
    x = "Year", y = "Age Group (Years)"
  ) +
  theme_minimal() + 
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text.x = element_text(size = 10, angle = 45, hjust = 1),  # Rotate x-axis labels
    axis.text.y = element_text(size = 10),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10),
    plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm")  # Add margins for better spacing
  ) # Set a fixed aspect ratio to prevent stretching


library(plotly)

# Assuming your scatter plot is stored in `scatterPlot`
interactive_heatmap <- ggplotly(heatmap)

# Save as an HTML file
# htmlwidgets::saveWidget(interactive_heatmap, "output/heatmap.html")

library(patchwork)

scatterPlot <- ggplot(data_long_filtered, aes(x = Age_Group, y = Deaths, color = Sex)) +
  geom_jitter(width = 0.2, height = 0, alpha = 0.6) +
  scale_color_manual(values = c("Females" = "#FF9999", "Males" = "#99CC99")) +
  labs(
    title = "3. Distribution of Alcohol-Related Deaths by Age Group and Sex",
    x = "Age Group (Years)", y = "Number of Deaths",
    color = "Sex"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12, face = "bold"),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10),
    axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
    legend.position = "bottom",                # Move legend below the plot
    legend.box = "horizontal"  
  )


library(plotly)

# Assuming your scatter plot is stored in `scatterPlot`
interactive_scatterPlot <- ggplotly(scatterPlot)

# Save as an HTML file
# htmlwidgets::saveWidget(interactive_scatterPlot, "output/scatterPlot.html")


bubblePlot <- ggplot(data_long_filtered, aes(x = Region, y = Deaths, size = Deaths, color = Sex)) +
  geom_point(alpha = 0.7) +
  scale_color_manual(values = c("Females" = "#FF9999", "Males" = "#99CC99")) +
  scale_size(range = c(1, 10), name = "Death Rate") +
  labs(
    title = "4. Regional Comparison of \n   Alcohol-Related Deaths by Sex",
    x = "Region", y = "Total Deaths",
    color = "Sex"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 6),
    axis.text.y = element_text(size = 10, angle = 0, vjust = 0.5)
            
  ) + 
  
  guides(
    color = guide_legend(position = "bottom", title.hjust = 0.5),  # Position color legend title
    size = guide_legend(position =  "right", title.hjust = 0.8) # Keep size legend on the right
  )

library(plotly)

# Assuming your scatter plot is stored in `scatterPlot`
interactive_bubblePlot <- ggplotly(bubblePlot)

# Save as an HTML file
# htmlwidgets::saveWidget(interactive_bubblePlot, "output/bubblePlot.html")

wrap_plots(heatmap  , geospatial,scatterPlot , bubblePlot) + plot_annotation(
  title = "Analysis of Alcohol-Specific Deaths in the UK",
) &
  theme(
    plot.title = element_text(hjust = 0.5, color = "Black", size = 12, face = "bold"),
  ) 

