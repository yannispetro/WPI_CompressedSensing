function [ ind,x_ind ] = most_correlated( A,r )
%MOST_CORRELATED Summary of this function goes here
%   Detailed explanation goes here
m = size(A,1);
n = size(A,2);

x_ind = 0;

for i = 1:n
    val = A(:,i)'*r;
    if val > x_ind
        x_ind = val;
        ind = i;
    end
end

end

