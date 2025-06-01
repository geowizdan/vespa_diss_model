library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggspatial)

# Step 1: Load thinned 10 km data
occ_10km <- read_csv("data/cleaned/vespa_velutina_thinned_10km.csv")

# Step 2: Convert to sf object
occ_10km_sf <- st_as_sf(occ_10km, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

# Step 3: Load basemap of Europe
europe <- ne_countries(scale = "medium", continent = "Europe", returnclass = "sf")

# Step 4: Plot
ggplot() +
  geom_sf(data = europe, fill = "grey95", colour = "grey70") +
  geom_sf(data = occ_10km_sf, colour = "darkgreen", size = 1.1, alpha = 0.7) +
  coord_sf(xlim = c(-10, 10), ylim = c(35, 55), expand = FALSE) +
  annotation_scale(location = "bl", width_hint = 0.3) +
  annotation_north_arrow(location = "bl", which_north = "true",
                         style = north_arrow_minimal()) +
  labs(
    title = "Vespa velutina Occurrences (10 km Thinned)",
    subtitle = paste("n =", nrow(occ_10km_sf)),
    caption = "Spatially thinned to 10 km resolution for modelling"
  ) +
  theme_minimal()