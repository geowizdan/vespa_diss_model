# Load libraries
library(terra)
library(sf)
library(dplyr)
library(rnaturalearth)
library(ggplot2)
library(viridis)

# Step 1: Load bioclim raster stack
bioclim_stack <- rast(list.files(
  "data/environmental/worldclim_baseline/wc2.1_30s_bio",
  pattern = "\\.tif$",
  full.names = TRUE
))

# Step 2: Load and filter training countries
training_countries <- ne_countries(scale = "medium", returnclass = "sf") %>%
  filter(admin %in% c("France", "Spain", "Portugal", "Andorra", "Monaco", "Gibraltar")) %>%
  st_transform(crs = 4326)

# Define bounding box for continental Western Europe
bbox_europe <- st_as_sfc(st_bbox(c(
  xmin = -10, xmax = 10,
  ymin = 35, ymax = 55
), crs = st_crs(4326)))

# Intersect to exclude overseas territories
training_countries_mainland <- st_intersection(training_countries, bbox_europe)

# Step 3: Convert to SpatVector and mask rasters
training_vect <- vect(training_countries_mainland)
bioclim_masked <- mask(crop(bioclim_stack, training_vect), training_vect)

# Step 4: Extract and convert selected variables to data frames
bio2_df <- as.data.frame(bioclim_masked[["wc2.1_30s_bio_2"]], xy = TRUE, na.rm = TRUE)
bio6_df <- as.data.frame(bioclim_masked[["wc2.1_30s_bio_6"]], xy = TRUE, na.rm = TRUE)
bio12_df <- as.data.frame(bioclim_masked[["wc2.1_30s_bio_12"]], xy = TRUE, na.rm = TRUE)

# Step 5: Plotting function
plot_bioclim <- function(df, varname, title) {
  ggplot(df, aes(x = x, y = y, fill = .data[[varname]])) +
    geom_raster() +
    coord_sf() +
    scale_fill_viridis_c(name = title, option = "C") +
    labs(x = "Longitude", y = "Latitude") +
    theme_minimal()
}

# Step 6: Generate plots
p1 <- plot_bioclim(bio2_df, "wc2.1_30s_bio_2", "BIO2: Mean Diurnal Range")
p2 <- plot_bioclim(bio6_df, "wc2.1_30s_bio_6", "BIO6: Min Temp of Coldest Month")
p3 <- plot_bioclim(bio12_df, "wc2.1_30s_bio_12", "BIO12: Annual Precipitation")

# Step 7: Display plots
print(p1)
print(p2)
print(p3)
