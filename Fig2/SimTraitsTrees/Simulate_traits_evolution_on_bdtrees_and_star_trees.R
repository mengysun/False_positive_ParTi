library(phylocurve)
library(ggfortify)
library(ggplot2)
library(dplyr)
library(rgl)
library(ape)
library(geiger)
library(clusterGeneration)
set.seed(8)
d_list<-runif(100,0,1)
seed_list<-c(1:100)
independent_mat<-diag(100)
for(i in 1:100){
  tree<-sim.bdtree(b=1,d=d_list[i], stop="taxa", n=100,seed=seed_list[i],extinct=FALSE)
  tree<-drop.extinct(tree)
  sim_evolved_full<-sim.traits(tree=tree, ntraits = 100,v=independent_mat)
  evolved_mat_full<-sim_evolved_full$trait_data
  sim_null<-sim.traits(tree=tree,ntraits=100,v=independent_mat,model="lambda",parameters = list(lambda=0))
  null_mat<-sim_null$trait_data
  qq<-list()
  for(j in 1:100){
    qq[[j]]<-rbind(c(-.05, .05), c(.05, -.05))
  }
  msims <- sim.char(tree, qq, model="discrete", n=1)
  discrete_mat<-msims[,,1]-1
  dat_name<-paste("dat",i,sep="")
  write.table(evolved_mat_full,file=dat_name,sep=",",col.names=FALSE,row.names=FALSE)
  dat_name<-paste("art",i,sep="")
  write.table(discrete_mat,file=dat_name,sep=",",col.names=FALSE,row.names=FALSE)
  dat_null_name<-paste("dat_null",i,sep="")
  write.table(null_mat,file=dat_null_name,sep=",",col.names=FALSE,row.names=FALSE)
}

