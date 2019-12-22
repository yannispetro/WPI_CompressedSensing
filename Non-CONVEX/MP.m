function [ x ] = MP( A,y,tol )
%MP Summary of this function goes here
%   Detailed explanation goes here
n = size(A,2);

% Initialization
k = 0;
x = zeros(n,1);
S = find(x);
r = y - A*x;

while (norm(r,2) > tol)
    k = k + 1;
    [ind,x_ind] = most_correlated(A,r);
    S(end+1) = ind;
    x(ind) = x(ind) + x_ind;
    r = r - A(:,ind)*x_ind;
    disp(norm(r,2));
end

end

