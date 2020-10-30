fmri <- read.delim("data/raw/fMRI.txt")

x = seq(-5,5,by=0.1)
hist(fmri, breaks=x, freq=F)
