#etl.R contains functions used to extract data from different datasets

get_data <- function(data, datadir, outpath=NA) {
  # access the selected data set
  data <- read.delim(datadir)
  
  if(is.na(outpath)) {
    return(data)
  }
  else {
    write(data, outpath, sep = "\t")
  }
}