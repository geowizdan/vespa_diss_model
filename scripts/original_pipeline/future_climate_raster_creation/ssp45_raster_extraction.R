# ===============================
# Step 0: Load required libraries
# ===============================
library(terra)
library(sf)
library(rnaturalearth)
library(dplyr)

# ============================================
# Step 1: Load and stack desired bioclim layers
# ============================================

# Define path to downloaded WorldClim future projections
bio_future_dir <- "data/environmental/worldclim_future/ssp245_2041-2060"  # Replace as needed

# Load the raster stack of all 19 variables
bio_stack <- rast(list.files(bio_future_dir, pattern = "\\.tif$", full.names = TRUE))

# Select specific variables (e.g., bio3, bio4, bio6, bio13, bio15)
bio_vars <- bio_stack[[c(3, 4, 6, 13, 15)]]

# ========================================
# Step 2: Clip to UK mainland extent only
# ========================================

# Get country polygons and extract Great Britain (not NI)
uk <- ne_countries(scale = "medium", returnclass = "sf") %>%
  filter(admin == "United Kingdom")

# Optional: exclude Northern Ireland using bounding box for mainland UK
uk_bbox <- st_as_sfc(st_bbox(c(xmin = -6, xmax = 2, ymin = 49.5, ymax = 55.8), crs = 4326))
uk_mainland <- st_intersection(uk, uk_bbox)

# Convert to SpatVector
uk_vect <- vect(uk_mainland)

# Crop and mask the raster
bio_clipped <- crop(bio_vars, uk_vect)
bio_clipped <- mask(bio_clipped, uk_vect)

# ==================================
# Step 3: Save clipped UK bioclim
# ==================================
writeRaster(
  bio_clipped,
  filename = "data/derived/climate/future_uk_bioclim_ssp245_2041_2060.tif",
  overwrite = TRUE
)