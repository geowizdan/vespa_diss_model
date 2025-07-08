# ======================
# Step 0: Load Libraries
# ======================
library(terra)
library(tidyverse)

# ================================
# Step 1: Load Raster and Presence
# ================================

# Load the final predictor raster stack (8 layers)
predictor_stack <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")
names(predictor_stack)

names(predictor_stack) <- c(
  "bio_3", "bio_4", "bio_6", "bio_13", "bio_15",
  "dist_urban", "dist_forest", "dist_agriculture"
)

# Load thinned presence data
presence_df <- read_csv("data/cleaned/vespa_velutina_thinned_10km.csv")

# Convert to spatial object (SpatVector) using decimalLongitude and decimalLatitude
presence_pts <- vect(presence_df, geom = c("decimalLongitude", "decimalLatitude"), crs = crs(predictor_stack))

# ================================
# Step 2: Generate Background Points
# ================================

# Sample 10,000 random points across valid raster cells (land only)
background_pts <- spatSample(
  x = predictor_stack,   # Raster stack
  size = 10000,          # Number of background points
  method = "random",     # Random sampling
  na.rm = TRUE,          # Avoid sampling over NA (sea)
  as.points = TRUE       # Return as SpatVector
)

# ================================
# Step 3: Extract Environmental Values
# ================================

# Extract predictor values at presence points
presence_vals <- terra::extract(predictor_stack, presence_pts)
presence_vals$presence <- 1  # Label as presence

# Extract predictor values at background points
background_vals <- terra::extract(predictor_stack, background_pts)
background_vals$presence <- 0  # Label as background

# ================================
# Step 4: Combine and Save Final Dataset
# ================================

# Combine into a single data frame
combined_data <- bind_rows(presence_vals, background_vals)

# Remove ID column (first column) if present
combined_data <- combined_data %>% select(-ID)

# Save to CSV for MaxEnt
write_csv(combined_data, "data/derived/maxent_input_table_v2.csv")

# ============================
# Final Output Summary
# ============================
cat("✅ MaxEnt input table saved to: data/derived/maxent_input_table.csv\n")
cat("Total rows:", nrow(combined_data), "\n")
cat("Columns:", paste(colnames(combined_data), collapse = ", "), "\n")
