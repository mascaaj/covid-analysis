# Load India data and preprocess

library(dplyr)

# dataDir2 <- "../covid-19-india-data"
# india <- "complete.csv"
# indiaPatients <- "patients_data.csv"
# inputFile3 <- paste(dataDir2,india,sep="/")
# inputFile4 <- paste(dataDir2,indiaPatients,sep="/")

loadIndiaData <- function(path){
  dataTemp <- read.csv(file=path)
  data <- dataTemp %>% 
    rename(date=Date,state=Name.of.State...UT,cases=Total.Confirmed.cases,deaths=Death) %>% 
    select(date,state,deaths,cases)
  return(data)
}

loadIndiaPatientData <- function(path){
  data <- read.csv(file=path)
  return(data)
}