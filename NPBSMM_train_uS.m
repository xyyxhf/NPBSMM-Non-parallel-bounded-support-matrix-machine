function [A,B,S1]=NPBSMM_train_uS(Xtrain,V0,n1,n2)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

[m,n,mn]=size(Xtrain);

f=[];
for ij = 1:mn
    temp = Xtrain(:,:,ij)*V0;
    f = [f,temp(:)];  
end
clear temp ij;
temp = diag(V0'*V0);
temp = repmat(temp,1,m);
temp  =temp'; temp = temp(:);
S1 = diag(temp);      
clear temp;

f1=[];
for i=1:size(f,2)
    f1(:,i)=(S1^(-1/2))*f(:,i);
end

A=f1(:,1:n1);
B=f1(:,n1+1:n2+n1);

A=A';
B=B';
end
