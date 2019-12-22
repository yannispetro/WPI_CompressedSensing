function [ x ] = OMP( A,y,tol )
%OMP Summary of this function goes here
%   Detailed explanation goes here
    n = size(A,2);

    k = 0;
    x = zeros(n,1);
    S = find(x);
    r = y - A*x;

    while (norm(r,2) > tol)
        k = k + 1;
        err = errors(A,r);
        j0 = minimize_error(err, S);
        S(end+1) = j0;
        x = zeros(n,1);
        x(S) = A(:,S)\y; % OLS fit %regress(y,A(:,S));
        r = y - A*x;
    end

end

