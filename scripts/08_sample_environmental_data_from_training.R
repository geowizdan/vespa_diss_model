# Step 1: Load fresh libraries
library(sf)
library(terra)
library(rnaturalearth)
library(dplyr)

# Step 2: Load raster stack (if not already loaded)
bioclim_stack <- rast(list.files(
  "data/environmental/worldclim_baseline/wc2.1_30s_bio",
  pattern = "\\.tif$",
  full.names = TRUE
))

# Step 3: Get country polygons fresh from rnaturalearth
europe_countries <- ne_countries(scale = "medium", returnclass = "sf")

class(europe_countries)
names(europe_countries)

# Step 4: Filter training countries and transform
training_countries <- europe_countries %>%
  filter(admin %in% c("France", "Spain", "Portugal", "Andorra", "Monaco", "Gibraltar")) %>%
  st_transform(crs = 4326)  # EPSG:4326 for WorldClim

# Define bounding box for continental Western Europe
bbox_europe <- st_as_sfc(st_bbox(c(
  xmin = -10, xmax = 10,
  ymin = 35, ymax = 55
), crs = st_crs(4326)))

# Intersect to exclude overseas territories
training_countries_mainland <- st_intersection(training_countries, bbox_europe)

# Step 5: Convert sf to SpatVector

training_vect <- vect(training_countries_mainland)

# Step 6: Crop the raster stack to the training countries
bioclim_masked <- crop(bioclim_stack, training_vect)
bioclim_masked <- mask(bioclim_masked, training_vect)

# Step 7 Sample points from the cropped raster

sample_points <- spatSample(
  bioclim_masked,
  size = 10000,
  method = "random",
  na.rm = TRUE,
  as.df = TRUE
)

# Step 8: Quick check
print(head(sample_points))

# Step 9: Save the sampled points to a CSV file
write.csv(sample_points, "data/derived/climate_sample_western_europe.csv", row.names = FALSE)
