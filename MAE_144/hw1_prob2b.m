%define b,a, and f as given in the problem statement.
%gradually add poles of s = -20 to f until diophantine gives a proper
%function
b = RR_poly([-2 2 -5 5],1), a = RR_poly([-1 1 -3 3 -6 6],1), f = RR_poly([-1 -1 -3 -3 -6 -6 -20 -20 -20 -20 -20 -20],1)
[x,y] = RR_diophantine(a,b,f)
test=trim(a*x+b*y), residual1=norm(f-test)