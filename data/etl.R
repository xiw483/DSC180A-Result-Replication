#etl.R contains functions used to extract data from different datasets

get_data <- function(data, outdir) {
  # access the selected dataset
  save(data, file=outdir)
}