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
flag=2;
[t1,t2,nT1,nT2] = Generate_tuples(P1,P2,nF1,nF2,flag);%1:Oliver,2:ours,3:ochs

%generate features
t1=int32(t1);
t2=int32(t2);
[feat11,feat22] = mexComputeFeature_angle_distance_sample(P1,P2,int32(t1),int32(t2),'simple');
feat1=feat11(1:3,:);%angle information
feat2=feat22(1:3,:);%angle information
% feat1=feat11(4:6,:);%distance information
% feat2=feat22(4:6,:);%distance information
%number of nearest neighbors used for each triangle (results can be bad if too low)
nNN=1000;

%find the nearest neighbors
clear inds
[inds, dists] = annquery(feat2, feat1, nNN, 'eps', 10);

%build the tensor
tmp=repmat(1:nT1,nNN,1);
inds=int32(inds);
indH3 = t1(:,tmp(:))'*nF2 + t2(:,inds(:))';
valH3 = exp(-dists(:)/mean(dists(:)));

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







