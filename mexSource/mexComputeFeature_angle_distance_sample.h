/* feat1 feat2 <- P1 P2 t1 type */

void computeFeatureSimple( double* pP1, int i , int j, int k , double* pF);
void computeFeature( double* pP1 , int nP1 , double* pP2 , int nP2 ,
                      int* pT1 , int nT1 , int* pT2 , int nT2 , double* pF1 , double* pF2);

void computeFeature( double* pP1 , int nP1 , double* pP2 , int nP2 ,
                      int* pT1 , int nT1 , int* pT2 , int nT2 , double* pF1 , double* pF2)
{ 
  const int nFeature=6;
  for(int t=0;t<nT1;t++)
  {
    computeFeatureSimple(pP1,pT1[t*3],pT1[t*3+1],pT1[t*3+2],pF1+t*nFeature);
  }
  
//   for(int i=0;i<nP2;i++)
//     for(int j=0;j<nP2;j++)
//       for(int k=0;k<nP2;k++)
//           computeFeatureSimple(pP2,i,j,k,pF2+((i*nP2+j)*nP2+k)*nFeature);
    for(int t=0;t<nT2;t++)
  {
    computeFeatureSimple(pP2,pT2[t*3],pT2[t*3+1],pT2[t*3+2],pF2+t*nFeature);
  }
}

void computeFeatureSimple( double* pP1, int i , int j, int k , double* pF)
{ 
  const int nFeature=3;
  const int eachfeature=60;
  double threevec[nFeature][eachfeature];
  double threenorm[nFeature];
  int ind[nFeature];
  ind[0]=i;ind[1]=j;ind[2]=k;
  double n;
  if((ind[0]==ind[1])||(ind[0]==ind[2])||(ind[1]==ind[2]))
  {
    pF[0]=pF[1]=pF[2]=-10;
    return;
  }
  //calculate the distance between two vetors
  for(int f=0;f<nFeature;f++)
  {
      double sum=0;      
      for(int l=0;l<eachfeature;l++)
      {
          threevec[f][l]=pP1[ind[((f+1)%3)]*eachfeature+l]-pP1[ind[f]*eachfeature+l];
          sum=sum+threevec[f][l]*threevec[f][l];
      }
      threenorm[f]=sqrt(sum);
//       pF[f]=threenorm[f];
  }
  //calculate the angle between two vetors
  for(int f=0;f<nFeature;f++)
  {
      double sum=0;
      for(int l=1;l<eachfeature;l++)
      {
          sum=sum+threevec[((f+1)%3)][l]*threevec[f][l];
      }
      if(threenorm[((f+1)%3)]*threenorm[f]!=0)
      {
          pF[f]=sum/(threenorm[((f+1)%3)]*threenorm[f]);
      }
      else
      {
          pF[f]=1;
      }
  }
  for(int f=3;f<6;f++)
  {
      pF[f]=threenorm[f-3];
  }
}
















