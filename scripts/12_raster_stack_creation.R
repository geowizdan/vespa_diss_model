library(terra)

# Step 1: Load clipped distance rasters
dist_layers <- c(
  "data/derived/distance_rasters/dist_urban_clipped.tif",
  "data/derived/distance_rasters/dist_agriculture_clipped.tif",
  "data/derived/distance_rasters/dist_forest_clipped.tif",
  "data/derived/distance_rasters/dist_opennatural_clipped.tif",
  "data/derived/distance_rasters/dist_water_clipped.tif"
)

dist_stack <- rast(dist_layers)

# Step 2: Load bioclim stack (already masked to training region)
bioclim_stack <- rast("data/environmental/cleaned/bioclim_masked_western_europe.tif")

# Step 3: Harmonise all layers (ensure alignment)
dist_stack <- resample(dist_stack, bioclim_stack, method = "bilinear")

# Step 4: Combine stacks
full_stack <- c(bioclim_stack, dist_stack)

# Step 5: Save full stack to new directory
writeRaster(full_stack, 
            filename = "data/derived/rasters_stacked/predictor_stack.tif",
            overwrite = TRUE)

# Check result
print(full_stack)
