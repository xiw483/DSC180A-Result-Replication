library(dplyr)
outpath = "test/testdata"

mootha  = read.table('data/raw/MoothaData.txt')
fmri = read.table('data/raw/fMRI.txt')

set.seed(1)
test_fmri = sample(fmri$V1, 1000, replace=FALSE)
mootha.df <- data.frame(mootha)
test_mootha = sample_n(mootha.df, 1000, replace=FALSE)

write.table(test_mootha, file = paste(outpath,"mootha_test.txt", sep="/"))
write.table(test_fmri, file = paste(outpath,"fmri_test.txt", sep="/"))
