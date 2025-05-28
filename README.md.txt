vespa_diss_model/
│
├── data/
│   ├── raw/                    # Original downloads (GBIF CSV, WorldClim, CORINE)
│   ├── cleaned/                # Cleaned occurrence data, filtered rasters
│   ├── shapefiles/             # England boundary, projection masks
│   └── derived/                # Distance rasters, scenario LULC, correlation tables
│
├── scripts/
│   ├── 01_data_cleaning.R      # GBIF filtering, thinning
│   ├── 02_raster_preprocessing.R  # Climate + LULC harmonisation
│   ├── 03_variable_selection.R    # Correlation filtering
│   ├── 04_model_tuning.R       # ENMeval MaxEnt tuning
│   ├── 05_projection.R         # Projections to future England scenarios
│   └── 06_visualisation.R      # Maps and figures in R
│
├── models/
│   ├── maxent_outputs/         # Raw MaxEnt outputs (log files, .asc/.tif rasters)
│   └── projections/            # Rasters of suitability under different scenarios
│
├── results/
│   ├── figures/                # Maps, plots, variable importance
│   ├── tables/                 # AUC, AICc scores, contribution summaries
│   └── final_outputs/          # Results selected for inclusion in dissertation
│
├── qgis_project/
│   ├── vespa_project.qgz       # Main QGIS visualisation project file
│   └── styles/                 # QGIS symbology or templates
│
├── report/
│   ├── dissertation_draft.docx  # Your written document
│   ├── references.bib           # Optional, if using reference manager
│   └── notes/                   # Ideas, outlines, scratchpad files