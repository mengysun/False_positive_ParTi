library(dplyr)
dat_complete<-read.table(file="pc_complete.csv",sep=",",header=FALSE)
dat_wildtype<-read.table(file="pc_wildtype.csv",sep=",",header=FALSE)
complete_PCs<-dat_complete[,c(1:2)]
wildtype_PCs<-dat_wildtype[,c(1:2)]
cor.test(complete_PCs[,1],wildtype_PCs[,1])
