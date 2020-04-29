#Load and transform Canada data

library(dplyr)


# pathList <- c("../Covid19Canada","../Covid19Canada/timeseries_hr","../Covid19Canada/timeseries_prov")

loadMergeCanadaData <- function(pathToFiles){
  
  files <-c("cases.csv","testing_cumulative.csv",
            "codebook.csv","mortality.csv",
            "recovered_cumulative.csv","cases_timeseries_hr.csv",
            "mortality_timeseries_hr.csv","cases_timeseries_prov.csv",
            "mortality_timeseries_prov.csv")
  
  inputFiles <- c(paste(pathToFiles[1],files[1],sep="/"),paste(pathToFiles[1],files[2],sep="/"),
                  paste(pathToFiles[1],files[3],sep="/"),paste(pathToFiles[1],files[4],sep="/"),
                  paste(pathToFiles[1],files[5],sep="/"),paste(pathToFiles[2],files[6],sep="/"),
                  paste(pathToFiles[2],files[7],sep="/"),paste(pathToFiles[3],files[8],sep="/"),
                  paste(pathToFiles[3],files[9],sep="/"))
  
  data_cases <- read.csv(inputFiles[8])
  data_deaths <- read.csv(inputFiles[9]) %>% rename(date_report = date_death_report)
  dataTemp <- merge(data_cases, data_deaths, by.x=c("province", "date_report"), by.y=c("province", "date_report"))
  data <- dataTemp %>% rename(delCases=cases,cases=cumulative_cases,delDeaths=deaths,deaths=cumulative_deaths,date=date_report)
  return(data)

  }


loadCanadaData <- function(path){
  dataTemp <- read.csv(file=path)
  data <- dataTemp %>% select(date,state,cases,deaths)
  return(data)
}

loadCanadaPatientData <- function(path){
  data <- read.csv(file=path)
  return(data)
}