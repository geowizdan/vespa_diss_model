
library(terra)
library(fs)

# Create directory
dir_create("data/environmental/worldclim_baseline")

# Define URL for 30 arc-second bioclimatic variables
url <- "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_bio.zip"

# download the file

download.file(url, destfile = "data/environmental/worldclim_baseline/wc2.1_30s_bio.zip", mode = "wb")

# Unzip the file (works non-winRAR)
unzip("data/environmental/worldclim_baseline/wc2.1_30s_bio.zip", exdir = "data/environmental/worldclim_baseline")


