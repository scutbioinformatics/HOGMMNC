function [indPT1,valPT1,indPM1]=produce_random_prior_D1(n1,n2,nF1,nF2,cpnum,percentage,file_path)
%Data1 prior
% Generate number of prior in every common pattern 
N=0;
N=floor(nF1*percentage/cpnum);
avenumD1=floor(nF1/cpnum);
% Generate prior matrix of Data1
indD1=zeros(N,cpnum);
indPM1=zeros(nF1,nF1);
for i=1:cpnum
    if i~=cpnum
        data1block=(i-1)*avenumD1+1:i*avenumD1;
    else
        data1block=(i-1)*avenumD1+1:nF1;
    end
K=randperm(length(data1block));
indD1(1:N,i)=data1block(K(1:N))'; 
end
for i=1:cpnum
    for j=1:N
        for k=j+1:N
            indPM1(indD1(j,i),indD1(k,i))=1;
            indPM1(indD1(k,i),indD1(j,i))=1;
        end
    end
end
for i=1:nF1
    indPM1(i,i)=0;
end
figure(3)
imagesc(indPM1);
str=[file_path,'prior_D1_',num2str(percentage),'.jpg'];
saveas(gcf,str);
% Generate Laplace tensor of Data1
indPT1=zeros(nF1,3);
valPT1=zeros(nF1,1);
valD=zeros(nF1*nF2,1);
count=0;
for i=1:nF1
    for j=i+1:nF1
        for k=j+1:nF1
            if indPM1(i,j)==1 && indPM1(i,k)==1 && indPM1(j,k)==1
                for t=1:nF2
                    count=count+1;
                    indPT1(count,1)=t+(i-1)*nF2;
                    indPT1(count,2)=t+(j-1)*nF2;
                    indPT1(count,3)=t+(k-1)*nF2;
                    valPT1(count,1)=-1;
                    valD((t+(i-1)*nF2),1)=valD((t+(i-1)*nF2),1)+1;
                    count=count+1;
                    indPT1(count,1)=t+(i-1)*nF2;
                    indPT1(count,2)=t+(k-1)*nF2;
                    indPT1(count,3)=t+(j-1)*nF2; 
                    valPT1(count,1)=-1;
                    valD((t+(i-1)*nF2),1)=valD((t+(i-1)*nF2),1)+1;
                    count=count+1;
                    indPT1(count,1)=t+(j-1)*nF2;
                    indPT1(count,2)=t+(i-1)*nF2;
                    indPT1(count,3)=t+(k-1)*nF2; 
                    valPT1(count,1)=-1;
                    valD((t+(j-1)*nF2),1)=valD((t+(j-1)*nF2),1)+1;                   
                    count=count+1;
                    indPT1(count,1)=t+(j-1)*nF2;
                    indPT1(count,2)=t+(k-1)*nF2;
                    indPT1(count,3)=t+(i-1)*nF2;   
                    valPT1(count,1)=-1;
                    valD((t+(j-1)*nF2),1)=valD((t+(j-1)*nF2),1)+1;                    
                    count=count+1;
                    indPT1(count,1)=t+(k-1)*nF2;
                    indPT1(count,2)=t+(i-1)*nF2;
                    indPT1(count,3)=t+(j-1)*nF2;
                    valPT1(count,1)=-1;
                    valD((t+(k-1)*nF2),1)=valD((t+(k-1)*nF2),1)+1;                    
                    count=count+1;
                    indPT1(count,1)=t+(k-1)*nF2;
                    indPT1(count,2)=t+(j-1)*nF2;
                    indPT1(count,3)=t+(i-1)*nF2;
                    valPT1(count,1)=-1;
                    valD((t+(k-1)*nF2),1)=valD((t+(k-1)*nF2),1)+1;                     
                end
            end
        end
    end
end
for i=1:nF1*nF2
    count=count+1;
    indPT1(count,1)=i;
    indPT1(count,2)=i;
    indPT1(count,3)=i;
    valPT1(count,1)=valD(i,1);
end
clear  N indD1 K data1block