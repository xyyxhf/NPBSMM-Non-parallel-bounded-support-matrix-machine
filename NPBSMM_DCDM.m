function alpha = NPBSMM_DCDM(H,f,c1,c2,alpha,eps,iter,n1,n2)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

rng(2);
nalpha=size(alpha,1);

lb1=-c1;ub1=c1;
lb2=0;ub2=c2;
lb=[lb1*ones(n1,1);lb2*ones(n2,1)];
ub=[ub1*ones(n1,1);ub2*ones(n2,1)];


k = 0;
count = 0;
% 停止准则：在一次外循环中所有的alpha都没有更新 或 达到最大迭代次数
% 还可以将前后两次的alpha相差很小作为停止准则
while count<nalpha && k<iter 
    count = 0;
    rng(2);
    for i = randperm(nalpha) 
        G = H(i,:)*alpha+f(i);
        if abs(alpha(i)-lb(i)) < eps
            PG = min(G,0);
        elseif abs(alpha(i)-ub(i)) < eps
            PG = max(G,0);
        elseif lb(i)<alpha(i) && alpha(i)<ub(i)
            PG = G;
        end
        if abs(PG-0) > eps
            alpha(i) = min(max(alpha(i)-G/H(i,i),lb(i)),ub(i));
        else
            count = count+1; % 记录一次外循环没有更新的变量的个数
        end    
    end
    k = k+1 ;
end

end