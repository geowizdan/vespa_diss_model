library(terra)

# Load the training mask
training_vect <- readRDS("data/environmental/training_vect_western_europe.rds")

# List of raster names (without .tif)
classes <- c("urban", "agriculture", "forest", "opennatural", "water")

# Function to clip and save
clip_raster <- function(class_name) {
  input_path <- paste0("data/derived/distance_rasters/dist_", class_name, ".tif")
  output_path <- paste0("data/derived/distance_rasters/dist_", class_name, "_clipped.tif")
  
  r <- rast(input_path)
  r_clipped <- mask(crop(r, training_vect), training_vect)
  
  writeRaster(r_clipped, output_path, overwrite = TRUE)
  cat("Saved:", output_path, "\n")
}

# Apply to all classes
lapply(classes, clip_raster)
