library(dplyr)
library(filesstrings)
library(ggplot2)
library(gridExtra)
library(grid)
library(ggExtra)
finished<-list.files("./results/")
finished<-gsub("result_PCHA","",finished)
finished<-gsub(".txt","",finished)
dat_index<-numeric(length(finished))
p<-numeric(length(finished))
dat_type<-character(length(finished))
filter_vec<-character(length(finished))
cutoff<-numeric(length(finished))
for(i in 1:length(finished)){
  file_name<-paste("result_PCHA",finished[i],".txt",sep="")
  file_name<-paste("./results",file_name,sep="/")
  dat_tmp<-read.table(file=file_name,header=TRUE,sep="\t")
  dat_infor<-unlist(strsplit(finished[i],split = "_"))
  p_tmp<-as.numeric(as.character(dat_tmp[1,1]))
  dat_type_tmp<-dat_infor[2]
  dat_index_tmp<-as.numeric(dat_infor[3])
  filter_tmp<-dat_infor[4]
  cutoff_tmp<-(as.numeric(dat_infor[5])-1)*10
  dat_index[i]<-dat_index_tmp
  dat_type[i]<-dat_type_tmp
  filter_vec[i]<-filter_tmp
  cutoff[i]<-cutoff_tmp
  p[i]<-p_tmp
}
dat_all<-data.frame(dat_index,dat_type,filter_vec,cutoff,p)
sum(dat_all$p<=0.05)
hist(dat_all$p)
dat_raw<-dat_all%>%
  filter(dat_type=="raw")%>%
  filter(cutoff==0)%>%
  filter(filter_vec=="mean")
sum(dat_raw$p<=0.05)
6/100
dat_all$significant<-(dat_all$p<=0.05)
dat_all_5<-dat_all%>%
  filter(cutoff==0|cutoff==20|cutoff==40|cutoff==60|cutoff==80)
dat_all_2<-dat_all%>%
  filter(cutoff==0|cutoff==50)
dat_p_hacking<-dat_all%>%
  group_by(dat_index)%>%
  dplyr::summarise(has_significant=sum(significant))
sum(dat_p_hacking$has_significant>0)
dat_p_hacking5<-dat_all_5%>%
  group_by(dat_index)%>%
  dplyr::summarise(has_significant=sum(significant))
sum(dat_p_hacking5$has_significant>0)
dat_p_hacking2<-dat_all_2%>%
  group_by(dat_index)%>%
  dplyr::summarise(has_significant=sum(significant))
sum(dat_p_hacking2$has_significant>0)
#(10,5,2),(99,91,50)
sum(dat_all$p[dat_all$filter_vec=="sd"]<=0.05)
bar_dat<-data.frame(c("Without p-hacking","(2 cutoffs)","(5 cutoffs)","(10 cutoffs)"),c(13/100,50/100,91/100,98/100))
names(bar_dat)<-c("Condition","Fraction_significant")
bar_dat$Condition<-factor(bar_dat$Condition,levels=c("Without p-hacking","(2 cutoffs)","(5 cutoffs)","(10 cutoffs)"))
png(filename="Fig4b.png",units="in",width=15,height=7.48,res=600)
ggplot(data=bar_dat,aes(x=Condition,y=Fraction_significant))+
  geom_bar(stat = "identity",alpha=0.7)+
  geom_hline(yintercept = 0.05,color="black",linetype="dotted")+
  xlab(label="")+
  ylab(label="Probablity of finding significance")+
  theme_linedraw()+theme(legend.position = "none")+
  # theme(legend.title=element_blank())+
  # theme(legend.text=element_text(size=24,family="TT Arial",color="black",face="bold"))+
  # theme(legend.direction = "horizontal")+
  theme(legend.margin=margin(-0.5))+
  removeGridX()+
  theme(axis.title.x=element_blank())+
  theme(axis.text.y=element_text(size=25,family="Times",color="black"))+
  theme(axis.title.y=element_text(size=30,family="Times",color="black",face="bold",margin=margin(t=0,r=24,b=0,l=0)))+
  theme(axis.text.x=element_text(size=25,family="Times",color="black",face="bold",margin=margin(t=24,r=0,b=24,l=0)))+
  scale_y_continuous(limits=c(0,1.1),breaks=c(0,0.25,0.5,0.75,1),expand=c(0,0))
dev.off()
1-(0.9)^5
