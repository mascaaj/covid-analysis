# Load India data and preprocess

library(dplyr)

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