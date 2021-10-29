function a=Lsp_Az(lsp) 
%/*-------------------------------------------------------------* 
% *  Procedure Lsp_Az:                                          * 
% *            ~~~~~~                                           * 
% *   Compute the LPC coefficients from lsp (order=10)          * 
% *-------------------------------------------------------------*/ 
%  Word16 lsp[],    /* (i) Q15 : line spectral frequencies            */ 
%  Word16 a[]       /* (o) Q12 : predictor coefficients (order = 10)  */ 
 
%f1=zeros(1,6);%(-1,0,1,...,5) 
%f1(1)=1; 
%f1(2)=-2*lsp(1); 
k=2; 
pp=2; 
 
f1=zeros(1,7); 
f1(2)=1; 
for i=1:5 
    temp=f1; 
    f1(i+2)=-2*lsp(2*i-1)*f1(i+1)+2*f1(i); 
    for j=i-1:-1:1 
        f1(j+2)=temp(j+2)-2*lsp(2*i-1)*temp(j+1)+temp(j); 
    end 
end 
%round(f1*2^24)' 
 
 
 
f2=zeros(1,7); 
f2(2)=1; 
for i=1:5 
    temp=f2; 
    f2(i+2)=-2*lsp(2*i)*f2(i+1)+2*f2(i); 
    for j=i-1:-1:1 
        f2(j+2)=temp(j+2)-2*lsp(2*i)*temp(j+1)+temp(j); 
    end 
end 
%round(f2*2^24)' 
 
for i=5:-1:1 
    f1(i+2)=f1(i+2)+f1(i+1); 
    f2(i+2)=f2(i+2)-f2(i+1); 
end 
%round(f2*2^24)' 
 
a(1)=1; 
for i=2:6 
    a(i)=0.5*(f1(i+1)+f2(i+1)); 
end 
for i=7:11 
    a(i)=0.5*(f1(11-i+3)-f2(11-i+3)); 
end 