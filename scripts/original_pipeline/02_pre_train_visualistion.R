library(tidyverse)
library(sf)
library(ggspatial)
library(rnaturalearth)
library(rnaturalearthdata)

occ <- read_csv("data/cleaned/vespa_velutina_cleaned.csv")

# Convert to spatial object (WGS84 = EPSG:4326)
occ_sf <- st_as_sf(occ, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

# Natural Earth data (Europe extent)
europe <- ne_countries(scale = "medium", continent = "Europe", returnclass = "sf")

ggplot()+
  geom_sf(data = europe, fill = "grey95", colour = "grey50") +
  geom_sf(data = occ_sf, colour = "darkred", size = 1, alpha = 0.7) +
  coord_sf(xlim = c(-10, 10), ylim = c(35,55), expand = F) +
  annotation_scale(location = "bl", width_hint = 0.3) +
  annotation_north_arrow(location = "bl", which_north = "true",
                         style = north_arrow_minimal()) +
  labs(title = "Vespa velutina Occurrences (Filtered)",
       caption = "GBIF data | Filtered: 2010–2024, France/Spain/Portugal only") +
  theme_minimal()

ggsave("results/figures/vespa_occurrence_map.png", width = 8, height = 6, dpi = 300)
