#File to analyse Corona virus data

library(dplyr)
library(ggplot2)
library(Hmisc)

par(mfrow=c(2,3))

plot(as.Date(databyDate_US$date),databyDate_US$cases, type="l",lwd=2, xlab="Date",ylab="Cumulative Count", main=paste("Cumulative: USA cases & deaths",Sys.Date()))
lines(as.Date(databyDate_US$date),databyDate_US$deaths, type="l",lwd=2, col="red")
minor.tick(nx=1, ny=4)

plot(as.Date(databyDate_IL$date),databyDate_IL$cases, type="l",lwd=2, xlab="Date",ylab="Cumulative Count", main="Cumulative: Illinois cases & deaths")
lines(as.Date(databyDate_IL$date),databyDate_IL$deaths, type="l",lwd=2, col="red")
minor.tick(nx=1, ny=4)

plot(as.Date(databyDate_IL_TriCounty_Agg$date),databyDate_IL_TriCounty_Agg$cases, type="l",lwd=2, xlab="Date",ylab="Cumulative Count", main="Cumulative: Central IL 5 County cases & deaths")
lines(as.Date(databyDate_IL_TriCounty_Agg$date),databyDate_IL_TriCounty_Agg$deaths, type="l",lwd=2, col="red")
minor.tick(nx=1, ny=4)

plot(as.Date(databyDate_US$date),databyDate_US$delCases, type="l",lwd=1, xlab="Date",ylab="Daily Count", main="Rate : USA cases & deaths", las=2)
minor.tick(nx=1, ny=4)
lines(as.Date(databyDate_US$date),databyDate_US$delDeaths, type="l",lwd=3, col="red")
lines(lowess(as.Date(databyDate_US$date),databyDate_US$delCases, f=0.33, iter=25), col="blue", lwd=2, lty=2)
lines(lowess(as.Date(databyDate_US$date),databyDate_US$delDeaths, f=0.27,iter=20), col="blue", lwd=2, lty=2)

plot(as.Date(databyDate_IL$date),databyDate_IL$delCases, type="l",lwd=1, xlab="Date",ylab="Daily Count", main="Rate : Illinois cases & deaths", las=2)
minor.tick(nx=1, ny=4)
lines(as.Date(databyDate_IL$date),databyDate_IL$delDeaths, type="l",lwd=3, col="red")
lines(lowess(as.Date(databyDate_IL$date),databyDate_IL$delCases, f=0.38,iter=25), col="blue", lwd=2, lty=2)
lines(lowess(as.Date(databyDate_IL$date),databyDate_IL$delDeaths, f=0.35,iter=30), col="blue", lwd=2, lty=2)

plot(as.Date(databyDate_IL_TriCounty_Agg$date),databyDate_IL_TriCounty_Agg$delCases, type="l",lwd=1, xlab="Date",ylab="Daily Count", main="Rate : Central IL 5 County cases & deaths", las=2)
minor.tick(nx=1, ny=4)
lines(as.Date(databyDate_IL_TriCounty_Agg$date),databyDate_IL_TriCounty_Agg$delDeaths, type="l",lwd=3, col="red")
lines(lowess(as.Date(databyDate_IL_TriCounty_Agg$date),databyDate_IL_TriCounty_Agg$delCases, f=0.8, iter=5), col="blue", lwd=2, lty=2)
lines(lowess(as.Date(databyDate_IL_TriCounty_Agg$date),databyDate_IL_TriCounty_Agg$delDeaths, f=0.2, iter=100), col="blue", lwd=2, lty=2)
