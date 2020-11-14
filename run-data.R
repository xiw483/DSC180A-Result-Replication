#!/usr/bin/env Rscript

library("rjson")

source("src/data/etl.R")
source("src/analysis/MoothaAnalysis.R")
source("src/analysis/fMRIAnalysis.R")

main <- function(target) {
  #Runs the main project pipeline.
  #params: target: string must contain 'data','analysis','model'.
  
  if(grepl('data',target, fixed =TRUE)) {
    data_cfg<- fromJSON(file='config/data-params.json')
    mootha = get_data(data_cfg$data1, data_cfg$datadir1)
    fmri = get_data(data_cfg$data2, data_cfg$datadir2)
  }
  
  if(grepl('analysis',target, fixed=TRUE)) {
    analysis_cfg<- fromJSON(file='config/analysis-params.json')
    generate_plots_mootha(mootha, analysis_cfg$outdir)
    generate_plots_fmri(fmri, analysis_cfg$outdir)
    
  }
  
  if(grepl('model',target, fixed=TRUE)) {
    data_cfg<- fromJSON(file='config/model-params.json')
    
  }
    
  return()
}

if (!interactive()) {
  target = commandArgs(trailingOnly=TRUE)
  main(target)
}
