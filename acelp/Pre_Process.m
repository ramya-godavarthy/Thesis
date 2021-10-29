function o=Pre_Process(speech) 
%speech－－－输入完整语音 
global x1 x2 y1 y2; 
 
b=[0.46363718 -0.92724705 0.46363718]; 
a=[1 1.9059465 -0.9114024]; 
 
for i=1:80 
    if i<=2 
        o(i)=b(1)*speech(i) + b(2)*x1 + b(3)*x2 + a(2)*y1 + a(3)*y2; 
        x2=x1; 
        x1=speech(i); 
        y2=y1; 
        y1=o(i); 
    else 
        o(i)=b(1)*speech(i) + b(2)*speech(i-1) + b(3)*speech(i-2) + a(2)*o(i-1) + a(3)*o(i-2); 
         
    end 
end 
 
x1=speech(end); 
x2=speech(end-1); 
y1=o(end); 
y2=o(end-1);%更新初时状态，用于下一次函数调用 
 
o=round(o);