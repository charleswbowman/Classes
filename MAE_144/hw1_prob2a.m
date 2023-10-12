%define b, a, and f as defined in the problem statement
b = RR_poly([-2 2 -5 5],1), a = RR_poly([-1 1 -3 3 -6 6],1), f = RR_poly([-1 -1 -3 -3 -6 -6],1)
%Call diophantine
[x,y] = RR_diophantine(a,b,f)
%Check to see if it worked
test=trim(a*x+b*y), residual1=norm(f-test)