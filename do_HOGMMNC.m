function [c_ours]=do_HOGMMNC(lambda,Data1,Data2,indPT1,valPT1,indPT2,valPT2,prior_X,prelabel1,prelabel2,file_path_name)
%% insert matlab toolbox
addpath('ann_mwrapper');
addpath('mex');
%% Generate data
%data
P1=Data1;
P2=Data2;
[n1,nF1]=size(Data1);
[n2,nF2]=size(Data2);

%% 3rd Order Tensor
% This part is taken from Duchenne's code
nT = nF1*nF2; % # of triangles in graph 1
t1=floor(rand(3,nT)*nF1);
while 1
  probFound=false;
  for i=1:3
    ind=(t1(i,:)==t1(1+mod(i,3),:));
    if(nnz(ind)~=0)
      t1(i,ind)=floor(rand(1,nnz(ind))*nF1);
      probFound=true;
    end
  end
  if(~probFound)
    break;
  end
end

%generate features
t1=int32(t1);
[feat1,feat2] = mexComputeFeature_angle_distance(P1,P2,int32(t1),'simple');
%normalize features
maxfeat14=max(feat1(4,:));
feat1(4,:)=feat1(4,:)/maxfeat14;
maxfeat15=max(feat1(5,:));
feat1(5,:)=feat1(5,:)/maxfeat15;
maxfeat16=max(feat1(6,:));
feat1(6,:)=feat1(6,:)/maxfeat16;
maxfeat24=max(feat2(4,:));
feat2(4,:)=feat2(4,:)/maxfeat24;
maxfeat25=max(feat2(5,:));
feat2(5,:)=feat2(5,:)/maxfeat25;
maxfeat26=max(feat2(6,:));
feat2(6,:)=feat2(6,:)/maxfeat26;
%number of nearest neighbors used for each triangle (results can be bad if too low)
nNN=1000;

%find the nearest neighbors
[inds, dists] = annquery(feat2, feat1, nNN, 'eps', 10);

%build the tensor
[i j k]=ind2sub([nF2,nF2,nF2],inds);
tmp=repmat(1:nT,nNN,1);
indH3 = t1(:,tmp(:))'*nF2 + [k(:)-1 j(:)-1 i(:)-1];
valH3 =1+exp(-dists(:)/mean(dists(:)));

%initiatialize X
X=1/nF2*ones(nF2,nF1);
[rows,cols]=find(prior_X>0);
for i=1:size(rows)
    X(rows(i),cols(i))=1;
end
%power iteration
[X_ours, score]=tensorMatching_prior_alpha(X,[],[],[],[],indH3,valH3,indPT1,valPT1,indPT2,valPT2,200,1,2,lambda);

% draw
[tmp1 match_ours] = max(X_ours);
afterlabel_ours=prelabel2(match_ours);
% if 1
figure(7);
imagesc(X_ours');
str2=[file_path_name,'_lambda1_',num2str(lambda(1,1)),'_lambda2_',num2str(lambda(2,1)),'_X_ours','.jpg'];
saveas(gcf,str2);
c_ours=confusionmat(prelabel1,afterlabel_ours);







