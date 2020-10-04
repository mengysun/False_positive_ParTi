tic
geneExpression = dlmread('../Fig1/Data_preprocessing/dat_for_deleteComplete', ',');
fid = fopen('../Fig1/Data_preprocessing/gene_id_sdNorm_for_deleteComplete');
geneNames = textscan(fid,'%s');
fclose(fid);
geneNames = geneNames{1};
contAttrNames = [];
contAttr = [];
[GOExpression,GONames,~,GOcat2Genes] = MakeGOMatrix(geneExpression, geneNames, ...
                {'./Yeast_gmt/Saccharomyces_cerevisiae_S288c_GSEA_GO_sets_all_ids_April_2015.gmt'}, ...
                10);
GOcat2Genes=[zeros(size(GOcat2Genes,1),size(contAttr,2)),GOcat2Genes];
contAttrNames = [contAttrNames, GONames];
contAttr = [contAttr, GOExpression];
contAttrNames = regexprep(contAttrNames, '_', ' ');
[arc, arcOrig, pc, errs, pval] = ParTI(geneExpression, 1, 5, [], ...
     [], 0, contAttrNames, contAttr, GOcat2Genes, 0.05, '../Fig1/Fig1d/Yeast_deleteComplete_results');
T=table(pval);
writetable(T,'../Fig1/Fig1d/Yeast_deleteComplete_results_p');
writematrix(arcOrig,"../Fig1/PC_correlations_between_d_and_f/arcComplete_origin.csv")
writematrix(arc,"../Fig1/PC_correlations_between_d_and_f/arcComplete.csv")
writematrix(pc,"../Fig1/PC_correlations_between_d_and_f/pc_complete.csv")
timeElapsed = toc