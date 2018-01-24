
clear all; close all; clc;
disp('************************ simulated experiment comparision between several methods ************************'); disp(' ');

%%

%size of sample1 and sample2
Data.n1=60;
Data.n2=60;
%size of features in sample 1
Data.nF1=130;
%size of features in sample 2
Data.nF2=100;
%number of common pattern 
Data.cpnum=3;
%value of lambda 
Data.lambda=[0.2;0.4];
%size of data1 and data2
Data.Data1=zeros(Data.n1,Data.nF1);
Data.Data2=zeros(Data.n2,Data.nF2);
Data.savePath='';
condition=3;% 1 represents noise experiment, 2 is the correlation factor, 3 is irrelevant samples
switch condition
    case 1
        Data.savePath='result_file_noise';
        Data.mark=1;
        do_experiment_with_noise(Data);
    case 2
        Data.savePath='result_file_correlation';
        Data.mark=2;
        do_experiment_with_correlation(Data);
    case 3
        Data.savePath='result_file_outlier';
        Data.mark=3;
        do_experiment_with_outlier(Data);
    otherwise
end