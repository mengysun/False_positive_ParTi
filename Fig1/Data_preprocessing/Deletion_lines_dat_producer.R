library(dplyr)
#read in raw&formatted data
dat_raw<-read.table(file="deleteome_all_mutants_controls.txt",sep="\t",header=TRUE,quote="",stringsAsFactors=F)
dat_raw_1<-read.table(file="dat_all_exp1.csv",sep=",",header=FALSE)
dat_raw_2<-read.table(file="dat_all_exp2.csv",sep=",",header=FALSE)

#filter data from genes with multiple records
gene_symbols<-as.character(dat_raw$geneSymbol[2:6183])
gene_systematic<-as.character(dat_raw$systematicName[2:6183])
unique_index<-logical(length(gene_systematic))
for(i in 1:6182){
  if(sum(gene_systematic==gene_systematic[i])==1){
    unique_index[i]<-TRUE
  }
}
dat_raw_1<-dat_raw_1[,unique_index]
gene_symbols<-gene_symbols[unique_index]
gene_systematic<-gene_systematic[unique_index]
dat_raw_2<-dat_raw_2[,unique_index]

#transform the data from log space to linear space (for deletion lines) using M values and A values
dat_raw_3<-dat_raw_2+2*dat_raw_1
dat_raw_original<-2^(dat_raw_3/2)
#normalization the data by total expression levels of all genes in each line of the transformed data
total_expression<-rowSums(dat_raw_original)
dat_raw_normalized<-dat_raw_original
for(i in 1:1484){
  dat_raw_normalized[i,]<-dat_raw_original[i,]/total_expression[i]
}

#filter out lowly expressed genes, producing a table for genes retained after filtering
percent_mean_Expression<-colMeans(dat_raw_normalized)
dat_sd_normalized<-dat_raw_normalized[,percent_mean_Expression>(7.72*10^-4)]
gene_systematic_forSDNorm<-gene_systematic[percent_mean_Expression>(7.72*10^-4)]
gene_id<-read.table(file="gene_id_version.txt",sep="\t",header=TRUE)
gene_systematic_fromID<-unique(as.character(gene_id$Gene.stable.ID))
gene_id_fromID<-unique(as.character(gene_id$NCBI.gene.ID))
rm_multiple_systematic<-match(gene_systematic_fromID,gene_id$Gene.stable.ID)
gene_id<-gene_id[rm_multiple_systematic,]
rm_multiple_id<-match(gene_id_fromID,gene_id$NCBI.gene.ID)
gene_id<-gene_id[rm_multiple_id,]
gene_id_index<-match(gene_systematic_forSDNorm,gene_id$Gene.stable.ID)
gene_id_write<-as.character(gene_id$NCBI.gene.ID[gene_id_index])
gene_id_write[is.na(gene_id_write)]<-gene_systematic_forSDNorm[is.na(gene_id_write)]
write.table(gene_id_write,"gene_id_sdNorm_for_deleteComplete",col.names = FALSE,row.names=FALSE,quote=FALSE)

#produce the z-score transformed data
mean_Exp_normalized<-colMeans(dat_sd_normalized)
for(i in 1:248){
  dat_sd_normalized[,i]<-(dat_sd_normalized[,i]-mean_Exp_normalized[i])/sd(dat_sd_normalized[,i])
}
write.table(dat_sd_normalized,file="dat_for_deleteComplete",sep=",",row.names=FALSE,col.names=FALSE)

