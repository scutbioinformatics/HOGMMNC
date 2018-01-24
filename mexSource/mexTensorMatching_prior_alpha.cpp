


/*  X indH valH  -> Xout */


#include "mex.h"
#include "math.h"
#include "mexOliUtil.h"

#include "mexTensorMatching_prior_alpha.h"

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )
{ 
  enum{ Xi , indH1i , valH1i , indH2i , valH2i , indH3i , valH3i ,indPT1, valPT1, indPT2, valPT2,nIteri, sparsei, stoci,alpha};
  enum{ Xouti , scoreOuti};
  oliCheckArgNumber(nrhs,15,nlhs,2);
  int Nt1,Nt2,Nt3,N1,N2,m1,m2;
  double* pX = oliCheckArg(prhs,Xi,&N1,&N2,oliDouble);
  int* pIndH1 = (int*)oliCheckArg(prhs,indH1i,&Nt1,1,oliInt);
  double* pValH1 = oliCheckArg(prhs,valH1i,Nt1,1,oliDouble);
  int* pIndH2 = (int*)oliCheckArg(prhs,indH2i,&Nt2,2,oliInt);
  double* pValH2 = oliCheckArg(prhs,valH2i,Nt2,1,oliDouble);
  int* pIndH3 = (int*)oliCheckArg(prhs,indH3i,&Nt3,3,oliInt);
  double* pValH3 = oliCheckArg(prhs,valH3i,Nt3,1,oliDouble);
  int* pIndPT1 = (int*)oliCheckArg(prhs,indPT1,&m1,3,oliInt);
  double* pValPT1 = oliCheckArg(prhs,valPT1,m1,1,oliDouble);
  int* pIndPT2 = (int*)oliCheckArg(prhs,indPT2,&m2,3,oliInt);
  double* pValPT2 = oliCheckArg(prhs,valPT2,m2,1,oliDouble);
  double* pNIter = oliCheckArg(prhs,nIteri,1,1,oliDouble);
  double* pSparse = oliCheckArg(prhs,sparsei,1,1,oliDouble);
  double* pStoc = oliCheckArg(prhs,stoci,1,1,oliDouble);
  double* palpha = oliCheckArg(prhs,alpha,2,1,oliDouble);


  plhs[Xouti] = mxCreateDoubleMatrix(N1, N2, mxREAL);
  double* pXout = mxGetPr(plhs[Xouti]);
  
  plhs[scoreOuti] = mxCreateDoubleMatrix(1, 1, mxREAL);
  double* pScoreOut = mxGetPr(plhs[scoreOuti]);

  tensorMatching(pX,N1,N2,pIndH1,pValH1,Nt1,pIndH2,pValH2,Nt2,pIndH3,pValH3,Nt3,pIndPT1,pValPT1,m1,pIndPT2,pValPT2,m2,(int)(*pNIter),(int)(*pSparse),(int)(*pStoc),palpha,pXout,pScoreOut);


  
}














