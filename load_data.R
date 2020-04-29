# Load in data from csv and dress data
library(dplyr)
library(ggplot2)
library(Hmisc)
library(lubridate)

#Directory paths and filenames
usPathList <- c("../covid-19-data")
indiaPathList <- c("../covid-19-india-data")
canadaPathList <- c("../Covid19Canada","../Covid19Canada/timeseries_hr","../Covid19Canada/timeseries_prov")
usFileList <- c("us.csv","us-counties.csv","complete.csv")
indiaFileList <- c("complete.csv","patients_data.csv")
# india <- "complete.csv"
# indiaPatients <- "patients_data.csv"

inputFile <- paste(usPathList[1],usFileList[2],sep="/")
inputFile2 <- paste(usPathList[1],usFileList[1],sep="/")
inputFile3 <- paste(indiaPathList[1],indiaFileList[1],sep="/")
inputFile4 <- paste(indiaPathList[1],indiaFileList[2],sep="/")

#Read Data
data <- read.csv(file=inputFile)
data2 <- read.csv(file=inputFile2)

# obsolete with new load functions
# data3 <- read.csv(file=inputFile3)
# data4 <- read.csv(file=inputFile4)
# dataIndia <- data3 %>% 
#   rename(date=Date,state=Name.of.State...UT,cases=Total.Confirmed.cases,deaths=Death) %>% 
#   select(date,state,deaths,cases)

#Selecting what date is to be processed from original dataset

databyDateState_CA <- loadMergeCanadaData(pathToFiles=canadaPathList)
dataIndia <- loadIndiaData(path=inputFile3)

dataIllinois <- data %>% filter(state=="Illinois") %>% select(date,cases,deaths)

#Aggregating data by date and/or state
databyDate_IL <- aggregate(cbind(cases=dataIllinois$cases,
                                 deaths=dataIllinois$deaths),
                           by=list(date=dataIllinois$date),FUN=sum)

databyDate_US <- aggregate(cbind(cases=data2$cases,
                                 deaths=data2$deaths),
                           by=list(date=data2$date),FUN=sum)

databyDate_CA <- aggregate(cbind(cases=databyDateState_CA$cases,
                                 deaths=databyDateState_CA$deaths),
                           by=list(date=databyDateState_CA$date),FUN=sum)

databyDateState_US <- aggregate(cbind(cases=data$cases,
                                 deaths=data$deaths),
                           by=list(date=data$date,state=data$state),FUN=sum)

databyDateState_IN <- aggregate(cbind(cases=dataIndia$cases,
                                      deaths=dataIndia$deaths),
                                by=list(date=dataIndia$date,state=dataIndia$state),FUN=sum)

#Create new variables
databyDate_US <- databyDate_US %>%  mutate(deathPerCasePercent = (deaths/cases)*100) %>% 
  mutate(lag_cases = lag(cases)) %>% 
  mutate(lag_deaths=lag(deaths)) %>%
  na.omit() %>% 
  mutate(delDeaths = deaths-lag_deaths) %>% 
  mutate(delCases = cases-lag_cases)

databyDateState_US <- databyDateState_US %>%  mutate(deathPerCasePercent = (deaths/cases)*100) %>% 
  mutate(lag_cases = lag(cases)) %>% 
  mutate(lag_deaths=lag(deaths)) %>%
  na.omit() %>% 
  mutate(delDeaths = ifelse(deaths-lag_deaths>0,deaths-lag_deaths,0)) %>%
  mutate(delCases = ifelse(cases-lag_cases>0,cases-lag_cases,0))

databyDateState_IN <- databyDateState_IN %>%  mutate(deathPerCasePercent = (deaths/cases)*100) %>% 
  mutate(lag_cases = lag(cases)) %>% 
  mutate(lag_deaths=lag(deaths)) %>%
  na.omit() %>% 
  mutate(delDeaths = ifelse(deaths-lag_deaths>0,deaths-lag_deaths,0)) %>%
  mutate(delCases = ifelse(cases-lag_cases>0,cases-lag_cases,0))

databyDate_IL <- databyDate_IL %>%  mutate(deathPerCasePercent = (deaths/cases)*100) %>% 
  mutate(lag_cases = lag(cases)) %>% 
  mutate(lag_deaths=lag(deaths)) %>%
  na.omit() %>% 
  mutate(delDeaths = deaths-lag_deaths) %>% 
  mutate(delCases = ifelse(cases-lag_cases>0,cases-lag_cases,0))

databyDate_CA <- databyDate_CA %>%  mutate(deathPerCasePercent = (deaths/cases)*100) %>% 
  mutate(lag_cases = lag(cases)) %>% 
  mutate(lag_deaths=lag(deaths)) %>%
  na.omit() %>% 
  mutate(delDeaths = ifelse(deaths-lag_deaths>0,deaths-lag_deaths,0)) %>% 
  mutate(delCases = ifelse(cases-lag_cases>0,cases-lag_cases,0))


databyDate_IL_County <- data %>% 
  filter(state=="Illinois") %>% select(date,cases,deaths,county)


databyDate_IL_TriCounty_temp <- databyDate_IL_County %>%  
  filter(county=="Peoria"| county=="Tazewell"| county=="Woodford" | county=="Marshall" | county=="Stark") 


databyDate_IL_TriCounty <- select(databyDate_IL_TriCounty_temp,date,cases,deaths)

databyDate_IL_TriCounty_Agg <- aggregate(cbind(cases=databyDate_IL_TriCounty$cases,
                                               deaths=databyDate_IL_TriCounty$deaths),
                                         by=list(date=databyDate_IL_TriCounty$date),FUN=sum)

databyDate_IL_TriCounty_Agg <- databyDate_IL_TriCounty_Agg %>% 
  mutate(deathPerCasePercent = (deaths/cases)*100) %>%
  mutate(lag_cases = lag(cases)) %>%
  mutate(lag_deaths=lag(deaths)) %>%
  na.omit() %>%
  mutate(delDeaths = ifelse(deaths-lag_deaths>0,deaths-lag_deaths,0)) %>%
  mutate(delCases = ifelse(cases-lag_cases>0,cases-lag_cases,0))

#Coercing Date into date format
dataIllinois$date <- as.Date(dataIllinois$date)
databyDate_IL$date <- as.Date(databyDate_IL$date)
databyDate_US$date <- as.Date(databyDate_US$date)
databyDate_IL_TriCounty_Agg$date <- as.Date(databyDate_IL_TriCounty_Agg$date)
databyDateState_US$date <- as.Date(databyDateState_US$date)
databyDateState_IN$date <- as.Date(databyDateState_IN$date)
databyDate_CA <- as.Date(databyDate_CA$date,"%d-%m-%y")
databyDateState_CA$date <- as.Date(databyDateState_CA$date,"%d-%m-%y")
