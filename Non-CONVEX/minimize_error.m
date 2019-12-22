function [ j0 ] = minimize_error( err, S )
%MINIMIZE_ERROR Summary of this function goes here
%   Detailed explanation goes here
    n = length(err);
    min_val = inf;
    for j = 1:n 
        if ismember(j,S)
            continue
        elseif err(j) < min_val
            min_val = err(j);
            j0 = j;
        end
    end

end

