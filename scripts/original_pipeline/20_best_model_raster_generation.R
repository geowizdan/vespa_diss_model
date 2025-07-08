library(terra)
library(ENMeval)
library(maxnet)

# Step 1: Load the model object
best_model <- readRDS("data/derived/enmeval/best_maxent_model_enmeval.rds")  # Adjust path

# Step 2: Load the same raster stack used during model training
env_stack <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# Step 3: Predict habitat suitability using cloglog output scale
cloglog_pred <- predict(
  env_stack,
  best_model,
  type = "cloglog",   # Cloglog gives interpretable suitability scores
  na.rm = TRUE
)

# Step 4: Save prediction raster for QGIS or further analysis
writeRaster(
  cloglog_pred,
  filename = "data/derived/maxent_output/trained_model_3.tif",
  filetype = "GTiff",
  overwrite = TRUE
)