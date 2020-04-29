# Overall project launch scripts pipeline:
# 
# source the functions from various files
source("scripts/loadIndia.R")
source("scripts/loadCanada.R")
source("scripts/loadUS.R")
# Load and clean / filter data
source("scripts/load_data.R")
#
# EDA plots
#source("eda_ill.R")
#
# Cleaner plotting utility
source("scripts/clean_plotting.R")
#
#
# Save Analysis Results
source("scripts/saveResults.R")
# Unit testing
#
# Analysis / Statistical modelling
#
# Shiny application
