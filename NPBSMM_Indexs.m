function [acc_test,kappa_test,recall,F1score,precision]=NPBSMM_Indexs(actual,predict,numClass)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

y_test=actual;
y_test_hat=predict;

for i = 1:numClass
    tp(i) = length(find(y_test_hat == i & y_test == i));
    fp(i) = length(find(y_test_hat == i)) - tp(i);
    fn(i) = length(find(y_test == i)) - tp(i);
    precision_all(i) = tp(i)/(tp(i)+fp(i));
    recall_all(i) = tp(i)/(tp(i)+fn(i));
    acc_class(i) = length(find(y_test_hat == i & y_test == i))/length(find(y_test==i));
    kappa_class(i) = (acc_class(i) - 1/numClass)/(1-1/numClass);
end
acc_test=length(find(y_test_hat == y_test))/length(y_test);
kappa_test = (acc_test - 1/numClass)/(1-1/numClass);
precision = sum(precision_all)/numClass;
recall = sum(recall_all)/numClass;
F1score = 2*precision*recall/(precision+recall);