library(ggfortify)
library(ggplot2)
library(dplyr)
library(MASS)
set.seed(8)
independent_mat<-diag(100)
mu<-numeric(100)
for(i in 1:100){
  #new_variance<-rgamma(100,50,50)
  new_variance<-runif(100,0,10)
  dat<-matrix(0,nrow=100,ncol=100)
  for(j in 1:100){
    sigma<-new_variance[j]*independent_mat
    dat[j,]<-mvrnorm(1,mu,sigma)
  }
  dat_name<-paste("dat_","unequal_uniform_large_",i,sep="")
  write.table(dat,file=dat_name,sep=",",col.names=FALSE,row.names=FALSE)
}

