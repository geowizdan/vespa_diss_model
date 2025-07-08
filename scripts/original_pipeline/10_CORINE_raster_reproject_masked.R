library(terra)

bioclim <- rast("data/environmental/cleaned/bioclim_masked_western_europe.tif")

cornie_raster <-rast("data/environmental/CLC_raw_baseline/U2018_CLC2018_V2020_20u1.tif")

#reproject cornie_raster CRS to match bioclim

if (crs(cornie_raster) != crs(bioclim)) {
  cornie_raster <- project(cornie_raster, crs(bioclim))
}

# Step 4: Crop and resample to match bioclim extent and resolution
corine_aligned <- crop(cornie_raster, bioclim_masked)
corine_aligned <- resample(corine_aligned, bioclim_masked, method = "near")

training_vect <- readRDS("data/environmental/training_vect_western_europe.rds")

corine_masked <- mask(corine_aligned, training_vect)

# Step 5: Save the aligned CORINE raster
writeRaster(
  corine_masked,
  filename = "data/environmental/cleaned/corine_masked_western_europe.tif",
  filetype = "GTiff",
  overwrite = TRUE
)