function [t1,t2,nT1,nT2] =Generate_tuples(P1,P2,nF1,nF2,index)
if index==1
        % This part is taken from Duchenne's code
        nT1 = nF1*nF1; % # of triangles in graph 1
        t1=floor(rand(3,nT1)*nF1);
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
        
        nT2=nF2*nF2*nF2;
        t2=zeros(3,nT2);
        tt=1;
        for i=1:nF2
            for j=1:nF2
                for k=1:nF2
                    if i~=j&&j~=k
                        t2(1,tt)=i;
                        t2(2,tt)=j;
                        t2(3,tt)=k;
                        tt=tt+1;
                    end
                end
            end
        end
        t2=t2-1;
end       
if index==2
        % This part is designed by ours(time complexity is O(kdn))
        randomSize=10;
        knnSize=5;
        t1=zeros(3,nF1);
        l=1;
        for i=1:nF1
            temp=P1(:,i);
            [inds,dists] = annquery(P1,temp, knnSize+1);
            for j=1:knnSize
                temp1=floor(rand(randomSize,1)*nF1);
                for k=1:randomSize
                    index1=i;
                    index2=inds(j+1);
                    index3=temp1(k);
                    if index1~=index2&&index2~=index3
                        t1(1,l)=index1;
                        t1(2,l)=index2;
                        t1(3,l)=index3;
                        l=l+1;
                    end
                end
            end
        end
        nT1=l-1;
        t1(1:2,:)=t1(1:2,:)-1;       
clear inds dists
        randomSize=10;
        knnSize=5;
        t2=zeros(3,nF2);
        l=1;
        for i=1:nF2
            temp=P2(:,i);
            [inds,dists] = annquery(P2,temp, knnSize+1);
            for j=1:knnSize
                temp1=floor(rand(randomSize,1)*nF2);
                for k=1:randomSize
                    index1=i;
                    index2=inds(j+1);
                    index3=temp1(k);
                    if index1~=index2&&index2~=index3
                    t2(1,l)=index1;
                    t2(2,l)=index2;
                    t2(3,l)=index3;
                    l=l+1;
                    end
                end
            end
        end
        nT2=l-1;
        t2(1:2,:)=t2(1:2,:)-1; 
end
clear inds dists
if index==3
        % This part is designed by ochs(time complexity is O(n*n))
        randomSize=4;
        knnSize=4;
        t1=zeros(3,nF1);
        m=0;
        for i=1:nF1
            for j=i+1:nF1
                temp1=P1(:,i);
                temp2=P1(:,j);
                [inds1,dists1] = annquery(P1,temp1, knnSize+1);
                [inds2,dists2] = annquery(P1,temp2, knnSize+1);
                for k=1:knnSize
                    if i~=j&&j~=inds1(k+1)
                    m=m+1;
                    t1(1,m)=i;
                    t1(2,m)=j;
                    t1(3,m)=inds1(k+1);
                    end
                end
                for k=1:knnSize
                    if i~=j&&j~=inds2(k+1)
                    m=m+1;
                    t1(1,m)=i;
                    t1(2,m)=j;
                    t1(3,m)=inds2(k+1);
                    end
                end
                temp=ceil(rand(randomSize,1)*nF1);
                for l=1:randomSize
                    if i~=j&&j~=temp(l)
                    m=m+1;
                    t1(1,m)=i;
                    t1(2,m)=j;
                    t1(3,m)=temp(l);
                    end
                end
            end
        end
        nT1=m;
        t1=t1-1;      
clear inds dists
        randomSize=4;
        knnSize=4;  
        t2=zeros(3,nF2);
        m=0;
        for i=1:nF2
            for j=i+1:nF2
                temp1=P2(:,i);
                temp2=P2(:,j);
                [inds1,dists1] = annquery(P2,temp1, knnSize+1);
                [inds2,dists2] = annquery(P2,temp2, knnSize+1);
                for k=1:knnSize
                    if i~=j&&j~=inds1(k+1)
                    m=m+1;
                    t2(1,m)=i;
                    t2(2,m)=j;
                    t2(3,m)=inds1(k+1);
                    end
                end
                for k=1:knnSize
                    if i~=j&&j~=inds2(k+1)
                    m=m+1;
                    t2(1,m)=i;
                    t2(2,m)=j;
                    t2(3,m)=inds2(k+1);
                    end
                end
                temp=ceil(rand(randomSize,1)*nF1);
                for l=1:randomSize
                    if i~=j&&j~=temp(l)
                    m=m+1;
                    t2(1,m)=i;
                    t2(2,m)=j;
                    t2(3,m)=temp(l);
                    end
                end
            end
        end
        nT2=m;
        t2=t2-1;
end
clear inds dists
end

        






