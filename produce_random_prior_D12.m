function [prior_X]=produce_random_prior_D12(n1,n2,nF1,nF2,cpnum,percentage,file_path)
%D12 prior
N=floor((min(nF1,nF2)/cpnum)*percentage);
temp1=floor(nF1/cpnum);
temp2=floor(nF2/cpnum);
indD12=zeros(N,2);
for i=1:cpnum
    if i~=cpnum
        data12block1=(i-1)*temp1+1:i*temp1;
    else
        data12block1=(i-1)*temp1+1:nF1;
    end
    K=randperm(length(data12block1));
    indD12((i-1)*N+1:i*N,1)=data12block1(K(1:N))';
    if i~=cpnum
        data12block1=(i-1)*temp2+1:i*temp2;
    else
        data12block1=(i-1)*temp2+1:nF2;
    end       
    K=randperm(length(data12block1));
    indD12((i-1)*N+1:i*N,2)=data12block1(K(1:N))'; 
end
prior_X=zeros(nF1,nF2);
for i=1:3*N
    prior_X(indD12(i,1),indD12(i,2))=1;
end
prior_X=prior_X';
figure(5)
imagesc(prior_X);
str=[file_path,'prior_D12_',num2str(percentage),'.jpg'];
saveas(gcf,str);
