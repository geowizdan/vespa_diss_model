# Load terra and raster stack
library(terra)
r <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# Set output directory
out_dir <- "C:/Users/Dan Buchanan/Documents/maxent_gui_layers/"

# Ensure output directory exists
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Write each layer individually to .asc format
writeRaster(r[[1]], filename = paste0(out_dir, "bio_3.asc"), filetype = "AAIGrid", overwrite = TRUE)
writeRaster(r[[2]], filename = paste0(out_dir, "bio_4.asc"), filetype = "AAIGrid", overwrite = TRUE)
writeRaster(r[[3]], filename = paste0(out_dir, "bio_6.asc"), filetype = "AAIGrid", overwrite = TRUE)
writeRaster(r[[4]], filename = paste0(out_dir, "bio_13.asc"), filetype = "AAIGrid", overwrite = TRUE)
writeRaster(r[[5]], filename = paste0(out_dir, "bio_15.asc"), filetype = "AAIGrid", overwrite = TRUE)
writeRaster(r[[6]], filename = paste0(out_dir, "dist_urban.asc"), filetype = "AAIGrid", overwrite = TRUE)
writeRaster(r[[7]], filename = paste0(out_dir, "dist_forest.asc"), filetype = "AAIGrid", overwrite = TRUE)
writeRaster(r[[8]], filename = paste0(out_dir, "dist_agriculture.asc"), filetype = "AAIGrid", overwrite = TRUE)

