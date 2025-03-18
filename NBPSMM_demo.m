% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

clear;
clc;
load('./AHUT-7class.mat')
upsilon=1e-7 ;
eps=1e-14;
iter=500;
c1=10;
c2=5;
c3=c1;
c4=c2;
K=1;
acc=NPBSMM_main(data_all,K,s,z,c1,c2,c3,c4,upsilon,eps,iter);




