function Pareto_starTrees_unequal_branch()
global abortAfterPval;
abortAfterPval=1;
parfor i=1:100
	tic;
	dat=strcat('../Fig2/SimTraitsTrees/dat_unequal_uniform_large_',num2str(i));
	Mophology = dlmread(dat,',');
	output_name=strcat('../Fig2/Star_tree_unequal_branch_results/Analysis_uniform_large',num2str(i));
	[arc, arcOrig, pc,errs, pval] = ParTI_with_suggestion(Mophology, 1, 8, [],[], [], [], [], [], 0.2, output_name);
    T=table(i,pval);
    writetable(T,strcat(output_name,'p'));
    close all hidden;
    toc;
end
