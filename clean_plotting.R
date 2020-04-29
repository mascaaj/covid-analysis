# Plotting using ggplot2

library(dplyr)
library(ggplot2)
library(Hmisc)
library(ggthemes)
library(gridExtra)
library(grid)

case_line_size=0.75
death_line_size=0.75

a <- ggplot(databyDate_US,aes(x=date)) + 
  geom_line(aes(y=cases),color="black",size=case_line_size) +
  geom_line(aes(y=deaths),color="red",size=death_line_size) +
  labs(x="Date", y="Cumulative Cases", title="Cumulative: USA cases & deaths") + theme_wsj() +
  theme(plot.title = element_text(size=14))

b <- ggplot(databyDate_IL,aes(x=date)) + 
  geom_line(aes(y=cases),color="black",size=case_line_size) +
  geom_line(aes(y=deaths),color="red",size=death_line_size) +
  labs(x="Date", y="Cumulative Cases", title="Cumulative: Illinois cases & deaths") + theme_wsj() +
  theme(plot.title = element_text(size=14))


c <- ggplot(databyDate_IL_TriCounty_Agg,aes(x=date)) + 
  geom_line(aes(y=cases),color="black",size=case_line_size) +
  geom_line(aes(y=deaths),color="red",size=death_line_size) +
  labs(x="Date", y="Cumulative Cases", title="Cumulative: Central IL 5 County cases & deaths") + theme_wsj() +
  theme(plot.title = element_text(size=14))


d <- ggplot(databyDate_US,aes(x=date)) + 
  geom_line(aes(y=delCases),color="black",size=case_line_size) +
  geom_line(aes(y=delDeaths),color="red",size=death_line_size) +
  geom_smooth(method="loess",span=0.37,aes(x=date,y=delCases))+
  geom_smooth(method="loess",span=0.37,aes(x=date,y=delDeaths))+
  labs(x="Date", y="Daily Case Rate", title="Rate: USA cases & deaths") + theme_wsj() +
  theme(plot.title = element_text(size=14))


e <- ggplot(databyDate_IL,aes(x=date)) + 
  geom_line(aes(y=delCases),color="black",size=case_line_size) +
  geom_line(aes(y=delDeaths),color="red",size=death_line_size) +
  geom_smooth(method="loess",span=0.37,aes(x=date,y=delCases))+
  geom_smooth(method="loess",span=0.37,aes(x=date,y=delDeaths))+
  labs(x="Date", y="Daily Case Rate", title="Rate: Illinois cases & deaths") + theme_wsj() +
  theme(plot.title = element_text(size=14))


f <- ggplot(databyDate_IL_TriCounty_Agg,aes(x=date)) + 
  geom_line(aes(y=delCases),color="black",size=case_line_size) +
  geom_line(aes(y=delDeaths),color="red",size=death_line_size) +
  geom_smooth(method="loess",span=0.37,level = 0.5,aes(x=date,y=delCases))+
  geom_smooth(method="loess",span=0.37,aes(x=date,y=delDeaths))+
  labs(x="Date", y="Daily Case Rate", title="Rate: Central IL 5 County cases & deaths") + theme_wsj() +
  theme(plot.title = element_text(size=14))


plot_topdown_centralIL <- grid.arrange(a,b,c,d,e,f, 
                           nrow=2,
                           top = textGrob(paste("US - Central IL Drill Down ",Sys.Date()),
                                          gp = gpar(fontfamily="mono",fontsize=16, fontface="bold")),
                           bottom = textGrob(
                             "Data Source: nyt open covid 19 dataset",
                             gp = gpar(fontface = 3, fontsize = 9)))
plot(plot_topdown_centralIL)

 summary_US <- ggplot(databyDateState_US,aes(x=date)) + 
    geom_line(aes(y=delCases),color="black",size=case_line_size) +
    geom_line(aes(y=delDeaths),color="red",size=death_line_size) +
    geom_smooth(method="loess",span=0.37,aes(x=date,y=delCases))+
    geom_smooth(method="loess",span=0.37,se=FALSE,aes(x=date,y=delDeaths))+
    facet_wrap(~state,nrow=5, scales = "free_y")+
    labs(x="Date", y="Daily Case Rate", title=paste("Rate: USA Statewide cases & deaths",Sys.Date())) + theme_wsj()+
    theme(axis.text.x = element_text(size = 7, angle = 45))

summary_IN <- ggplot(databyDateState_IN,aes(x=date)) + 
    geom_line(aes(y=delCases),color="black",size=case_line_size) +
    geom_line(aes(y=delDeaths),color="red",size=death_line_size) +
    geom_smooth(method="loess",span=0.5,aes(x=date,y=delCases))+
    geom_smooth(method="loess",span=0.37,se=FALSE,aes(x=date,y=delDeaths))+
    facet_wrap(~state,nrow=5, scales = "free_y")+
    labs(x="Date", y="Daily Case Rate", title=paste("Rate: India Statewide cases & deaths",Sys.Date())) + theme_wsj()+
    theme(axis.text.x = element_text(size = 7, angle = 45))

summary_CA <- ggplot(databyDateState_CA,aes(x=date)) + 
  geom_line(aes(y=delCases),color="black",size=case_line_size) +
  geom_line(aes(y=delDeaths),color="red",size=death_line_size) +
  geom_smooth(method="loess",span=0.5,aes(x=date,y=delCases))+
  geom_smooth(method="loess",span=0.37,se=FALSE,aes(x=date,y=delDeaths))+
  facet_wrap(~province,nrow=5, scales = "free_y")+
  labs(x="Date", y="Daily Case Rate", title=paste("Rate: Canada Provincewide cases & deaths",Sys.Date())) + theme_wsj()+
  theme(axis.text.x = element_text(size = 7, angle = 45))
