function Pareto_pop(prefix,dir)
global ForceNArchetypes;
global abortAfterPval; 
for i=1:100
    ForceNArchetypes=3;
    abortAfterPval=1;
	tic;
	dat=strcat(prefix,num2str(i),"_phenotypes");
	Mophology = dlmread(strcat(dir,dat),',');
	output_name=strcat(dir,'Analysis',num2str(i));
    discrAttr = dlmread('../Fig3/Population_simulation/Pop_label',',');
	discrAttrNames =num2cell(1:3);
	[arc, arcOrig, pc,errs, pval] = ParTI(Mophology, 1, 8, discrAttrNames,discrAttr, [], [], [], [], 0.2, output_name);
    T=table(i,pval);
    writetable(T,strcat(output_name,'p'));
    close all hidden;
    toc;
end




