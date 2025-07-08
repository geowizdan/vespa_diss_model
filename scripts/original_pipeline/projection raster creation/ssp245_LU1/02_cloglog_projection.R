# ================================
# Step 0: Load libraries
# ================================
library(terra)
library(maxnet)

# ================================
# Step 1: Load the projection raster stack
# ================================
raster_path <- "data/derived/projection_rasters/rcp245_lu1/predictor_stack_rcp245_lu1.tif"
predictor_stack <- rast(raster_path)

# Inspect layer names and count
cat("Layer names:\n")
print(names(predictor_stack))
cat("\nNumber of layers:", nlyr(predictor_stack), "\n")

# ================================
# Step 2: Load trained MaxEnt model
# ================================
model <- readRDS("data/derived/enmeval/best_maxent_model_LQH_rm2.rds")


# ================================
# Step 4: Predict habitat suitability (cloglog)
# ================================
suitability <- predict(predictor_stack, model, type = "cloglog", na.rm = TRUE)

# ================================
# Step 5: Save the predicted raster
# ================================
output_path <- "data/derived/maxent_projection_outputs/prediction_rcp245_lu1.tif"
writeRaster(suitability, filename = output_path, overwrite = TRUE)

cat("\n✅ Projection complete. Saved to:", output_path, "\n")
