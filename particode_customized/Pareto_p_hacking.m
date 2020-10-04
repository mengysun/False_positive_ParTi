function Pareto_p_hacking()
global ForceNArchetypes;
global abortAfterPval; 
ForceNArchetypes=3;
abortAfterPval=1;
files=dir(strcat('../Fig4/Simulate_traits/','dat*'));
%loop over files
L=length(files);
for j=1:L
	tic
    Mophology = dlmread(strcat('../Fig4/Simulate_traits/',files(j).name), ',');
    p_array=[];
    output_file=strcat('result_PCHA',files(j).name);
	[arc, arcOrig, pc,errs, pval] = ParTI(Mophology, 5, 5, [],[], [], [], [], [], 0.2, 'output');
    p_array=[p_array;pval];
    T=table(p_array);
    writetable(T,strcat('../Fig4/results/',output_file));
    toc
    close all hidden;              
end
