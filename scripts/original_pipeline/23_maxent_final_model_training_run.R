# ============================
# Step 0: Load Required Libraries
# ============================
library(terra)
library(maxnet)
library(readr)
library(dplyr)



# ============================
# Step 1: Load Occurrence Data
# ============================
# This is your 10km thinned presence-background table
occ_df <- read_csv("data/derived/maxent_input_table_v2.csv")

# Drop any rows with missing data
occ_df_clean <- occ_df %>% drop_na()

# Separate predictors and labels
labels <- occ_df_clean$presence
predictors <- occ_df_clean %>% select(-presence)

# ============================
# Step 2: Train MaxNet Model with Specific Settings
# ============================
# Use only "linear", "quadratic", and "hinge" features, and RM = 2.0
model_maxnet <- maxnet(
  p = labels,
  data = predictors,
  regmult = 2.0,
  f = maxnet.formula(p = labels, data = predictors, classes = "lqh")
)

# ============================
# Step 4: Save the Model as .RDS
# ============================
saveRDS(model_maxnet, file = "data/derived/enmeval/best_maxent_model_LQH_rm2.rds")

cat("✅ MaxEnt model trained and saved to: data/derived/enmeval/best_maxent_model_LQH_rm2.rds\n")
