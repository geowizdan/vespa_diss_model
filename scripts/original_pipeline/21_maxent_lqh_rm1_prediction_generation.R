# ============================
# Step 0: Load libraries
# ============================

library(terra)
library(maxnet)
library(tidyverse)

# ============================
# Step 1: Load presence–background table
# ============================
pb_data <- read_csv("data/derived/maxent_input_table.csv")

# Confirm structure
glimpse(pb_data)

# Step 1.1: Drop rows with any NA values
pb_data_clean <- pb_data %>%
  drop_na()

# Separate predictors and labels
predictors <- pb_data_clean %>% select(-presence)
labels <- pb_data_clean$presence

# Ensure all predictors are numeric
predictors <- as.data.frame(lapply(predictors, as.numeric))

# ============================
# Step 2: Fit MaxEnt model (Model 2 from ENMeval — LQH, RM = 1.0)
# ============================

maxent_model_lqh <- maxnet(
  p = labels,
  data = predictors,
  f = maxnet.formula(p = labels, data = predictors, classes = "lqh"),
  regmult = 1.0
)

# ============================
# Step 3: Inspect model summary
# ============================

print(maxent_model_lqh)

# ============================
# Step 4: Save model for future use
# ============================

saveRDS(maxent_model_lqh, file = "data/derived/maxent_model_lqh_rm1.rds")
cat("MaxEnt model (LQH, RM = 1.0) saved: data/derived/maxent_model_lqh_rm1.rds\n")

# ============================
# Step 5: Predict to raster and save for QGIS
# ============================

# Load the raster stack used during training
env_stack <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# Predict using cloglog transformation
prediction_raster <- predict(env_stack, maxent_model_lqh, type = "cloglog", na.rm = TRUE)

# Save output raster
writeRaster(
  prediction_raster,
  filename = "data/derived/maxent_model_lqh_rm1_prediction.tif",
  overwrite = TRUE
)

cat("Prediction raster saved: data/derived/maxent_model_lqh_rm1_prediction.tif\n")
