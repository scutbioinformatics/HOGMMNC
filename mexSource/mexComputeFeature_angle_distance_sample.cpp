/* feat1 feat2 <- P1 P2 t1 type */
#include "mex.h"
#include "math.h"
#include "mexOliUtil.h"
#include <stdlib.h>
#include <time.h>

#include "mexComputeFeature_angle_distance_sample.h"

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )
{ 
  enum{ P1i , P2i , t1i , t2i, typei };
  enum{ feat1i , feat2i };
  
  oliCheckArgNumber(nrhs,5,nlhs,2);
  int nP1,nP2,nT1,nT2;
  double* pP1 = oliCheckArg(prhs,P1i,60,&nP1,oliDouble);
  double* pP2 = oliCheckArg(prhs,P2i,60,&nP2,oliDouble);
  int* pT1 = (int*)oliCheckArg(prhs,t1i,3,&nT1,oliInt);
  int* pT2 = (int*)oliCheckArg(prhs,t2i,3,&nT2,oliInt);

  const int nFeature=6;
  plhs[feat1i] = mxCreateDoubleMatrix(nFeature, nT1, mxREAL);
  double* pF1 = mxGetPr(plhs[feat1i]);
  plhs[feat2i] = mxCreateDoubleMatrix(nFeature, nT2, mxREAL);
  double* pF2 = mxGetPr(plhs[feat2i]);
  
  computeFeature(pP1,nP1,pP2,nP2,pT1,nT1,pT2,nT2,pF1,pF2);

}

