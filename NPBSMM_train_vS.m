function [A,B,S1]=NPBSMM_train_vS(Xtrain,U0,n1,n2)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

[m,n,mn]=size(Xtrain);
g=[];
for ij = 1:mn
    temp = Xtrain(:,:,ij)'*U0;
    g = [g,temp(:)];  
end
clear temp ij;
temp = diag(U0'*U0);
temp = repmat(temp,1,n);
temp  =temp'; temp = temp(:);
S1 = diag(temp);     
clear temp;

g1=[];
for i=1:size(g,2)
    g1(:,i)=(S1^(-1/2))*g(:,i);
end

A=g1(:,1:n1);
B=g1(:,n1+1:n2+n1);

A=A';
B=B';
end
