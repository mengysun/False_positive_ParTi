tic
global ForceNArchetypes;
ForceNArchetypes=3;
geneExpression = dlmread('../Fig1/Data_preprocessing/dat_for_wildtype', ',');
fid = fopen('../Fig1/Data_preprocessing/gene_id_sdNorm_for_wildtype');
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
     [], 0, contAttrNames, contAttr, GOcat2Genes, 0.05, '../Fig1/Fig1f/Yeast_wildtype_results');
T=table(pval);
writetable(T,'../Fig1/Fig1f/Yeast_wildtype_results_p_val');
timeElapsed = toc
writematrix(arc,"../Fig1/PC_correlations_between_d_and_f/arcWildtype.csv")
writematrix(arcOrig,"../Fig1/PC_correlations_between_d_and_f/arcWiltype_origin.csv")
writematrix(pc,"../Fig1/PC_correlations_between_d_and_f/pc_wildtype.csv")