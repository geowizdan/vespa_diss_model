library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(patchwork)  # For side-by-side plots

# Load full (unthinned) data
occ_raw <- read_csv("data/cleaned/vespa_velutina_cleaned.csv") %>%
  st_as_sf(coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

# Load thinned data
occ_thinned <- read_csv("data/cleaned/vespa_velutina_thinned_1km.csv") %>%
  st_as_sf(coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

names(occ_thinned)

# Load base map of Europe
europe <- ne_countries(scale = "medium", continent = "Europe", returnclass = "sf")

# Plot A: Raw data
p1 <- ggplot() +
  geom_sf(data = europe, fill = "grey95", colour = "grey70") +
  geom_sf(data = occ_raw, colour = "darkred", alpha = 0.5, size = 0.7) +
  labs(title = "Before Spatial Thinning", subtitle = paste("n =", nrow(occ_raw))) +
  coord_sf(xlim = c(-10, 10), ylim = c(35, 55), expand = FALSE) +
  theme_minimal()

# Plot B: Thinned data
p2 <- ggplot() +
  geom_sf(data = europe, fill = "grey95", colour = "grey70") +
  geom_sf(data = occ_thinned, colour = "blue", alpha = 0.8, size = 0.8) +
  labs(title = "After 1 km Spatial Thinning", subtitle = paste("n =", nrow(occ_thinned))) +
  coord_sf(xlim = c(-10, 10), ylim = c(35, 55), expand = FALSE) +
  theme_minimal()

# Combine plots
p1 + p2
