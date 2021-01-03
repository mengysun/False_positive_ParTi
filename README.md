# False_positive_ParTi
This repository contains all codes to reproduce the manuscript "Rampant false detection of adaptive phenotypic optimization by ParTI-based Pareto front inference", start from raw data. Most of the necessary data are uploaded, except for the file "deleteome_all_mutants_controls.txt" used in Fig.1, since it is too large. This data should be downloaded from the website: http://deleteome.holstegelab.nl/

The "particode_customized" folder contains the ParTi codes, which are essentially the same as the "particode" in https://www.weizmann.ac.il/mcb/UriAlon/download/ParTI, except for the codes and data necessary to produce the figures and tables in the manuscript. These codes should be run on matlab19. The example codes and data in particode are deleted due to the limit of file size but can be easily downloaded from the above website. The codes added in this folder are:

ParTI_with_suggestion.m and findArchetypes_with_suggestion.m (these codes automatically force the number of archetypes to be the suggested number of archetypes from the "elbow" method in ParTi.These codes are needed because I have to run ParTI on a large number of simulated datasets to estimate the false positive rate.)

Pareto_Deletion_lines.m (inferred Pareto-front from yeast deletion strains, Fig.1) 
Pareto_wildtype_technicalreplicates.m (inferred Pareto-front from wildtype yeast technical replicates, Fig.1) 
Pareto_lowfit_deletionlines.m (inferred Pareto-front from low fit deletion lines, Fig.1)

Pareto_phylogenyTrees.m (inferred Pareto-front from simulated datasets with phylogenetic structures, Fig.2) 
Pareto_starTrees.m and Pareto_starTrees_unequal_branch.m (inferred Pareto-front from simulated datasets without tree strutures(star tree),Fig.2)

Pareto_pop.m (inferred Pareto-front from simulated human populations) 
Pareto_Fig3.m (run the Pareto_pop.m in datasets simulated using different demographic parameters)

Pareto_p_hacking.m (Fig.4)

*Yeast_gmt folder contains the GO term information used in Fig.1
