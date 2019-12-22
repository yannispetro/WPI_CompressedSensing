clc
clear all
close all

n = 210;
N_run = 50;

D = randn( n, n );
for i = 1:n
    D(:,i) = D(:,i) - mean(D(:,i));
    if norm(D(:,i),2) ~= 0
        D(:,i) = D(:,i)/norm(D(:,i),2);
    end
end

errors = zeros(n,6);
for ex = 1:3
    load(['signals4/signal_' num2str(ex)])
    n = length(x0);        % length of signal
    for m = 4:4:168
        err = 0;

        [phi, locations]=delete_rows(n, m);
        A = phi*D;

        % Compute the observations
        y = A*x0;
        
        for r = 1:N_run
            [b, info] = LAR(A, y);
            [n, nl] = size(b);
            
            min_tmp = 10000;
            for j = 1:nl
                x_tmp = b(:,j);
                err_tmp = norm(x0-x_tmp,2);
                if err_tmp < min_tmp
                    min_tmp = err_tmp;
                    bst = j;
                end
            end
            x_hat = b(:,bst);
            err = err + norm(x0-x_hat,2);
        end
        errors(m,ex) = err/N_run;
        disp(num2str([ex m errors(m,ex)]))
    end
end

save('errors50__LAR_6_2','errors')