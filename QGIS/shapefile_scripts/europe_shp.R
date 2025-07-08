library(rnaturalearth)
library(sf)
library(dplyr)

# Load all European countries as sf object
europe <- ne_countries(scale = "medium", continent = "Europe", returnclass = "sf")

# Filter training countries
training_countries <- europe %>%
  filter(admin %in% c("France", "Spain", "Portugal", "Andorra", "Gibraltar"))

# Confirm result
plot(training_countries["admin"])


# Save as Shapefile
st_write(training_countries, "data/shapefiles/training_countries.shp", delete_layer = TRUE)

# OR save as GeoPackage (preferred for multi-layer projects)
st_write(training_countries, "data/shapefiles/training_countries.gpkg", layer = "training", delete_layer = TRUE)
