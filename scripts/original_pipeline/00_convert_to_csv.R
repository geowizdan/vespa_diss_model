library(readr)

# Load the original GBIF data (tab-delimited)
occ <- read_tsv("data/raw/vespa_velutina_gbif.csv")

# Save it as a true comma-separated CSV
write_csv(occ, "data/raw/vespa_velutina_gbif_converted.csv")
