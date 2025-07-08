library(tidyverse)

getwd()

# read the full GBIF dataset (Comma-delimited)
occ <- read_csv("data/raw/europe_extended/EU_ex_vespa_velutina_gbif_converted.csv")

# 1. filter for valid coordinates
occ <- occ %>%
  filter(!is.na(decimalLatitude), !is.na(decimalLongitude))

# 2. filter for CH, DE, NL, IT, AT
occ <- occ %>%
  filter(countryCode %in% c("CH", "DE", "NL", "IT", "AT"))

# 3. Filter for date range (2010–2024)
occ <- occ %>%
  filter(year >= 2010, year <= 2024)

# 4. Filter for valid record types
occ <- occ %>%
  filter(basisOfRecord %in% c("HUMAN_OBSERVATION", "PRESERVED_SPECIMEN"))

# 5. Remove records with common quality flags
issues_to_exclude <- c(
  "ZERO_COORDINATE", "COUNTRY_COORDINATE_MISMATCH",
  "COORDINATE_ROUNDED", "TAXON_MATCH_HIGHERRANK",
  "GEODETIC_DATUM_INVALID"
)

occ <- occ %>%
  filter(!str_detect(issue, paste(issues_to_exclude, collapse = "|")))

# 6. Remove duplicate coordinates (optional)
occ <- occ %>%
  distinct(decimalLatitude, decimalLongitude, .keep_all = TRUE)

# Check how many records remain
cat("Number of cleaned records:", nrow(occ), "\n")

# Save cleaned dataset
write_csv(occ, "data/cleaned/extended_europe_cleaned_occurances/EU_extended_vespa_velutina_cleaned.csv")
