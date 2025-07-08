library(terra)

# Step 1: Load the full predictor stack
full_stack <- rast("data/derived/rasters_stacked/predictor_stack.tif")

# Step 2: List current names (to double-check layer names)
names(full_stack)

# Step 3: Define your retained variable names (match exactly as in names(full_stack))
retained_vars <- c(
  "wc2.1_30s_bio_3",
  "wc2.1_30s_bio_4",
  "wc2.1_30s_bio_6",
  "wc2.1_30s_bio_13",
  "wc2.1_30s_bio_15",
  "dist_urban",
  "dist_forest",
  "dist_agriculture"
)

# Step 4: Subset the full stack to retain only those layers
final_stack <- full_stack[[retained_vars]]

# Step 5: Save final raster stack
writeRaster(
  final_stack,
  filename = "data/derived/rasters_stacked/predictor_stack_final.tif",
  filetype = "GTiff",
  overwrite = TRUE
)

# Step 6: Confirm output
print(final_stack)