function [ ind ] = select_next_var_LS_OMP( y,A,S )
%SELECT_NEXT_VAR_LS_OMP Summary of this function goes here
%   Detailed explanation goes here
    n = size(A,2);

    min_val = inf;
    
    for i = 1:n
        S1 = S;
        S1(end+1) = i;
        x = zeros(n,1);
        x(S1) = A(:,S1)\y; %OLS fit %regress(y,A(:,S1));
        val = norm(y - A(:,S1)*x(S1),2)^2;
        if val < min_val
            min_val = val;
            ind = i;
        end
    end
end

