#'data' in this case should be the fMRI BOLD z-scores
get_scores <- function(data) {
  #returns the data
  return(data[,1])
}
find_p_value <- function(data) {
  #returns the pvalues of data
  p.value = 2*(1 - pnorm(abs(get_scores(data))))
  return(p.value)
}

hist_scores <- function(data, outdir) {
  #create histogram for the z-scores
  jpeg(paste(outdir,'fmri_z_hist.jpg',sep = '/'))
  
  x = seq(-12,12,by=0.25)
  hist(get_scores(data), breaks=x, freq=F)
  lines(x, dnorm(x), lwd=2, col='red')
  
  dev.off()
}


exp_obs_p <- function(data,outdir){
  #graph the number of p values less than a threshold
  m=nrow(data)
  p = seq(0,1,by=0.01)
  p.expected = p*m
  p.obtained = rep(0, length(p))
  p.value = find_p_value(data)
  for(i in 1:length(p)) {
    p.obtained[i] = sum(p.value < p[i])
  }
  
  jpeg(paste(outdir,'fmri_exp_bos_tstat.jpg',sep='/'))
  
  plot(p, p.obtained, col='black', type='l', lwd=2, ylab='# p-values')
  lines(p, p.expected, type='l', col='red', lwd=2)
  
  dev.off()
}

exp_obs_zscore <- function(data, outdir) {
  #graph the number of z-scores greater than a threshold
  x = seq(-12,12,by=0.25)
  m=nrow(data)
  z.expected = m*2*(1-pnorm(abs(x)))
  z.obtained = rep(0, length(x))
  for(i in 1:length(x)) {
    z.obtained[i] = sum(abs(get_scores(data)) > abs(x[i]))
  }
  
  jpeg(paste(outdir, 'fmri_exp_bos_zscore.jpg',sep = '/'))
  
  plot(x, z.obtained, col='black', type='l', lwd=2, ylab='# t-stat')
  lines(x, z.expected, type='l', col='red', lwd=2)
  
  dev.off()
}

plot_fdr_p <- function(data,outdir) {
  #Plot the fdr rate of p values
  m=nrow(data)
  p = seq(0,1,by=0.01)
  p.expected = p*m
  p.obtained = rep(0, length(p))
  p.value = find_p_value(data)
  for(i in 1:length(p)) {
    p.obtained[i] = sum(p.value < p[i])
  }
  
  jpeg(paste(outdir, 'fmri_fdr_p.jpg',sep='/'))
  
  plot(p, p.expected/p.obtained, col='black', type='l', lwd=2, ylab='FDR')
  
  dev.off()
}

plot_fdr_zscore <- function(data,outdir) {
  #Plot the fdr rate of z scores
  m=nrow(data)
  x = seq(-12,12,by=0.25)
  z.expected = m*2*(1-pnorm(abs(x)))
  z.obtained = rep(0, length(x))
  for(i in 1:length(x)) {
    z.obtained[i] = sum(abs(get_scores(data)) > abs(x[i]))
  }
  
  jpeg(paste(outdir, 'fmri_fdr_zscore.jpg',sep='/'))
  
  plot(x, z.expected/z.obtained, col='black', type='l', lwd=2, ylab='FDR')
  
  dev.off()
}

generate_plots_mootha <- function(data, outdir) {
  #generate plots and save in output directory
  hist_scores(data, outdir)
  exp_obs_p(data,outdir)
  exp_obs_zscore(data, outdir)
  plot_fdr_p(data,outdir)
  plot_fdr_zscore(data, outdir)
}

