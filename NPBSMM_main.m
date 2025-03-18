function acc=NPBSMM_main(data_all,K,s,z,c1,c2,c3,c4,upsilon,eps,iter)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

Xtest=[];
ytest_label=[];
for i=1:z
    Xtest(:,:,(i-1)*0.5*s+1:i*0.5*s)=data_all(:,:,(i-1)*s+0.5*s+1:i*s);
    ytest_label((i-1)*0.5*s+1:i*0.5*s,1)=i;
end
a=0;
for number1=1:(z-1)
    for number2=(number1+1):z
       
        fprintf('number1 = %.f,number2=%.f\n',number1,number2);
        I=data_all(:,:,((number1-1)*s+1):((number1-1)*s+s*0.5));%正类
        J=data_all(:,:,((number2-1)*s+1):((number2-1)*s+s*0.5));%负类
        n1=size(I,3);
        n2=size(J,3);
        Xtrain=cat(3,I,J);
        [U1,V1,b1] = NPBSMM_trainU1V1(Xtrain,K,c1,c2,upsilon,eps,n1,n2,iter);
        [U2,V2,b2] = NPBSMM_trainU2V2(Xtrain,K,c3,c4,upsilon,eps,n1,n2,iter);

        a=a+1;
        pre = NPBSMM_predict(U1,U2,V1,V2,b1,b2,Xtest,number1,number2);
        pre_all(:,a)=pre;
    end
end
pre_final=[];
for i1=1:s*z*0.5
    table=tabulate(pre_all(i1,:));
    [maxCount,idx]=max(table(:,2));
    pre_final(i1,1)=table(idx);
end
acc=length(find(pre_final == ytest_label))/length(ytest_label);
end