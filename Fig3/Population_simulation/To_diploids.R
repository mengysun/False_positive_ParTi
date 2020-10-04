library(dplyr)
library(ggfortify)
library(ggplot2)
trait2diploid<-function(d,f){
  for(i in 1:100){
    dat_name<-paste(d,f,i,sep="")
    dat<-read.table(file=dat_name,sep=",",header=FALSE)
    set.seed(i)
    shuffle_dat_index<-c(sample(c(1:66)),sample(67:132),sample(133:200))
    shuffle_dat<-dat[shuffle_dat_index,]
    shuffle_dat_merge<-matrix(0,100,100)
    shuffle_dat_merge<-data.frame(shuffle_dat_merge)
    for(j in 1:100){
      shuffle_dat_merge[j,]<-shuffle_dat[2*j-1,]+shuffle_dat[2*j,]
    }
    file_name<-paste(d,"diploid_",i,"_phenotypes",sep="")
    write.table(shuffle_dat_merge,file=file_name,sep=",",row.names=FALSE,col.names=FALSE)
  }
}
trait2diploid("./MN/","100_multiple_chromosomes_")
trait2diploid("./SN/","100_SingleChr_recombination_normalmigration_normal")
trait2diploid("./SHM/","100_SingleChr_recombination_normalmigration_high")
trait2diploid("./SLM/","100_SingleChr_recombination_normalmigration_low")
trait2diploid("./SHR/","100_SingleChr_high_recombination_normal_migration")
