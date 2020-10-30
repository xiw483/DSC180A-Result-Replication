#etl.R contains functions used to extract data from different datasets

load_data <- function(data, datadir) {
  # access the selected dataset
  data <- read.delim(datadir)
}