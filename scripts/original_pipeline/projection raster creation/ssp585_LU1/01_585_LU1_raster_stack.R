library(terra)

# ======================================
# Step 1: Load clipped future bioclim stack
# ======================================
bioclim_rcp585 <- rast("data/derived/future_climate_raster/ssp585_clipped_bioclim/ssp585_bioclim_2041_2060.tif")
nlyr(bioclim_rcp585)  # Check number of layers)
# ======================================
# Step 2: Load LU1 distance rasters
# ======================================
dist_urban <- rast("data/derived/future_land_cover_2050_distance/LU1_BAU/dist_forest_updated.tif")
dist_agriculture <- rast("data/derived/future_land_cover_2050_distance/LU1_BAU/dist_agriculture_updated.tif")
dist_forest <- rast("data/derived/future_land_cover_2050_distance/LU1_BAU/dist_forest_updated.tif")

nlyr(dist_urban)  # Check number of layers
summary(dist_urban)
# ======================================
# Step 3: Harmonise projection, resolution and extent
# ======================================
# Use the first bioclim layer as the spatial template
template <- bioclim_rcp585[[1]]

# Resample and mask to that
dist_urban <- mask(resample(dist_urban, template), template)
dist_agriculture <- mask(resample(dist_agriculture, template), template)
dist_forest <- mask(resample(dist_forest, template), template)

# ======================================
# Step 4: Stack rasters (5 bioclim + 3 land use)
# ======================================
stack_rcp585_lu1 <- c(
  bioclim_rcp585,
  dist_urban,
  dist_forest,
  dist_agriculture
)

nlyr(stack_rcp585_lu1)  # Check number of layers
names(stack_rcp585_lu1)
# Rename layers to consistent names
names(stack_rcp585_lu1) <- c(
  "bio_3", "bio_4", "bio_6", "bio_13", "bio_15",
  "dist_urban", "dist_forest", "dist_agriculture"
)

# ======================================
# Step 5: Save final stack
# ======================================
writeRaster(
  stack_rcp585_lu1,
  filename = "data/derived/projection_rasters/rcp585_lu1/predictor_stack_rcp585_lu1.tif",
  overwrite = TRUE
)

cat("Raster stack for RCP 8.5 +LU1 saved.\n")
