function [U1,V1,b1]=NPBSMM_trainU1V1(Xtrain,K,c1,c2,upsilon,eps,n1,n2,iter) 
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

NUM=1;
[m,n,mn]=size(Xtrain);
function1_value=[];
V0 = [eye(K); zeros(m-K,K)];
for i=1:NUM
    [A,B,S1]=NPBSMM_train_uS(Xtrain,V0,n1,n2);
    [U0,~]=NPBSMM_train_U1b1(A,B,S1,eps,K,c1,c2,m,n1,n2,iter);
    [A,B,S1]=NPBSMM_train_vS(Xtrain,U0,n1,n2);
    [V1,b11]=NPBSMM_train_V1b1(A,B,S1,eps,K,c1,c2,n,n1,n2,iter);
    [A,B,S1]=NPBSMM_train_uS(Xtrain,V1,n1,n2);
    [U1,b12]=NPBSMM_train_U1b1(A,B,S1,eps,K,c1,c2,m,n1,n2,iter);
    b1=(b11+b12)/2;
    if(( norm(U1*V1'-U0*V0')<=upsilon ))
        return
    end
    V0=V1;
end
clear i U0 V0 S1
end





