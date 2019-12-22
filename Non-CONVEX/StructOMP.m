function [ x ] = StructOMP( BB,c,A,y,s )
%OMP Summary of this function goes here
%   Detailed explanation goes here
    n = size(A,2);
    ng = length(BB);

    
    % Init
    F = [];
    x_hat = zeros(n,1);
    comp = 0;
    
    k = 0;
    x = zeros(n,1);
%     S = find(x);
%     r = y - A*x;
	sup=[];
    while (comp <= s)
        k = k + 1;
        max_gr = 0;
        ind_max_gr = 1;

        for jj = 1:ng
            
            gr = gain_ratio( BB(jj),c(jj),A,x_hat,y );
            
            if gr > max_gr
                max_gr = gr;
                ind_max_gr = jj;
            end
            
        end
        
        pause()
        
        F{k} = BB(ind_max_gr);
        sup=cat(2,sup,F(k));  
        
        x_hat = zeros(n,1);
        
        x_hat(sup) = A(:,sup)\y; % OLS fit %regress(y,A(:,S));
%         r = y - A*x;
    end

end

