function [e, A] = S_line(m)
    dim = m; %dim=2*dof
    A = sym('x_%d',[1 dim]);
    name=sprintf('monomials/monomial_%d.txt',m);
    e=sym(importdata(name)).';
    e=[1 e];
end