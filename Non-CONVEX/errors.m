function [ err ] = errors( A,r )
%ERRORS Summary of this function goes here
%   Detailed explanation goes here
    n = size(A,2);
    err = zeros(n,1);
    for j = 1:n
        err(j) = norm(A(:,j)'*r/(norm(A(:,j),2)^2)*A(:,j) - r,2)^2;
    end

end

