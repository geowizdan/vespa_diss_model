# ================================
# Step 0: Load packages
# ================================
library(ecospat)
library(ENMeval)
library(terra)
library(tidyverse)  # includes dplyr, tidyr, readr, ggplot2, etc.


# ================================
# Step 1: Load raster stack and occurrence points
# ================================
envs <- rast("data/derived/rasters_stacked/predictor_stack_final.tif")

# Load and clean occurrence data
# 2. Load and clean occurrence coordinates
occ_df <- read_csv("data/cleaned/vespa_velutina_thinned_1km.csv") %>%
  select(decimalLongitude, decimalLatitude) %>%
  rename(x = decimalLongitude, y = decimalLatitude) %>%
  drop_na()

# ================================
# Step 2: Run ENMeval tuning
# ================================

# Step 3: Run ENMevaluate (v2.0+ syntax, lighter config)
eval <- ENMevaluate(
  occs = occ_df,
  envs = envs,
  algorithm = "maxnet",
  partitions = "randomkfold",
  partition.settings = list(kfolds = 4),  # reduced from 10 to 4 for speed
  tune.args = list(
    fc = c("L", "LQ", "LQH"),
    rm = seq(0.5, 2, 0.5)
  ),
  raster.preds = FALSE,     # skip raster predictions during tuning
  n.bg = 10000,
  parallel = TRUE,
  numCores = 2
)
# ================================
# Step 3: Review and save results
# ================================
results_table <- eval@results
write.csv(results_table, "data/derived/enmeval/enmeval_model_comparison.csv", row.names = FALSE)

# Identify best model by AICc
bestmod_index <- which.min(results_table$AICc)
best_model <- eval@models[[bestmod_index]]

# Save best model
saveRDS(best_model, "data/derived/enmeval/best_maxent_model_enmeval.rds")

cat("Best model index:", bestmod_index, "\n")
print(results_table[bestmod_index, ])