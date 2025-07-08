library(readr)

# Load the original GBIF data (tab-delimited)
occ <- read_tsv("data/raw/europe_extended/0102535-250525065834625.csv")


# Save it as a true comma-separated CSV
write_csv(occ, "data/raw/vespa_velutina_gbif_converted.csv")
