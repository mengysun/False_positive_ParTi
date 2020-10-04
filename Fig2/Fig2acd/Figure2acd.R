library(dplyr)
library(ggplot2)
library(readr)
library(gridExtra)
library(grid)
library(ggExtra)
#bd tree data
p_values<-numeric(100)
N<-numeric(100)
N_from_art<-numeric(100)
min_art<-numeric(100)
directory<-"../Phylogenetic_results/"
for(i in 1:100){
  header=paste("Analysis",i,sep="")
  pin<-paste(directory,header,"p.txt",sep="")
  nin<-paste(directory,header,"N.txt",sep="")
  ein<-paste(directory,header,"_discrete_significant.csv",sep="")
  p_file<-read.table(file=pin,sep=",",header=TRUE)
  N_file<-read.table(file=nin,sep="\t",header=TRUE)
  p_values[i]<-as.numeric(as.character(p_file$pval))
  N[i]<-as.numeric(as.character(N_file[1,1]))
  enrich_file<-read.csv(file=ein,header=TRUE)
  unique_features<-as.numeric(names(table(enrich_file$Feature.Name))[table(enrich_file$Feature.Name)==1])
  enrich_unique_index<-match(unique_features,enrich_file$Feature.Name)
  enrich_file_unique<-enrich_file[enrich_unique_index,]
  N_from_art[i]<-length(unique(enrich_file_unique[,1]))
  min_art[i]<-min(table(enrich_file_unique[,1]))
}
dat_tree<-data.frame(p_values,N,N_from_art,min_art)
sum(dat_tree<=0.05)
#null data
directory_null<-"../Star_tree_results/"
p_null<-numeric(100)
for(i in 1:100){
  file_name<-paste(directory_null,"Analysis_null",i,"p.txt",sep="")
  p_null_file<-read.table(file=file_name,sep=",",header=TRUE)
  p_null[i]<-as.numeric(as.character(p_null_file$pval))
}
sum(p_null<=0.05)
#unequal_branch data
directory_uq_branch<-"../Star_tree_unequal_branch_results/"
p_uq_branch<-numeric(100)
for(i in 1:100){
  file_name<-paste(directory_uq_branch,"Analysis_uniform_large",i,"p.txt",sep="")
  p_uq_file<-read.table(file=file_name,sep=",",header=TRUE)
  p_uq_branch[i]<-as.numeric(as.character(p_uq_file$pval))
}
sum(p_uq_branch<=0.05)
#Figure2a
bar_dat<-data.frame(c("With tree","Without tree"),c(75/100,0/100))
names(bar_dat)<-c("Condition","Fraction_significant")
bar_dat$Condition<-factor(bar_dat$Condition,levels=c("With tree","Without tree"))
png(filename="Fig2a.png",units="in",width=10,height=7.48,res=600)
ggplot(data=bar_dat,aes(x=Condition,y=Fraction_significant,fill=Condition))+
  geom_bar(stat = "identity",alpha=0.7)+
  geom_hline(yintercept = 0.05,color="black",linetype="dotted")+
  xlab(label="")+
  ylab(label="Fraction of significance")+
  theme_linedraw()+theme(legend.position = "none")+
  # theme(legend.title=element_blank())+
  # theme(legend.text=element_text(size=24,family="TT Arial",color="black",face="bold"))+
  # theme(legend.direction = "horizontal")+
  theme(legend.margin=margin(-0.5))+
  removeGridX()+
  theme(axis.title.x=element_blank())+
  theme(axis.text.y=element_text(size=30,family="Times",color="black"))+
  theme(axis.title.y=element_text(size=36,family="Times",color="black",face="bold",margin=margin(t=0,r=24,b=0,l=0)))+
  theme(axis.text.x=element_text(size=36,family="Times",color="black",face="bold",margin=margin(t=24,r=0,b=24,l=0)))+
  scale_y_continuous(limits=c(0,0.8),breaks=c(0,0.25,0.5,0.75),expand=c(0,0))
dev.off()
#Figure2c
dat_tree_significant<-dat_tree[dat_tree$p_values<=0.05,]
png(filename="Fig2c.png",units="in",width=10,height=7.48,res=600)
ggplot(data=dat_tree_significant,aes(x=N))+
  geom_bar(alpha=0.9)+
  xlab(label="\n Number of archetypes")+
  ylab(label="Count")+
  theme_linedraw()+theme(legend.position = "none")+
  removeGridX()+
  theme(axis.title.x=element_text(size=36,family="Times",color="black",face="bold"))+
  theme(axis.text.y=element_text(size=30,family="Times",color="black"))+
  theme(axis.title.y=element_text(size=36,family="Times",color="black",face="bold",margin=margin(t=0,r=24,b=0,l=0)))+
  theme(axis.text.x=element_text(size=30,family="Times",color="black",margin=margin(t=0,r=0,b=0,l=0)))+
  scale_y_continuous(limits=c(0,32),breaks=c(0,10,20,30),expand=c(0,0))
dev.off()
dat_tree_significantUnique<-dat_tree_significant[dat_tree_significant$N==dat_tree_significant$N_from_art,]
#Figure2d
png(filename="Fig2d.png",units="in",width=10,height=7.48,res=600)
ggplot(dat_tree_significantUnique,aes(x=min_art))+
  geom_histogram(binwidth = 0.5)+
  xlab(label="Minimal number of features\n per archetype")+
  ylab(label="Counts")+
  theme_linedraw()+theme(legend.position = "none")+
  removeGridX()+
  theme(axis.title.x=element_text(size=36,family="Times",color="black",face="bold"))+
  theme(axis.text.y=element_text(size=30,family="Times",color="black"))+
  theme(axis.title.y=element_text(size=36,family="Times",color="black",face="bold",margin=margin(t=0,r=24,b=0,l=0)))+
  theme(axis.text.x=element_text(size=30,family="Times",color="black",margin=margin(t=0,r=0,b=0,l=0)))+
  scale_y_continuous(limits=c(0,12),breaks=c(0,5,10),expand=c(0,0))
dev.off()
