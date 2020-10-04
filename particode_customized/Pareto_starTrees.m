function Pareto_starTrees()
global abortAfterPval;
abortAfterPval=1;
parfor i=1:100
	tic;
	dat=strcat('dat_null',num2str(i));
	Mophology = dlmread(strcat('../Fig2/SimTraitsTrees/',dat),',');
    output_name=strcat('../Fig2/Star_tree_results/Analysis_null',num2str(i));
	[arc, arcOrig, pc,errs, pval] = ParTI_with_suggestion(Mophology, 1, 8, [],[], [], [], [], [], 0.2, output_name);
    T=table(i,pval);
    writetable(T,strcat(output_name,'p'));
    close all hidden;
    toc;
end
