library(terra)

# Load full raster stack
r <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# New local output path (not in OneDrive)
out_dir <- "C:/Users/Dan Buchanan/Documents/maxent_layers_ascii_float/"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

# Function to write floating-point .asc files
write_float_asc <- function(r_layer, name) {
  # Replace NaN/NA with -9999 explicitly
  values(r_layer)[is.na(values(r_layer))] <- -9999
  NAflag(r_layer) <- -9999
  
  # Write raster preserving floating-point values
  writeRaster(
    r_layer,
    filename = file.path(out_dir, paste0(name, ".asc")),
    filetype = "AAIGrid",      # ASCII Grid format
    datatype = "FLT4S",        # 32-bit float
    NAflag = -9999,
    overwrite = TRUE
  )
}

# Run for each layer
write_float_asc(r[[1]], "bio_3")
write_float_asc(r[[2]], "bio_4")
write_float_asc(r[[3]], "bio_6")
write_float_asc(r[[4]], "bio_13")
write_float_asc(r[[5]], "bio_15")
write_float_asc(r[[6]], "dist_urban")
write_float_asc(r[[7]], "dist_forest")
write_float_asc(r[[8]], "dist_agriculture")
