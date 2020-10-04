function Pareto_phylogenyTrees()
parfor i=1:100
	tic;
	dat=strcat('dat',num2str(i));
	art=strcat('art',num2str(i));
	Mophology = dlmread(strcat('../Fig2/SimTraitsTrees/',dat),',');
	discrAttr = dlmread(strcat('../Fig2/SimTraitsTrees/',art),',');
	discrAttrNames =num2cell(1:100);
	output_name=strcat('../Fig2/Phylogenetic_results/Analysis',num2str(i));
	[arc, arcOrig, pc,errs, pval] = ParTI_with_suggestion(Mophology, 1, 8, discrAttrNames,discrAttr, [], [], [], [], 0.2, output_name);
    T=table(i,pval);
    writetable(T,strcat(output_name,'p'));
    close all hidden;
    toc;
end




