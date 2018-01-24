function  do_experiment_with_correlation( Data )
%DO_EXPERIMENT_WITH_CORRELATION Summary of this function goes here
%   Detailed explanation goes here
%% Extract all variables from Data
strNames = fieldnames(Data);
for i = 1:length(strNames), eval([strNames{i} '= Data.' strNames{i} ';']); end
%%
num=0;
sign=1;
accuracy_ours=zeros(5,1);
X_range=zeros(2,1);
%change correlation factor
mkdir (savePath);
file_path=[savePath,'\'];
for i=0.5:0.05:0.7
    sigma=3;% noise variance sigma
    scale=i;% correlation factor
    unsamrate=0;% ratio of irrelevant samples
    percentageD1=0.2;% prior knowledge W1
    percentageD2=0.2;% prior knowledge W2
    percentageD12=0.1;% prior knowledge W12
    temp_ours=0;
    [Data1,Data2,prelabel1,prelabel2]=Generate_data(n1,n2,nF1,nF2,cpnum,sigma,scale,unsamrate,file_path);
    if sign
    [indPT1,valPT1,indPM1]=produce_random_prior_D1(n1,n2,nF1,nF2,cpnum,percentageD1,file_path);
    [indPT2,valPT2,indPM2]=produce_random_prior_D2(n1,n2,nF1,nF2,cpnum,percentageD2,file_path);
    [prior_X]=produce_random_prior_D12(n1,n2,nF1,nF2,cpnum,percentageD12,file_path);
    sign=0;
    end
    file_path_name=[file_path,'noise',num2str(sigma),'_scale',num2str(scale),'_unsamrate',num2str(unsamrate),'_prior_D1_',num2str(percentageD1),'_prior_D2_',num2str(percentageD2),'_prior_D12_',num2str(percentageD12)];
    [c_ours]=do_HOGMMNC(lambda,Data1,Data2,indPT1,valPT1,indPT2,valPT2,prior_X,prelabel1,prelabel2,file_path_name);
     for j=1:3
         temp_ours=temp_ours+c_ours(j,j);
     end
     num=num+1;
     accuracy_ours(num)=temp_ours/nF1;
     X_range(num)=i;
end
Accuracy.accuracy_ours=accuracy_ours;
Accuracy.X_range=X_range;
save_path=[file_path,'accuracy.mat'];
save(save_path,'Accuracy');
plot_result( Accuracy,mark,file_path );
end

