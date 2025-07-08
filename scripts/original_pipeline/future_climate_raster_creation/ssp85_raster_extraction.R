# ===============================
# Step 0: Load required libraries
# ===============================
library(terra)
library(sf)
library(rnaturalearth)
library(dplyr)
install.packages("geodata")
library(geodata)

# ============================================
# Step 1: Load and stack desired bioclim layers
# ============================================

# Load full future bioclim raster stack
bio_stack <- rast("data/environmental/worldclim_future/rcp85_2041-2060/wc2.1_30s_bioc_UKESM1-0-LL_ssp585_2041-2060.tif")

# Select specific variables by layer index
bio_vars <- bio_stack[[c(3, 4, 6, 13, 15)]]

# ========================================
# Step 2: Create UK mainland mask (exclude NI)
# ========================================

# Load country boundaries
uk <- ne_countries(scale = "medium", returnclass = "sf") %>%
  filter(admin == "United Kingdom")

# Convert to terra::SpatVector for masking
uk_vect <- vect(uk)

# Download and load GADM level 1 data for detailed UK subdivisions (needs internet on first run)
uk_admin1 <- geodata::gadm(country = "GBR", level = 1, path = tempdir())

# Filter to exclude Northern Ireland (name may vary; inspect unique(uk_admin1$NAME_1))
uk_mainland <- uk_admin1[!uk_admin1$NAME_1 %in% c("Northern Ireland"), ]

uk_mainland_vect <- uk_mainland  # Already a SpatVector

# ============================================
# Step 3: Clip and mask raster using mainland UK only
# ============================================

# Crop and mask
bio_clipped <- crop(bio_vars, uk_mainland_vect)
bio_clipped <- mask(bio_clipped, uk_mainland_vect)

# ==================================
# Step 4: Save clipped UK bioclim
# ==================================
writeRaster(
  bio_clipped,
  filename = "data/derived/future_climate_raster/ssp585_extracted_bioclim/future_uk_bioclim_ssp585_2041_2060.tif",
  overwrite = TRUE
)