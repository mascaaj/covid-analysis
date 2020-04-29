# File to save results to a result folder

#Central Il drilldown
result_folder <- c("results")
results_plot_names <- c("central_il_drilldown.png",
                        "country_comparison.png",
                        "us_state_summary.png",
                        "canada_province_summary.png",
                        "india_state_summary.png")


savePlot <- function(saveFolder,plotName,plotData,wid=18,hig=9,dpi=600){
  ggsave(paste(saveFolder,plotName[1],sep="/"), 
         plot = plotData, # or give ggplot object name as in myPlot,
         width = wid, height = hig, 
         units = "in", # other options c("in", "cm", "mm"), 
         dpi = dpi)
}

savePlot(saveFolder = result_folder,plotName = results_plot_names[1],plotData = plot_topdown_centralIL)
savePlot(saveFolder = result_folder,plotName = results_plot_names[2],plotData = plot_country_compare)
savePlot(saveFolder = result_folder,plotName = results_plot_names[3],plotData = summary_US)
savePlot(saveFolder = result_folder,plotName = results_plot_names[4],plotData = summary_CA)
savePlot(saveFolder = result_folder,plotName = results_plot_names[5],plotData = summary_IN)
