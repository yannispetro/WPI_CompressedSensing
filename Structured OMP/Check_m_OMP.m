clc
clear all
close all

n = 210;
N_run = 100;

errors = zeros(n,3);
errALL = zeros(n,N_run);
for ex = 1:1
    load(['signals4/signal_' num2str(ex)])
%     k = 10+ex;
    k = 21+ex;
    for m = 5:n
        err = 0;
        for r = 1:N_run
            
            % % Create dictionary by deleting rows of an n x n random matrix
            A = create_A(n,m);

            % Compute the observations
            y = A*x0;

            % % % Preprocess data
            [A,normAi] = normalize(A);
            % y = center(y);

            x_hat = OMP(k,y.',A);
            x_hat = x_hat./normAi;
            
            errALL(m,r) = norm(x0-x_hat,2);
            
            err = err + norm(x0-x_hat,2);

        end
        errors(m,ex) = err/N_run;
        disp(num2str([ex m errors(m,ex)]))
    end
end

% save('errors_OMP_100_3_4','errors')
save('errorsALL_OMP','errALL')