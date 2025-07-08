# ============================
# Step 0: Load libraries
# ============================
library(terra)
terra::gdal()
terra::gdal(drivers = TRUE)
# ============================
# Step 1: Load the predictor raster stack
# ============================
r <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# Check layer names
layer_names <- names(r)
print(layer_names)

# ============================
# Step 2: Define safe local output directory
# ============================
# Replace with your own local path if needed
out_dir <- "C:/Users/Dan Buchanan/Documents/maxent_gui_layers/"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# ============================
# Step 3: Loop through and write each layer as ASCII
# ============================
for (i in seq_along(layer_names)) {
  layer <- r[[i]]
  layer_name <- layer_names[i]
  
  out_path <- file.path(out_dir, paste0(layer_name, ".asc"))
  
  writeRaster(
    layer,
    filename = out_path,
    filetype = "ascii",  # For terra ≥ 1.7.29
    overwrite = TRUE
  )
  
  cat("Saved:", out_path, "\n")
}