function [V,b]=NPBSMM_train_V2b2(A,B,S1,eps,K,c1,c2,n,n1,n2,iter)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

e1=ones(n1,1);
e2=ones(n2,1);
D11=A*A';e11=e1*e1';
D12=A*B';e12=e1*e2';
D21=B*A';e21=e2*e1';
D22=B*B';e22=e2*e2';
D1=[D11,D12;D21,D22];
E1=[e11,e12;e21,e22];
D=D1+E1;
%-------------------------------DCD----
% lb1=-c1;ub1=c1;
% lb2=0;ub2=c2;
% alpha1 = lb1+(ub1-lb1)*rand(n1,1);
% alpha2 = lb2+(ub2-lb2)*rand(n2,1);
% alpha=[alpha1',alpha2'];
% 
% H=D;
% ff1=zeros(n1,1);
% ff=[ff1;e2];
% alpha = NPBSMM_DCDM(H,ff,c1,c2,alpha',eps,iter,n1,n2);
%-------------------------------SOR
lb1=-c1;ub1=c1;
lb2=0;ub2=c2;
lb=[lb1*ones(n1,1);lb2*ones(n2,1)];
ub=[ub1*ones(n1,1);ub2*ones(n2,1)];
alpha1 = lb1+(ub1-lb1)*rand(n1,1);
alpha2 = lb2+(ub2-lb2)*rand(n2,1);
alpha=[alpha1;alpha2];
H=D;
ff1=zeros(n1,1);
ff=[ff1;e2];
alpha=qpSOR_NPBSMM(H,ff,alpha,0.5,lb,ub,0.05);
%----------------------------quadprog---
% H=D;
% ff1=zeros(n1,1);
% ff=[ff1;e2];
% Aeq=[];
% Beq=[];
% lb1=-c1;ub1=c1;
% lb2=0;ub2=c2;
% lb=[lb1*ones(n1,1);lb2*ones(n2,1)];
% ub=[ub1*ones(n1,1);ub2*ones(n2,1)];
% alpha = quadprog(H,-ff,[],[],Aeq,Beq,lb,ub);

v = A'*alpha(1:n1,:)+B'*alpha(n1+1:n2+n1,:);
V = S1^(-1/2)*v;
V =reshape(V,n,K);
b = e1'*alpha(1:n1,:)+e2'*alpha(n1+1:n2+n1,:);

end