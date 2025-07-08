# Load required package
library(terra)

# Step 1: Load the full predictor stack (24 layers: bioclim + distance)
predictor_stack <- rast("data/derived/rasters_stacked/predictor_stack.tif")

# Step 2: Randomly sample 10,000 cells across the study area
# 'method = "random"' ensures even sampling; 'na.rm = TRUE' avoids missing data
sampled_points <- spatSample(
  x = predictor_stack,
  size = 10000,
  method = "random",
  na.rm = TRUE,
  as.df = TRUE  # Return as a data.frame (not spatial object)
)

# Step 3: Inspect the sampled data (first few rows)
head(sampled_points)

# Step 4: Save the sampled table to CSV for analysis and reproducibility
write.csv(
  sampled_points,
  "data/derived/predictor_sample/predictor_sample_table.csv",
  row.names = FALSE
)

# Step 5: Report number of samples and variables extracted
cat("Saved", nrow(sampled_points), "sampled points with", ncol(sampled_points), "variables.\n")