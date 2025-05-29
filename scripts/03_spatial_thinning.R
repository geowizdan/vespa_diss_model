library(spThin)

occ <- read_csv("data/cleaned/vespa_velutina_cleaned.csv")


thin_output <- thin(
  loc.data = occ,
  lat.col = "decimalLatitude",
  long.col = "decimalLongitude",
  spec.col = "species",
  thin.par = 1,
  reps = 1,
  write.files = FALSE,
  verbose = T
)

# Convert output to dataframe
occ_thinned <- thin_output[[1]]
