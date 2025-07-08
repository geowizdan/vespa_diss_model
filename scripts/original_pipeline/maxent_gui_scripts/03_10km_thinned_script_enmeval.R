# ================================
# Step 0: Load libraries
# ================================
library(ENMeval)
library(terra)
library(dplyr)

# ================================
# Step 1: Load occurrence data and raster predictors
# ================================
# Load 10km thinned occurrence data
occ_df <- read.csv("data/derived/maxent_gui_inputs/vespa_occurrence_maxent_10km_formatted.csv") %>%
  select(longitude, latitude)                    # Ensure no NA values

# Optional: Quick check
print(head(occ_df))

# Load environmental raster stack
envs <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# Optional but recommended: remove NAs from occurrence–env extraction
env_vals <- extract(envs, occ_df[, c("longitude", "latitude")])
occ_df <- occ_df[complete.cases(env_vals), ]

# ================================
# Step 2: Run ENMevaluate
# ================================
eval <- ENMevaluate(
  occs = occ_df,
  envs = envs,
  algorithm = "maxnet",
  partitions = "block",                     # spatially robust
  tune.args = list(
    fc = c("L", "LQ", "LQH"),               # includes Hinge
    rm = seq(0.5, 2.5, 0.5)                 # includes RM = 1
  ),
  n.bg = 10000,                             # background sample size
  raster.preds = TRUE,                      # save prediction rasters
  parallel = TRUE,
  numCores = 2,
  taxon.name = "Vespa velutina"   # balance for 4-core machine
)

# ================================
# Step 3: Review and save results
# ================================
# Save full results table
results_table <- eval@results
write.csv(results_table, "data/derived/enmeval/enmeval_model_comparison_10km.csv", row.names = FALSE)

# Identify best model by minimum AICc
bestmod_index <- which.min(results_table$AICc)
best_model <- eval@models[[bestmod_index]]

# Save best model object for prediction
saveRDS(best_model, "data/derived/enmeval/best_maxent_model_enmeval_10km.rds")

# Print results summary
cat("Best model index:", bestmod_index, "\n")
print(results_table[bestmod_index, ])
