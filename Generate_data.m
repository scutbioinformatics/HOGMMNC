function [Data1,Data2,prelabel1,prelabel2]=Generate_data(n1,n2,nF1,nF2,cpnum,sigma,scale,unsamrate,file_path)
%% Initialize data
%size of data1 and data2
Data1=zeros(n1,nF1);
Data2=zeros(n2,nF2);
avenumD1=floor(nF1/cpnum);
avenumD2=floor(nF2/cpnum);
%create data1
Data1(1:20,avenumD1*(1-1)+1:avenumD1*1)=41;
Data1(21:40,avenumD1*(1-1)+1:avenumD1*1)=37;
Data1(41:60,avenumD1*(1-1)+1:avenumD1*1)=43;
Data1(1:60,avenumD1*(2-1)+1:avenumD1*2)=47;
Data1(1:30,avenumD1*(3-1)+1:nF1)=49;
Data1(31:60,avenumD1*(3-1)+1:nF1)=51;
Data1=Data1+randn(n1,nF1)*2;
%create data2
Data2(1:20,avenumD2*(1-1)+1:avenumD2*1)=41;
Data2(21:40,avenumD2*(1-1)+1:avenumD2*1)=37;
Data2(41:60,avenumD2*(1-1)+1:avenumD2*1)=43;
Data2(1:60,avenumD2*(2-1)+1:avenumD2*2)=47;
Data2(1:30,avenumD2*(3-1)+1:nF2)=49;
Data2(31:60,avenumD2*(3-1)+1:nF2)=51;
%show figure
figure(1)
imagesc(Data1)
str1=[file_path,'noise',num2str(sigma),'_scale',num2str(scale),'_unsamrate',num2str(unsamrate),'_data1.jpg'];
saveas(gcf,str1);
clear val
%% Generate data with different noise
Fnoise2=normrnd(0,sigma,n2,nF2);
Data2=Data2+Fnoise2;
%% Generate data with different correlation factor
Data2(:,:)=Data2(:,:)*scale;
%% Insert irrelevant sample
  unsamnum=floor(unsamrate*n2);
  temp=1:n2;
  K=randperm(length(temp));
  x=temp(K(1:unsamnum))'; 
  Data2(x,:)=20*rand(unsamnum,nF2);
%% initialize ground ture
avenumD1=floor(nF1/cpnum);
avenumD2=floor(nF2/cpnum);
for i=1:cpnum
    if i~=cpnum
       prelabel1(avenumD1*(i-1)+1:avenumD1*i,1)=i;
    else
       prelabel1(avenumD1*(i-1)+1:nF1,1)=i;
    end
end
for i=1:cpnum
    if i~=cpnum
       prelabel2(avenumD2*(i-1)+1:avenumD2*i,1)=i;
    else
       prelabel2(avenumD2*(i-1)+1:nF2,1)=i;
    end
end
%%
figure(2)
imagesc(Data2)
str2=[file_path,'noise',num2str(sigma),'_scale',num2str(scale),'_unsamrate',num2str(unsamrate),'_data2.jpg'];
saveas(gcf,str2);