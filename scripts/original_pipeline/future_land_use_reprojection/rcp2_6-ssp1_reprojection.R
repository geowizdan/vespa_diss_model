library(terra)

# Step 1: Load raster in BNG
r_bng <- rast("data/raw/RCP_land_use_uk/f9ab3051-4f85-415f-b691-371ff8e951f2/f9ab3051-4f85-415f-b691-371ff8e951f2/data/rcp2_6-ssp1.tif")  # path to your raster

# Step 2: Confirm current CRS
print(crs(r_bng))  # Should show EPSG:27700

# Step 3: Reproject to WGS84
r_wgs84 <- project(r_bng, "EPSG:4326", method = "near")

# Step 4: Save to disk
writeRaster(r_wgs84, "data/derived/future_landcover_wgs84/LU2_mitigation/LU2_crafty_reprojected_wgs84.tif", overwrite = TRUE)
# Step 5: Confirm the new CRS
print(crs(r_wgs84))  # Should show EPSG:4326
