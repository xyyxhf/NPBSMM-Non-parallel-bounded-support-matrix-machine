function [U2,V2,b2]=NPBSMM_trainU2V2(Xtrain,K,c3,c4,upsilon,eps,n1,n2,iter)
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
V0 = [eye(K); zeros(n-K,K)];
for i=1:NUM
    [A,B,S1]=NPBSMM_train_uS(Xtrain,V0,n1,n2);
    [U0,~]=NPBSMM_train_U2b2(B,A,S1,eps,K,c3,c4,m,n2,n1,iter);
    [A,B,S1]=NPBSMM_train_vS(Xtrain,U0,n1,n2);
    [V2,b21]=NPBSMM_train_V2b2(B,A,S1,eps,K,c3,c4,n,n2,n1,iter);
    [A,B,S1]=NPBSMM_train_uS(Xtrain,V2,n1,n2);
    [U2,b22]=NPBSMM_train_U2b2(B,A,S1,eps,K,c3,c4,m,n2,n1,iter);
    b2=(b21+b22)/2;
    if(( norm(U2*V2'-U0*V0')<=upsilon ))
        return
    end
    V0=V2;
end
end
