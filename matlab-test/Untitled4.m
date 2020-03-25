clc
clear
a=1;
d=5;
j=add2(a,d);
function [c]=add2(a,d)
if a==1
    c=2;
    return 
end
c=a+d;
end