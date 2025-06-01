# Load packages
library(tidyverse)
library(sf)
library(raster)

# Step 1: Load cleaned occurrence data
occ <- read_csv("data/cleaned/vespa_velutina_cleaned.csv")

# Step 2: Convert to sf object (EPSG:4326 = WGS84)
occ_sf <- st_as_sf(occ, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

# Step 3: Create ~1 km grid (0.0083° at equator)
#r <- raster(extent(occ_sf), res = 0.0083, crs = st_crs(occ_sf)$proj4string)

#Step 3.5: for a 10km grid, use 0.083° (approx. 10 km at equator)
r <- raster(extent(occ_sf), res = 0.083, crs = st_crs(occ_sf)$proj4string)

# Step 4: Assign each point to a raster cell
occ_sf$cell_id <- cellFromXY(r, st_coordinates(occ_sf))

# Step 5: Keep only one point per cell
occ_thinned_sf <- occ_sf %>%
  group_by(cell_id) %>%
  slice(1) %>%
  ungroup()

# Step 6: Extract coordinates safely
coords <- st_coordinates(occ_thinned_sf)

occ_thinned_sf <- bind_cols(
  occ_thinned_sf,
  tibble(decimalLongitude = coords[, 1],
         decimalLatitude  = coords[, 2])
)

# Step 7: Convert to data.frame and drop unwanted columns directly
occ_thinned <- as.data.frame(occ_thinned_sf)

# Drop geometry and cell ID columns safely using base R
occ_thinned$geometry <- NULL
occ_thinned$cell_id <- NULL

#change to 1km or 10km as need

write_csv(occ_thinned, "data/cleaned/vespa_velutina_thinned_10km.csv")

# Final report
cat("Thinned records retained:", nrow(occ_thinned), "\n")


