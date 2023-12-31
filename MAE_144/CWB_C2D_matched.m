%Inputs:
%b - an array of the roots of the numerator of the transfer function in
%the s domain
%a - an array of the roots of the denominator of the tranfer function in
%the s domain
%h - the sample interval
%iomega - adjusts the gain
%casuality - default is semi-casual(n = m). You input what you want for (n - m), 

%Outputs: 
%Dz_num = the numerator of the corresponding z transform
%Dz_den = the denominator of the corresponding z transform
function [Dz_num, Dz_den] = CWB_C2D_matched(b,a,h,omega,casuality)
%default omega is 0, meaning no pre-warpping
% default casuality is semi-proper (n = m)
%enables symbols
syms s z p 
%Sets default values for omega and a semi-proper system if no arguments are
%inputted for these values
if nargin == 3, omega = 0, casuality = 0
end

if nargin ==4, casuality = 0 
end
i = sqrt(-1)
%This defines the value for iomega
iomega = i * omega
%Here we substitue the value for s inside the array of zeros and poles
%we can do this by adding iomega to each term
y =  -b + iomega
x =  -a + iomega
%to get the gain we evaluate at this value , essentially taking the product
%of each term
y31 = prod(y)
x31 = prod(x)
y3 = (y31).^2
x3 = (x31).^2
%this represents the gain in the s domain
k1 = sqrt(y3) / sqrt(x3)
%This transforms the zeros to the Z domain using the relation, 
% z =exp(1)^(s*h)
for i = 1:length(b)
    d(i) = exp(1).^(b(i)*h)
end
%This transforms the poles to the Z domain using the relation, 
% z = exp(1)^(s*h)
for i = 1:length(a)
    c(i) = exp(1).^(a(i)*h)
end
q = length(d)
%This maps infinite zeros to z = -1 by adding a zero of z = -1 to the
%numerator
if length(c) > length(d),
    for i = 1:(length(c) - length(d)- 1*casuality)
        d(q+ i) = -1
    end
else
    d = d
end
   

%Here we plugging in exp^iomega*h for z, to solve for the gain
y2 = -d + exp(iomega*h)
x2 = -c + exp(iomega*h)
yyy = prod(y2).^2 
xxx = prod(x2).^2
k2 = sqrt(yyy) / sqrt(xxx)

%this relates the s domain and z domain gains
k = k1 / k2
syms z 
%Here we subtract z by the c and d array, in order to set it up for the
%prod function
FF = z-d
DD = z-c
%Final outputs
Dz_num = k * prod(FF)

DZ_den = prod(DD)
end

