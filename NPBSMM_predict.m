function  pre = NPBSMM_predict(U1,U2,V1,V2,b1,b2,Xtest,number1,number2)
% Haifeng Xu, Anhui University of Technology, January 2023. 
% Contact information: see readme.txt.
%
% Reference: 
% Pan, H., Xu, H., Zheng, J., & Tong, J. (2023). Non-parallel bounded support matrix machine 
% and its application in roller bearing fault diagnosis. Information Sciences..
% 
% First written by Haifeng Xu, Anhui Universiy of Technology, October 2021.

uv1=U1*V1';
uv2=U2*V2';
sz1=size(uv1);
sz2=size(uv2);
aa=reshape(uv1,[1,sz1(1)*sz1(2)]);
bb=reshape(uv2,[1,sz2(1)*sz2(2)]);
for i1=1:size(Xtest,3)
    F=Xtest(:,:,i1);
    
    temp1=(abs(trace(U1'*F*V1)+b1))/norm(aa);
    temp2=(abs(trace(U2'*F*V2)+b2))/norm(bb);
    
    if(temp1<=temp2)
        pre(i1,1)=number1;
    else
        pre(i1,1)=number2;
    end
end
end