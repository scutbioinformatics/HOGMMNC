

cd ann_mwrapper
ann_compile_mex
cd ..

 %mex mexSource/mexComputeFeature_angle_distance_sample.cpp -output mex/mexComputeFeature_angle_distance_sample
 %mex mexSource/mexComputeFeature_angle_distance.cpp -output mex/mexComputeFeature_angle_distance
 mex mexSource/mexTensorMatching_prior_alpha.cpp -output mex/mexTensorMatching_prior_alpha
 


