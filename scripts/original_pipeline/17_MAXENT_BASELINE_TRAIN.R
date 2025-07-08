# ============================
# Step 0: Load libraries
# ============================

library(terra)
library(maxnet)
library(tidyverse)

# ============================
# Step 1: Load presence–background table
# ============================
pb_data <- read_csv("data/derived/maxent_input_table.csv")

# Confirm structure
glimpse(pb_data)

# Step 1.1: Drop rows with any NA values
pb_data_clean <- pb_data %>%
  drop_na()  # Removes all rows that contain NA in any column

# Separate predictors and labels
predictors <- pb_data_clean %>% select(-presence)
labels <- pb_data_clean$presence


# ============================
# Step 2: Fit MaxEnt model (baseline settings)
# ============================
# Default: all feature types and auto regularisation
maxent_model <- maxnet(
  p = labels,        # Presence = 1, Background = 0
  data = predictors  # Predictor variables
)

# ============================
# Step 3: Inspect model summary
# ============================
print(maxent_model)

# ============================
# Step 4: Save model for future use
# ============================
saveRDS(maxent_model, file = "data/derived/maxent_model_baseline.rds")

cat("MaxEnt model saved: data/derived/maxent_model_baseline.rds\n")


