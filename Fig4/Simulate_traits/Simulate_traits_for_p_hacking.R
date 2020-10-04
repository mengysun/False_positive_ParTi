library(dplyr)
library(ggplot2)
library(ggfortify)
library(rgl)
library(clusterGeneration)
set.seed(8)
for(k in 1:100){
  mean_vec<-runif(n=100,min = 1,max=10)
  cov_mat_p<-genPositiveDefMat("unifcorrmat",dim=100)
  cov_mat<-cov_mat_p$Sigma
  dat<-mvrnorm(n =1000,mu = mean_vec,Sigma = cov_mat)
  dat_z_scoring<-dat
  gene_mean<-colMeans(dat)
  sd_genes_raw<-numeric(100)
  for(i in 1:100){
    sd_genes_raw[i]<-sd(dat[,i])
  }
  for(i in 1:100){
    dat_z_scoring[,i]<-(dat_z_scoring[,i]-gene_mean[i])/sd_genes_raw[i]
  }
  mean_cutoffs<-as.numeric(quantile(gene_mean,probs=c(1:10)/10))
  sd_cutoffs<-as.numeric(quantile(sd_genes_raw,probs=c(1:10)/10))
  mean_cutoffs<-c(min(gene_mean),mean_cutoffs)
  sd_cutoffs<-c(min(sd_genes_raw),sd_cutoffs)
  
  #raw data
  #mean cutoff
  for(i in 1:10){
    dat_i<-dat[,gene_mean>=mean_cutoffs[i]]
    dat_names<-paste("dat_raw",k,"mean",i,sep="_")
    write.table(dat_i,file=dat_names,sep=",",row.names=FALSE,col.names=FALSE)
  }
  #sd cutoff
  for(i in 1:10){
    dat_i<-dat[,sd_genes_raw>=sd_cutoffs[i]]
    dat_names<-paste("dat_raw",k,"sd",i,sep="_")
    write.table(dat_i,file=dat_names,sep=",",row.names=FALSE,col.names=FALSE)
  }
  #z-scoring
  #mean cutoff
  for(i in 1:10){
    dat_i<-dat_z_scoring[,gene_mean>=mean_cutoffs[i]]
    dat_names<-paste("dat_z",k,"mean",i,sep="_")
    write.table(dat_i,file=dat_names,sep=",",row.names=FALSE,col.names=FALSE)
  }
  
  #sd cutoff
  for(i in 1:10){
    dat_i<-dat_z_scoring[,sd_genes_raw>=sd_cutoffs[i]]
    dat_names<-paste("dat_z",k,"sd",i,sep="_")
    write.table(dat_i,file=dat_names,sep=",",row.names=FALSE,col.names=FALSE)
  }
}
