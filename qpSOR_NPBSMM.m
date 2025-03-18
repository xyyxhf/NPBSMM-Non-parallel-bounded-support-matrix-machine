function bestalpha=qpSOR_NPBSMM(Q,f,alpha0,t,lb,ub,smallvalue)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

[m,n]=size(Q);
L=tril(Q);
E=diag(Q);
twinalpha=alpha0;

for j=1:n
    %     i=i+1;
    twinalpha(j,1)=alpha0(j,1)-(t/E(j,1))*(Q(j,:)*twinalpha(:,1)-f(j,:)+L(j,:)*(twinalpha(:,1)-alpha0));
    if twinalpha(j,1)<lb(j,1)
        twinalpha(j,1)=lb(j,1);
    elseif twinalpha(j,1)>ub(j,1)
        twinalpha(j,1)=ub(j,1);
    else
        
    end
end
alpha=[alpha0,twinalpha];
while norm(alpha(:,2)-alpha(:,1))>smallvalue
    for j=1:n
        twinalpha(j,1)=alpha(j,2)-(t/E(j,1))*(Q(j,:)*twinalpha(:,1)-f(j,:)+L(j,:)*(twinalpha(:,1)-alpha(:,2)));
        if twinalpha(j,1)<lb(j,1)
            twinalpha(j,1)=lb(j,1);
        elseif twinalpha(j,1)>ub(j,1)
            twinalpha(j,1)=ub(j,1);
        else
            
        end
    end
    alpha(:,1)=[];
    alpha=[alpha,twinalpha];
end

bestalpha=alpha(:,2);


