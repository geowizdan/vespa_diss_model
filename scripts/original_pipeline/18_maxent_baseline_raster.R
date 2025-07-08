# ================================
# Step 0: Load packages
# ================================
library(terra)
library(maxnet)
library(tidyverse)

# ================================
# Step 1: Load cleaned MaxEnt input data
# ================================
pb_data <- read_csv("data/derived/maxent_input_table.csv") %>%
  drop_na()

predictors <- pb_data %>% select(-presence)
labels <- pb_data$presence

# ================================
# Step 2: Fit the MaxEnt model
# ================================
maxent_model <- maxnet(p = labels, data = predictors)

# ================================
# Step 3: Load predictor raster stack
# ================================
predictor_stack <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# ================================
# Step 4: Predict habitat suitability
# ================================
# Predict using cloglog transformation (suitable for presence-background data)
suitability_raster <- predict(
  object = predictor_stack,
  model = maxent_model,
  type = "cloglog",
  na.rm = TRUE
)

# ================================
# Step 5: Save for QGIS visualisation
# ================================
writeRaster(
  suitability_raster,
  filename = "data/derived/maxent_output/baseline_suitability_western_europe.tif",
  filetype = "GTiff",
  overwrite = TRUE
)

cat("Suitability raster saved to: data/derived/maxent_output/baseline_suitability_western_europe.tif\n")
