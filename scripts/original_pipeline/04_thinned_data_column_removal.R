# Load necessary package
library(readr)
library(dplyr)

# Step 1: Load the dataset
occ_raw <- read_csv("data/cleaned/vespa_velutina_thinned_1km.csv")

#check column names
colnames(occ_raw)

#drop unwanted colums

occ_raw$decimalLongitude...51 <- NULL
occ_raw$decimalLatitude...52 <- NULL
occ_raw$decimalLongitude...53 <- NULL
occ_raw$decimalLatitude...54 <- NULL

# Step 3: Rename the correct coordinate columns to standard names
# Step 3: Rename the correct coordinate columns to standard names
names(occ_raw)[names(occ_raw) == "decimalLongitude...49"] <- "decimalLongitude"
names(occ_raw)[names(occ_raw) == "decimalLatitude...50"]  <- "decimalLatitude"

write_csv(occ_raw, "data/cleaned/vespa_velutina_thinned_1km.csv")