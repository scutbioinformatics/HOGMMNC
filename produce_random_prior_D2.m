function [indPT2,valPT2,indPM2]=produce_random_prior_D2(n1,n2,nF1,nF2,cpnum,percentage,file_path)
%Data2 prior
% Generate number of prior in every common pattern 
N=0;
N=floor(nF2*percentage/cpnum);
avenumD2=floor(nF2/cpnum);
% Generate prior matrix of Data1
indD2=zeros(N,cpnum);
indPM2=zeros(nF2,nF2);
for i=1:cpnum
    if i~=cpnum
        data2block=(i-1)*avenumD2+1:i*avenumD2;
    else
        data2block=(i-1)*avenumD2+1:nF2;
    end
K=randperm(length(data2block));
indD2(1:N,i)=data2block(K(1:N))'; 
end
for i=1:cpnum
    for j=1:N
        for k=j+1:N
            indPM2(indD2(j,i),indD2(k,i))=1;
            indPM2(indD2(k,i),indD2(j,i))=1;
        end
    end
end
for i=1:nF2
    indPM2(i,i)=0;
end
figure(4)
imagesc(indPM2);
str=[file_path,'prior_D2_',num2str(percentage),'.jpg'];
saveas(gcf,str);
% Generate Laplace tensor of Data2
indPT2=zeros(nF2,3);
valPT2=zeros(nF2,1);
valD=zeros(nF1*nF2,1);
count=0;
for i=1:nF2
    for j=i+1:nF2
        for k=j+1:nF2
            if indPM2(i,j)==1 && indPM2(i,k)==1 && indPM2(j,k)==1
                for t=1:nF1
                    count=count+1;
                    indPT2(count,1)=i+(t-1)*nF2;
                    indPT2(count,2)=j+(t-1)*nF2;
                    indPT2(count,3)=k+(t-1)*nF2;
                    valPT2(count,1)=-1;
                    valD((i+(t-1)*nF2),1)=valD((i+(t-1)*nF2),1)+1;
                    count=count+1;
                    indPT2(count,1)=i+(t-1)*nF2;
                    indPT2(count,2)=k+(t-1)*nF2;
                    indPT2(count,3)=j+(t-1)*nF2; 
                    valPT2(count,1)=-1;
                    valD((i+(t-1)*nF2),1)=valD((i+(t-1)*nF2),1)+1;
                    count=count+1;
                    indPT2(count,1)=j+(t-1)*nF2;
                    indPT2(count,2)=i+(t-1)*nF2;
                    indPT2(count,3)=k+(t-1)*nF2; 
                    valPT2(count,1)=-1;
                    valD((j+(t-1)*nF2),1)=valD((j+(t-1)*nF2),1)+1;                   
                    count=count+1;
                    indPT2(count,1)=j+(t-1)*nF2;
                    indPT2(count,2)=k+(t-1)*nF2;
                    indPT2(count,3)=i+(t-1)*nF2;   
                    valPT2(count,1)=-1;
                    valD((j+(t-1)*nF2),1)=valD((j+(t-1)*nF2),1)+1;                    
                    count=count+1;
                    indPT2(count,1)=k+(t-1)*nF2;
                    indPT2(count,2)=i+(t-1)*nF2;
                    indPT2(count,3)=j+(t-1)*nF2;
                    valPT2(count,1)=-1;
                    valD((k+(t-1)*nF2),1)=valD((k+(t-1)*nF2),1)+1;                    
                    count=count+1;
                    indPT2(count,1)=k+(t-1)*nF2;
                    indPT2(count,2)=j+(t-1)*nF2;
                    indPT2(count,3)=i+(t-1)*nF2;
                    valPT2(count,1)=-1;
                    valD((k+(t-1)*nF2),1)=valD((k+(t-1)*nF2),1)+1;                     
                end
            end
        end
    end
end
for i=1:nF1*nF2
    count=count+1;
    indPT2(count,1)=i;
    indPT2(count,2)=i;
    indPT2(count,3)=i;
    valPT2(count,1)=valD(i,1);
end
clear  N indD2 K data2block