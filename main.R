# Overall project launch scripts pipeline:
# 
# source the functions from various files
source("loadIndia.R")
source("loadCanada.R")
source("loadUS.R")
# Load and clean / filter data
source("load_data.R")
#
# EDA plots
#source("eda_ill.R")
#
# Cleaner plotting utility
source("clean_plotting.R")
#
#
# Save Analysis Results
source("saveResults.R")
# Unit testing
#
# Analysis / Statistical modelling
#
# Shiny application
