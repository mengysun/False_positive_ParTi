library(dplyr)
dat_raw<-read.table(file="deleteome_all_mutants_controls.txt",sep="\t",header=TRUE,quote="",stringsAsFactors=F)
#get the columns contain the deletion line data
dat_raw_1<-dat_raw[,c(1:4455)]
dat_raw_2<-dat_raw_1
MA_columns<-as.character(dat_raw_1[1,])
#extract the M and A values, save into different table
dat_raw_1<-dat_raw_1[c(2:6183),MA_columns=="A"]
dat_raw_2<-dat_raw_2[c(2:6183),MA_columns=="M"]
dat_raw_1<-as.data.frame(t(dat_raw_1))
dat_raw_2<-as.data.frame(t(dat_raw_2))
write.table(dat_raw_1,file="dat_all_exp1.csv",sep=",",col.names = FALSE,row.names = FALSE,quote=FALSE)
write.table(dat_raw_2,file="dat_all_exp2.csv",sep=",",col.names = FALSE,row.names = FALSE,quote=FALSE)
