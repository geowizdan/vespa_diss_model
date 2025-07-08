# Load required libraries
library(tidyverse)

library(caret)

# Step 1: Load the sampled data
sample_df <- read_csv("data/derived/predictor_sample/predictor_sample_table.csv")

# Step 2: Confirm it's all numeric predictors
glimpse(sample_df)  # Should show 24 numeric columns

# Step 3: Compute Pearson correlation matrix
cor_matrix <- cor(sample_df, use = "complete.obs", method = "pearson")

# Step 4: Optional quick visual check (basic base R heatmap)
heatmap(cor_matrix, symm = TRUE, col = viridis::viridis(100))

# Step 5: Identify highly correlated variables (cutoff = 0.7)
high_cor_vars <- findCorrelation(cor_matrix, cutoff = 0.7, names = TRUE)

# Identify retained variables
retained_vars <- setdiff(colnames(sample_df), high_cor_vars)

# Step 6: Create reduced predictor table
reduced_df <- sample_df %>%
  select(-all_of(high_cor_vars))

# Step 7: Output results
cat("Total variables:", ncol(sample_df), "\n")
cat("Removed due to collinearity:", length(high_cor_vars), "\n")
cat("Retained variables:", ncol(reduced_df), "\n")


cat("Retained variable names:\n")
print(retained_vars)

# Save retained variable names to file
write_lines(retained_vars, "data/derived/predictor_sample/retained_variables.txt")

