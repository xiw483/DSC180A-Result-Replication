#!/usr/bin/env Rscript

setwd("..")
library("rjson")

source("src/data/etl.R")
source("src/analysis/MoothaAnalysis.R")

main <- function(target) {
  #Runs the main project pipeline.
  #params: target: string must contain 'data','analysis','model'.
  
  if(grepl('data',target, fixed =TRUE)) {
    data_cfg<- fromJSON(file='config/data-params.json')
    data = get_data(data_cfg$data, data_cfg$datadir)
  }
  
  if(grepl('analysis',target, fixed=TRUE)) {
    analysis_cfg<- fromJSON(file='config/analysis-params.json')
    generate_plots_mootha(analysis_cfg$data, analysis_cfg$outdir)
  }
  
  if(grepl('data',target, fixed=TRUE)) {
    data_cfg<- fromJSON(file='config/data-params.json')
    get_data(data_cfg$data, data_cfg$datadir, data_cfg$outpath)
  }
    
  return()
}

if (!interactive()) {
  target = commandArgs(trailingOnly=TRUE)
  main(target)
}
