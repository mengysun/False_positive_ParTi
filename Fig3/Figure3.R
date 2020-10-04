library(dplyr)
library(ggplot2)
library(gridExtra)
library(grid)
library(ggExtra)
Getting_statistics<-function(dir_name){
  p_statistics<-numeric(100)
  archetype_statistics<-logical(100)
  for(i in 1:100){
    p_file<-paste(dir_name,"Analysis",i,"p.txt",sep="")
    significant_file<-paste(dir_name,"Analysis",i,"_discrete_significant.csv",sep="")
    p_tab<-read.table(p_file,sep=",",header=TRUE)
    significant_tab<-read.csv(significant_file,header=TRUE)
    p_statistics[i]<-as.numeric(as.character(p_tab$pval))
    enrich_features<-as.numeric(as.character(significant_tab[,2]))
    archetypes<-unique(as.numeric(as.character((significant_tab[,1]))))
    if(length(enrich_features)==3&length(unique(enrich_features))==3&length(archetypes)==3){
      archetype_statistics[i]<-TRUE
    }
  }
  dat<-data.frame(p_statistics,archetype_statistics)
  return(dat)
}
Multiple_chr<-Getting_statistics("./Population_simulation/MN/")
Single_chr<-Getting_statistics("./Population_simulation/SN/")
Single_chr_high_migration<-Getting_statistics("./Population_simulation/SHM/")
Single_chr_low_migration<-Getting_statistics("./Population_simulation/SLM/")
SingleChr_high_recombination<-Getting_statistics("./Population_simulation/SHR/")
sum(Multiple_chr$p_statistics<=0.05)
sum(Single_chr$p_statistics<=0.05)
sum(Single_chr_high_migration$p_statistics<=0.05)
sum(Single_chr_low_migration$p_statistics<=0.05)
sum(SingleChr_high_recombination$p_statistics<=0.05)
#"SN","SHR","MN","SHM","SLM"
bar_dat<-data.frame(c("SN","SHR","MN","SHM","SLM"),c(99/100,97/100,98/100,0,97/100))
names(bar_dat)<-c("Condition","Fraction_significant")
bar_dat$Condition<-factor(bar_dat$Condition,levels=c("SN","SHR","MN","SHM","SLM"))
png(filename="Fig3b.png",units="in",width=10,height=7.48,res=600)
ggplot(data=bar_dat,aes(x=Condition,y=Fraction_significant))+
  geom_bar(stat = "identity",alpha=0.7)+
  geom_hline(yintercept = 0.05,color="black",linetype="dotted")+
  xlab(label="")+
  ylab(label="Fraction of significance")+
  theme_linedraw()+theme(legend.position = "none")+
  theme(legend.title=element_blank())+
  theme(legend.text=element_text(size=15,family="times",color="black",face="bold"))+
  # theme(legend.title=element_blank())+
  # theme(legend.text=element_text(size=24,family="TT Arial",color="black",face="bold"))+
  # theme(legend.direction = "horizontal")+
  theme(legend.margin=margin(-0.5))+
  removeGridX()+
  theme(axis.title.x=element_blank())+
  theme(axis.text.y=element_text(size=30,family="Times",color="black"))+
  theme(axis.title.y=element_text(size=36,family="Times",color="black",face="bold",margin=margin(t=0,r=24,b=0,l=0)))+
  theme(axis.text.x=element_text(size=30,family="Times",color="black"))+
  #theme(axis.text.x=element_text(size=36,family="Times",color="black",face="bold",margin=margin(t=24,r=0,b=24,l=0)))+
  scale_y_continuous(limits=c(0,1.05),breaks=c(0,0.25,0.5,0.75,1.00),expand=c(0,0))
dev.off()
sum(Multiple_chr$archetype_statistics)
sum(Single_chr$archetype_statistics)
sum(Single_chr_high_migration$archetype_statistics)
sum(Single_chr_low_migration$archetype_statistics)
sum(SingleChr_high_recombination$archetype_statistics)
hist(Single_chr_high_migration$p_statistics)
