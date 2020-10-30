find_t_stats <- function(data) {
  #find the t statistic of given data
  
  t.stat = apply(X=data, MARGIN=1, FUN=function(X){t.test(X[g1],X[g2])$statistic})
  return(t.stat)
}

find_p_value <- function(data) {
  #find the p values of given data
  
  p.value = 2*(1 - pnorm(abs(find_t_stats(data))))
  return(p.value)
}

hist_p <- function(data, outdir) {
  #create histogram for the p-value
  jpeg(paste(outdir,'p_hist.jpg'))
  
  p = seq(0,1,by=0.01)
  hist(find_p_value(data), freq=F)
  lines(p, dunif(p), lwd=2, col='red')
  
  dev.off()
}

hist_tstat <- function(data,outdir) {
  #create histogram for tstat
  jpeg(paste(outdir,'tstat_hist.jpg'))
  
  x = seq(-5,5,by=0.1)
  hist(t.stat, breaks=x, freq=F)
  lines(x, dnorm(x), lwd=2, col='red')
  
  dev.off()
}

exp_obs_p <- function(data) {
  #graph the number of p values less than a threshold
  m=nrow(data)
  p = seq(0,1,by=0.01)
  p.expected = p*m
  p.obtained = rep(0, length(p))
  for(i in 1:length(p)) {
    p.obtained[i] = sum(find_p_value(data) < p[i])
  }
  
  jpeg(paste(outdir,'exp_obs_p.jpg'))
  
  plot(p, p.obtained, col='black', type='l', lwd=2, ylab='# p-values')
  lines(p, p.expected, type='l', col='red', lwd=2)
  
  dev.off()
}

exp_obs_tstat <- function(data, outdir) {
  #graph the number of t statistics greater than a threshold
  x = seq(-5,5,by=0.1)
  m=nrow(data)
  t.expected = m*2*(1-pnorm(abs(x)))
  t.obtained = rep(0, length(x))
  for(i in 1:length(x)) {
    t.obtained[i] = sum(abs(find_t_stats(data)) > abs(x[i]))
  }
  
  jpeg(paste(outdir, 'exp_obs_tstat.jpg'))
  
  plot(x, t.obtained, col='black', type='l', lwd=2, ylab='# t-stat')
  lines(x, t.expected, type='l', col='red', lwd=2)
  
  dev.off()
}

plot_fdr_p <- function(data,outdir) {
  #Plot the fdr rate of p values
  jpeg(paste(outdir, 'fdr_p.jpg'))
  
  m=nrow(data)
  p = seq(0,1,by=0.01)
  p.expected = p*m
  p.obtained = rep(0, length(p))
  for(i in 1:length(p)) {
    p.obtained[i] = sum(find_p_value(data) < p[i])
  }
  
  plot(p, p.expected/p.obtained, col='black', type='l', lwd=2, ylab='FDR')
  
  dev.off()
}

plot_fdr_tstat <- function(data,outdir) {
  #Plot the fdr rate of t statistics
  jpeg(paste(outdir, 'fdr_tstat.jpg'))
  
  m=nrow(data)
  x = seq(-5,5,by=0.1)
  t.expected = m*2*(1-pnorm(abs(x)))
  t.obtained = rep(0, length(x))
  for(i in 1:length(x)) {
    t.obtained[i] = sum(abs(t.stat) > abs(x[i]))
  }
  
  plot(x, t.expected/t.obtained, col='black', type='l', lwd=2, ylab='FDR')
  
  dev.off()
}

generate_plots <- function(data, outdir) {
  #generate plots and save in output directory
  hist_p(data, outdir)
  hist_tstat(data, outdir)
  exp_obs_p(data,outdir)
  exp_obs_tstat(data, outdir)
  plot_fdr_p(data,outdir)
  plot_fdr_tstat(data, outdir)
}

