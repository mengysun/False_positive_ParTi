function pop_c_traits(d,prefix,n)
my_files=dir(strcat(d,prefix,'*'));
for i=1:size(my_files,1)
    rng(i);
    data=readmatrix(strcat(d,my_files(i).name));
    allele_trait_map=normrnd(0,1,size(data,1),n);
    traits_mat=(data')*allele_trait_map;
    output_name=strcat(d,num2str(n),'_',my_files(i).name);
    csvwrite(output_name,traits_mat);
end
